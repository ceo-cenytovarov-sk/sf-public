/**
 * @Author:       Jozef Birka
 * @Date :        12/27/2023
 * @description: This Trigger dispatcher class maintains the trigger context and delegates to respective trigger handler
 **/

public class NN_TriggerDispatcher {
    public static void run(NN_TriggerHandler handler) {
        // Detect the current trigger context and fire the relevant methods on the trigger handler:

        // Before trigger logic

        /*if (Trigger.isBefore) {
            if (Trigger.isInsert) {
                handler.beforeInsert(Trigger.new);
            }
            if (Trigger.isUpdate) {
                handler.beforeUpdate(Trigger.new, Trigger.newMap, Trigger.old, Trigger.oldMap);
            }
            if (Trigger.isDelete) {
                handler.beforeDelete(Trigger.old, Trigger.oldMap);
            }
        }*/
        // After trigger logic

        if (Trigger.isAfter) {
            if (Trigger.isInsert) {
                handler.afterInsert(Trigger.new, Trigger.newMap);
            }
            if (Trigger.isUpdate) {
                handler.afterUpdate(Trigger.new, Trigger.newMap, Trigger.old, Trigger.oldMap);
            }
            /*if (Trigger.isDelete) {
                handler.afterDelete(Trigger.old, Trigger.oldMap);
            }
            if (Trigger.isUndelete) {
                handler.afterUndelete(Trigger.new, Trigger.newMap);
            }*/
        }
    }
}
