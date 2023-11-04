// ZipCodeController.cls
public with sharing class ZipCodeController {

    @AuraEnabled
    public static ZipCodeResponse getZipCodeData(String pCountry, String pZipCode) {
        HttpRequest req = utilsZipCode.buildRequest(pCountry, pZipCode);
        Http http = new Http();
        HttpResponse res;

        try {
            res = http.send(req);
            if (res.getStatusCode() == utilsZipCode.STATUS_CODE_200) {
                Map<String, Object> data = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
                return utilsZipCode.parseResponse(data);
            } else {
                throw new AuraHandledException('Error from external service: ' + res.getBody());
            }
        } catch (Exception e) {
            throw new AuraHandledException('HTTP request failed: ' + e.getMessage());
        }
    }
    
    @AuraEnabled
    public static String saveNonUSZipCodeData(String jsonString) {
        ZipCodeResponse pZipInfo = (ZipCodeResponse)JSON.deserialize(jsonString, ZipCodeResponse.class);
        try {
            ZIP_Code__c newZip = utilsZipCode.buildZipCodeRecord(pZipInfo);
            insert newZip;
            return utilsZipCode.SUCCESS_MESSAGE;
        } catch (DmlException e) {
            return e.getMessage();
        }
    }

    public class ZipCodeResponse {
        @AuraEnabled public String post_Code;
        @AuraEnabled public String country;
        @AuraEnabled public String country_abbreviation;
    }
}

