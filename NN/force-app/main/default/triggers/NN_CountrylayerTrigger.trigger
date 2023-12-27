/**
 * @Author       Jozef Birka
 * @Date         12/27/2023
 * @description  Trigger for NN_Countrylayer__c
 **/

trigger NN_CountrylayerTrigger on NN_Countrylayer__c(after insert, after update) {
    NN_TriggerDispatcher.run(new NN_CountrylayerTriggerHandler());
}
