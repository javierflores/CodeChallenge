public without sharing class AccountTriggerHandler implements TriggerHandler {
    
    public void afterInsert(List<Account> newAccounts, Map<ID, SObject> newAccountMap) {
        AccountTriggerUtils.firePlatformEvent(newAccounts);
    }
    public void afterUpdate(List<Account> oldAccounts, List<Account> newAccounts, Map<ID, SObject> oldAccountMap, Map<ID, SObject> newAccountMap) {
        AccountTriggerUtils.firePlatformEvent(newAccounts);
    }
}