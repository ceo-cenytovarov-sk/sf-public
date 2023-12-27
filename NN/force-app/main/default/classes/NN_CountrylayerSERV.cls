/**
 * @Author       Jozef Birka
 * @Date         12/26/2023
 * @description  Countrylayer specific class for callouts, processing response and sync response to database
 **/
public with sharing class NN_CountrylayerSERV {
	private List<NN_Countrylayer__c> countrylayerList = new List<NN_Countrylayer__c>();
	private Set<NN_RegionalBlock_DTO> regionalblockSet = new Set<NN_RegionalBlock_DTO>();
	private Set<String> alpha2codeToAcronymSet = new Set<String>();

	public void calloutAll() {
		try {
			Map<String, String> headerData = new Map<String, String>();
			Map<String, String> formData = new Map<String, String>();
			NN_Token__c countryLayerCS = NN_Token__c.getValues('Countrylayer');
			formData.put('access_key', countryLayerCS.Token__c);
			String resp = new NN_IntegrationUtility()
				.calloutAndGetResponse(countryLayerCS.Url__c, headerData, formData, 'GET', '/all');
			deserializeResponse(resp);
		} catch (Exception e) {
			//custom logging will go here
			system.debug('CountryLayer calloutAll error: ' + e);
		} finally {
			//custom processing
		}
	}

	private void deserializeResponse(String response) {
		try {
			List<NN_CountryLayerAll_DTO> respDeserialized = (List<NN_CountryLayerAll_DTO>) JSON.deserialize(
				response,
				List<NN_CountryLayerAll_DTO>.class
			);

			for (NN_CountryLayerAll_DTO country : respDeserialized) {
				NN_Countrylayer__c countrylayer = new NN_Countrylayer__c();
				countrylayer.Name = country.name;
				countrylayer.Alpha2code__c = country.alpha2code;
				countrylayer.Alpha3code__c = country.alpha3code;
				countrylayer.Capital__c = country.capital;
				countrylayer.Region__c = country.region;
				countrylayerList.add(countrylayer);
				//System.debug('countrylayer: ' + countrylayer);

				if (country.regionalBlocs != null) {
					for (NN_RegionalBlock_DTO regblock : country.regionalBlocs) {
						regionalblockSet.add(regblock);
						alpha2codeToAcronymSet.add(country.alpha2code + '_' + regblock.acronym);
					}
				}
			}
			syncResultToDB();
		} catch (Exception e) {
			NN_CountryLayerAll_DTO respDeserializedError = (NN_CountryLayerAll_DTO) JSON.deserialize(
				response,
				NN_CountryLayerAll_DTO.class
			);
			//write processing for different types of errors
			if (respDeserializedError.success != null && !(Boolean) respDeserializedError.success) {
				//System.debug('respDeserializedError: ' + respDeserializedError);
			}
		}
	}

	private void syncResultToDB() {
		List<NN_RegionalBlock__c> regionalblockList = new List<NN_RegionalBlock__c>();
		List<NN_Countrylayer2RegionalBlock__c> country2blockList = new List<NN_Countrylayer2RegionalBlock__c>();
		Map<String, Id> alpha2codeToId = new Map<String, Id>();
		Map<String, Id> acronymToId = new Map<String, Id>();

		Database.UpsertResult[] resultsCountrylayerList = Database.upsert(
			countrylayerList,
			NN_Countrylayer__c.Alpha2code__c,
			false
		);
		for (Integer index = 0, size = resultsCountrylayerList.size(); index < size; index++) {
			if (resultsCountrylayerList[index].isSuccess()) {
				alpha2codeToId.put(countrylayerList[index].Alpha2code__c, resultsCountrylayerList[index].getId());
			}
		}
		//select Name, Alpha2code__c, Alpha3code__c, Capital__c, Region__c from NN_Countrylayer__c //250

		for (NN_RegionalBlock_DTO regblock : regionalblockSet) {
			NN_RegionalBlock__c rb = new NN_RegionalBlock__c();
			rb.Name = regblock.acronym;
			rb.Acronym__c = regblock.acronym;
			regionalblockList.add(rb);
		}

		Database.UpsertResult[] resultsRegionalBlockList = Database.upsert(
			regionalblockList,
			NN_RegionalBlock__c.Acronym__c,
			false
		);
		for (Integer index = 0, size = resultsRegionalBlockList.size(); index < size; index++) {
			if (resultsRegionalBlockList[index].isSuccess()) {
				acronymToId.put(regionalblockList[index].Acronym__c, resultsRegionalBlockList[index].getId());
			}
		}
		//select Name, Acronym__c from NN_RegionalBlock__c

		List<NN_Countrylayer2RegionalBlock__c> country2blockDeleteList = [
			SELECT Id
			FROM NN_Countrylayer2RegionalBlock__c
			WHERE Alpha2codeToAcronym__c NOT IN :alpha2codeToAcronymSet
		];
		delete country2blockDeleteList;

		for (String alpha2codeToAcronym : alpha2codeToAcronymSet) {
			NN_Countrylayer2RegionalBlock__c country2block = new NN_Countrylayer2RegionalBlock__c();
			country2block.Countrylayer__c = alpha2codeToId.get(alpha2codeToAcronym.substringBefore('_'));
			country2block.RegionalBlock__c = acronymToId.get(alpha2codeToAcronym.substringAfter('_'));
			country2block.Alpha2codeToAcronym__c = alpha2codeToAcronym;
			country2blockList.add(country2block);
		}
		Database.UpsertResult[] resultsCountryLayerToRegionalBlockList = Database.upsert(
			country2blockList,
			NN_Countrylayer2RegionalBlock__c.Alpha2codeToAcronym__c,
			false
		);
	}
}
