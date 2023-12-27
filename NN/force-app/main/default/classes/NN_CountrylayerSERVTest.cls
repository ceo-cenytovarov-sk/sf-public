/**
 * @author      Jozef Birka
 * @date        12/26/2023
 * @description NN_CountrylayerSERV test class
 */

@IsTest
public with sharing class NN_CountrylayerSERVTest {
    @TestSetup
    static void setup() {
        NN_Token__c integrationCS = new NN_Token__c();
        integrationCS.Token__c = '123456789';
        integrationCS.Url__c = 'http://api.countrylayer.com/v2';
        integrationCS.Name = 'Countrylayer';
        Database.Insert(integrationCS);

        Lead ld = new Lead();
        ld.LastName = 'Navorsky';
        ld.Company = 'Sprinkle business';
        ld.Country = 'ZWE';
        Database.Insert(ld);
    }

    @IsTest
    static void calloutAllSuccessTest() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new NN_CountrylayerMockSuccess());
        NN_CountrylayerSERV countryLayerSERV = new NN_CountrylayerSERV();
        countryLayerSERV.calloutAll();
        List<NN_Countrylayer__c> countryLayerList = [SELECT Id FROM NN_Countrylayer__c];
        Assert.areEqual(2, countryLayerList.size());
        Test.stopTest();
    }

    @IsTest
    static void calloutAllFailedTest() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new NN_CountrylayerMockFailed());
        NN_CountrylayerSERV countryLayerSERV = new NN_CountrylayerSERV();
        countryLayerSERV.calloutAll();
        List<NN_Countrylayer__c> countryLayerList = [SELECT Id FROM NN_Countrylayer__c];
        Assert.areEqual(0, countryLayerList.size());
        Test.stopTest();
    }
}
