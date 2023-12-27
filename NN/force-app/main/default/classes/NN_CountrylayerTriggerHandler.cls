/**
 * @Author       Jozef Birka
 * @Date         12/27/2023
 * @description  Trigger Handler for Countrylayer.
 **/
public with sharing class NN_CountrylayerTriggerHandler implements NN_TriggerHandler {
    /*public void beforeInsert(List<SObject> newList) {
        return;
    }

    public void beforeUpdate(
        List<sObject> newList,
        Map<Id, sObject> newMap,
        List<sObject> oldList,
        Map<Id, sObject> oldMap
    ) {
        return;
    }

    public void beforeDelete(List<sObject> oldList, Map<Id, sObject> oldMap) {
        return;
    }*/

    public void afterInsert(List<sObject> newList, Map<Id, sObject> newMap) {
        NN_CountrylayerTriggerHelper.updateLeads(
            newList,
            newMap,
            new List<NN_Countrylayer__c>(),
            new Map<Id, NN_Countrylayer__c>()
        );
    }

    public void afterUpdate(
        List<sObject> newList,
        Map<Id, sObject> newMap,
        List<sObject> oldList,
        Map<Id, sObject> oldMap
    ) {
        NN_CountrylayerTriggerHelper.updateLeads(newList, newMap, oldList, oldMap);
    }

    /*public void afterDelete(List<sObject> oldList, Map<Id, sObject> oldMap) {
        return;
    }

    public void afterUndelete(List<sObject> newList, Map<Id, sObject> newMap) {
        return;
    }*/
}
