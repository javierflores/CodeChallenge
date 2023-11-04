trigger AccountTrigger on Account (after insert, after update) {
    TriggerHandler handler = new AccountTriggerHandler();

    switch on Trigger.operationType {
        when AFTER_INSERT {
            handler.afterInsert(Trigger.new, Trigger.newMap);
        }
        when AFTER_UPDATE {
            handler.afterUpdate(Trigger.old, Trigger.new, Trigger.oldMap, Trigger.newMap);
        }
    }
}
