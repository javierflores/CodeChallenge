public with sharing class CasePETriggerUtils {
    public static void createCase(List<Create_Case__e> lstCases) {
        List<Case> casesToCreate = new List<Case>();
    
        for (Create_Case__e event : lstCases) {
            Case newCase = new Case(
                Subject = 'High Priority Monitor Alert',
                Description = 'This case was created because a Monitor has a High priority.',
                Priority = 'High',
                AccountId = event.Record_Id__c,
                ownerId = event.Owner_Id__c
            );
            
            casesToCreate.add(newCase);
        }
        
        if (!casesToCreate.isEmpty()) {
            try {
                insert casesToCreate;
            } catch (DmlException e) {
                // I'm leaving this empty, but the recommendations is log or alert on these errors, example:
                // create records on Log__c object or send alert to admins, depends on company strategy
            }
        }
    }
}