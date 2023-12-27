/**
 * @Author:       Jozef Birka
 * @Date :        12/27/2023
 * @description Trigger handler interface
 **/
public interface NN_TriggerHandler {
    //void beforeInsert(List<SObject> newList);
    //void beforeUpdate(List<sObject> newList, Map<Id, sObject> newMap, List<sObject> oldList, Map<Id, sObject> oldMap);
    //void beforeDelete(List<sObject> oldList, Map<Id, sObject> oldMap);
    void afterInsert(List<sObject> newList, Map<Id, sObject> newMap);
    void afterUpdate(List<sObject> newList, Map<Id, sObject> newMap, List<sObject> oldList, Map<Id, sObject> oldMap);
    //void afterDelete(List<sObject> oldList, Map<Id, sObject> oldMap);
    //void afterUndelete(List<sObject> newList, Map<Id, sObject> newMap);
}
