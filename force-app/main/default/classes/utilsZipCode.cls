public with sharing class utilsZipCode {
    public static final String API_ENDPOINT = 'https://api.zippopotam.us'; //this should be moved to a custom settign or CMT or use named credential
    public static final String SUCCESS_MESSAGE = 'Success';
    public static final String GET_METHOD = 'GET';
    public static final Integer STATUS_CODE_200 = 200;

    public static HttpRequest buildRequest(String pCountry, String pZipCode){
        HttpRequest req = new HttpRequest();

        req.setEndpoint(API_ENDPOINT + '/' + pCountry + '/' + pZipCode);
        req.setMethod(GET_METHOD);
        req.setHeader('Content-Type', 'application/json');

        return req;
    }

    public static ZIP_Code__c buildZipCodeRecord(ZipCodeController.ZipCodeResponse pZipInfo) {
        ZIP_Code__c newZip = new ZIP_Code__c();
        newZip.Country__c = pZipInfo.country;
        newZip.Country_Ab__c = pZipInfo.country_abbreviation;
        newZip.Name = pZipInfo.post_code;
        return newZip;
    }

    public static ZipCodeController.ZipCodeResponse parseResponse(Map<String, Object> jsonMap) {
        ZipCodeController.ZipCodeResponse response = new ZipCodeController.ZipCodeResponse();

        response.post_code = (String)jsonMap.get('post code');
        response.country_abbreviation = (String)jsonMap.get('country abbreviation');
        response.country = (String)jsonMap.get('country');

        return response;
    }
}