public with sharing class CasePETriggerHandler implements TriggerHandler{
    public void afterInsert(List<Create_Case__e> newCases, Map<ID, SObject> newCaseMap) {
        CasePETriggerUtils.createCase(newCases);
    }
    public void afterUpdate(List<Create_Case__e> oldCases, List<Create_Case__e> newCases, Map<ID, SObject> oldCaseMap, Map<ID, SObject> newCaseMap) {
        //implemented by the interface, no login needed now
    }
}