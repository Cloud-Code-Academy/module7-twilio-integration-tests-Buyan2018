/**
 * TwilioRestApiTest - Test class for TwilioRestApi
 * @see TwilioRestApi
 * 
 * TODO: Implement test methods to verify the functionality of the TwilioRestApi class
 */
@IsTest
private class TwilioRestApiTest {
    
    /**
     * Test handleIncomingSMS method with standard SMS parameters
     * 
     * TODO: Implement this test method to verify handling of standard SMS webhooks
     */
    @IsTest
    static void testHandleIncomingSMSStandard() {
        // TODO: Setup mock REST request with standard SMS parameters
        // - Create RestRequest and RestResponse objects
        RestRequest req = new RestRequest();
        // - Set requestURI (e.g., '/services/apexrest/twilio/sms')
        req.requestURI = '/services/apexrest/twilio/sms';
        // - Set httpMethod to 'POST'
        req.httpMethod = 'POST';
        // - Add required parameters (MessageSid, AccountSid, From, To, Body, etc.)
        req.addParameter('MessageSid', 'SM123456');
        req.addParameter('From', '+15551234567');
        req.addParameter('To', '+17775553333');
        req.addParameter('Body', 'Test message from Twilio');
        // TODO: Set the mock request/response objects in RestContext
        RestResponse res = new RestResponse();
        RestContext.request = req;
        RestContext.response = res;
        // TODO: Execute the test
        // - Call TwilioRestApi.handleIncomingSMS()
        Test.startTest();
        String responseXML = TwilioRestApi.handleIncomingSMS();
        Test.stopTest();
        // TODO: Verify results
        // - Verify response XML is not null
        Assert.areNotEqual(null, responseXML, 'Response not null');
        // - Verify response contains expected TwiML elements
        Assert.isTrue(responseXML.contains('<Response>'));

    }
    
    /**
     * Test handleIncomingSMS method with media attachments
     * 
     * TODO: Implement this test method to verify handling of SMS with media
     */
    @IsTest
    static void testHandleIncomingSMSWithMedia() {
        // TODO: Setup mock REST request with media parameters
        // - Create RestRequest and RestResponse objects
        RestRequest req = new RestRequest();
        // - Set requestURI and httpMethod
        req.requestURI = '/services/apexrest/twilio/sms';
        req.httpMethod = 'POST';
        // - Add media attachment parameters (NumMedia, MediaUrl0, MediaContentType0, etc.)
        req.addParameter('MessageSid', 'SM123456');
        req.addParameter('From', '+15551234567');
        req.addParameter('To', '+17775553333');
        req.addParameter('Body', 'Test message from Twilio');
        req.addParameter('NumMedia', '1');
        req.addParameter('MediaUrl0', 'https://orgfarm-de1c4366c8-dev-ed.develop.my.salesforce.com/sfc/p/gL000007DQBy/a/gL0000002x0n/fTuV778LbUlFdkORbHBdhMOowiy.dJsGFE6Z3twthCc');
        req.addParameter('MediaContentType0', 'svg');
        // - Add required parameters
        // TODO: Set the mock request/response objects in RestContext
        RestResponse res = new RestResponse();
        RestContext.request = req;
        RestContext.response = res;
        // TODO: Execute the test
        // - Call TwilioRestApi.handleIncomingSMS()
        Test.startTest();
        String responseXML = TwilioRestApi.handleIncomingSMS();
        Test.stopTest();
        // TODO: Verify results
        // - Verify response XML is not null
        Assert.areNotEqual(null, responseXML, 'Response not null');
        // - Verify response contains expected TwiML elements
        Assert.isTrue(responseXML.contains('<Response>'));
    }
    
    /**
     * Test handleIncomingSMS method with location data
     * 
     * TODO: Implement this test method to verify handling of SMS with location data
     */
    @IsTest
    static void testHandleIncomingSMSWithLocation() {
        // TODO: Setup mock REST request with location parameters
        // - Create RestRequest and RestResponse objects
        RestRequest req = new RestRequest();

        // - Set requestURI and httpMethod
        req.requestURI = '/services/apexrest/twilio/sms';
        req.httpMethod = 'POST';
        // - Add required parameters
        req.addParameter('MessageSid', 'SM123456');
        req.addParameter('From', '+15551234567');
        req.addParameter('To', '+17775553333');
        req.addParameter('Body', 'Test message from Twilio');
        // - Add location parameters (FromCity, FromState, FromZip, FromCountry, etc.)
        req.addParameter('FromState', 'CA');
        req.addParameter('FromCity', 'SAN FRANCISCO');
        req.addParameter('FromCountry', 'US');
        req.addParameter('FromZip', '94103');
        req.addParameter('ToCity', 'SAUSALITO');
        req.addParameter('ToState', 'CA');
        req.addParameter('ToZip', '94965');
        req.addParameter('ToCountry', 'US');
        // TODO: Set the mock request/response objects in RestContext
        RestResponse res = new RestResponse();
        RestContext.request = req;
        RestContext.response = res;
        // TODO: Execute the test
        // - Call TwilioRestApi.handleIncomingSMS()
        Test.startTest();
        String responseXML = TwilioRestApi.handleIncomingSMS();
        Test.stopTest();
        // TODO: Verify results
        // - Verify response XML is not null
        Assert.areNotEqual(null, responseXML, 'Response not null');
        // - Verify response contains expected TwiML elements
        Assert.isTrue(responseXML.contains('<Response>'));
    }
    
    /**
     * Test handleIncomingSMS method with WhatsApp parameters
     * 
     * TODO: Implement this test method to verify handling of WhatsApp messages
     */
    @IsTest
    static void testHandleIncomingSMSWithWhatsApp() {
        // TODO: Setup mock REST request with WhatsApp parameters
        // - Create RestRequest and RestResponse objects
        RestRequest req = new RestRequest();
        // - Set requestURI and httpMethod
        req.requestURI = '/services/apexrest/twilio/sms';
        req.httpMethod = 'POST';
        // - Add required parameters with WhatsApp format (e.g., From: 'whatsapp:+15551234567')
        req.addParameter('MessageSid', 'SM123456');
        req.addParameter('From', 'whatsapp:+15551234567');
        req.addParameter('To', 'whatsapp:+17775553333');
        req.addParameter('Body', 'Test message from Twilio');
        // - Add WhatsApp specific parameters (ProfileName, WaId, etc.)
        req.addParameter('ProfileName', 'Star Track');
        req.addParameter('WaId', '7775553333');
        req.addParameter('Forwarded', 'true');
        req.addParameter('FrequentlyForwarded', 'false');
        // - Add WhatsApp location data if applicable
        req.addParameter('Latitude', '51.51322977399644');
        req.addParameter('Longitude', '-0.2197976373036567');
        req.addParameter('Address', '187 Freston Road, London, Greater London W10 6TH');
        req.addParameter('Label', 'The Harrow Club');
        // TODO: Set the mock request/response objects in RestContext
        RestResponse res = new RestResponse();
        RestContext.request = req;
        RestContext.response = res;
        // TODO: Execute the test
        // - Call TwilioRestApi.handleIncomingSMS()
        Test.startTest();
        String responseXML = TwilioRestApi.handleIncomingSMS();
        Test.stopTest();
        // TODO: Verify results
        // - Verify response XML is not null
        Assert.areNotEqual(null, responseXML, 'Response not null');
        // - Verify response contains expected TwiML elements
        Assert.isTrue(responseXML.contains('<Response>'));
    }
} 