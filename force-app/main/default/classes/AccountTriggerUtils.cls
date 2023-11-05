public with sharing class AccountTriggerUtils {
    public static String queueName = 'Support';
    public static Group queue = [SELECT Id FROM Group WHERE Type = 'Queue' AND Name = :queueName LIMIT 1];

    public static void firePlatformEvent(List<Account> lstAcc) {
        List<Create_Case__e> eventsToPublish = new List<Create_Case__e>();
        
        for (Account acc : lstAcc) {
            if (acc.Risk__c == 'High') {
                Create_Case__e newEvent = new Create_Case__e(
                    Record_Id__c = acc.Id,
                    Owner_Id__c = queue.Id
                );
                
                eventsToPublish.add(newEvent);
            }
        }
        
        if (!eventsToPublish.isEmpty()) {
            List<Database.SaveResult> results = EventBus.publish(eventsToPublish);
            
            for (Database.SaveResult result : results) {
                if (!result.isSuccess()) {
                    // create records on Log__c object or send alert to admins (depends on company strategy)
                }
            }
        }
    }
}