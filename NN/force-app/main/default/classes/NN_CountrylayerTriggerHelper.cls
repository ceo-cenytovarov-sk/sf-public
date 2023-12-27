/**
 * @Author       Jozef Birka
 * @Date         12/27/2023
 * @description  Trigger Helper for Countrylayer.
 **/
public with sharing class NN_CountrylayerTriggerHelper {
    /**
     * @Author       Jozef Birka
     * @Date         12/27/2023
     * @description  updates Lead based on changes in Copuntrylayer. Matches Country field agains values in Name, Alpha2code or Alpha3code and overrides it with Name. Applying some kind of fuzzy match.
     * @params       newList, newMap, oldList, oldMap
     **/
    public static void updateLeads(
        List<sObject> newList,
        Map<Id, sObject> newMap,
        List<sObject> oldList,
        Map<Id, sObject> oldMap
    ) {
        try {
            Set<String> countrySet = new Set<String>();
            Map<String, String> countrySetToNameMap = new Map<String, String>();
            List<Lead> leadsToUpdateList = new List<Lead>();
            for (NN_Countrylayer__c countryLayer : (List<NN_Countrylayer__c>) newList) {
                countrySet.add(countryLayer.Alpha2code__c);
                countrySet.add(countryLayer.Alpha2code__c.toLowerCase());
                countrySet.add(countryLayer.Alpha3code__c);
                countrySet.add(countryLayer.Alpha3code__c.toLowerCase());
                countrySet.add(countryLayer.Name.toLowerCase());
                countrySet.add(countryLayer.Name.toUpperCase());
                countrySetToNameMap.put(countryLayer.Alpha2code__c, countryLayer.Name);
                countrySetToNameMap.put(countryLayer.Alpha2code__c.toLowerCase(), countryLayer.Name);
                countrySetToNameMap.put(countryLayer.Alpha3code__c, countryLayer.Name);
                countrySetToNameMap.put(countryLayer.Alpha3code__c.toLowerCase(), countryLayer.Name);
                countrySetToNameMap.put(countryLayer.Name.toLowerCase(), countryLayer.Name);
                countrySetToNameMap.put(countryLayer.Name.toUpperCase(), countryLayer.Name);
            }

            if (!countrySet.isEmpty()) {
                for (Lead ld : [SELECT Id, Country FROM Lead WHERE Country IN :countrySet]) {
                    if (countrySetToNameMap.containsKey(ld.Country)) {
                        Lead leadToUpdate = new Lead(Id = ld.Id, Country = countrySetToNameMap.get(ld.Country));
                        leadsToUpdateList.add(leadToUpdate);
                    }
                }
            }

            if (!leadsToUpdateList.isEmpty()) {
                Database.update(leadsToUpdateList, false);
            }
        } catch (Exception exc) {
            //custom logging or handling of errors goes here
            System.debug('NN_CountrylayerTriggerHelper updateLeads error: ' + exc);
        } finally {
            //custom processing
        }
    }
}
