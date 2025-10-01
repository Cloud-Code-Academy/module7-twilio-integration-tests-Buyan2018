/**
 * TwilioServiceTest - Test class for TwilioService
 * @see TwilioService
 * 
 * TODO: Implement test methods to verify the functionality of the TwilioService class
 */
@IsTest
private class TwilioServiceTest {
    
    /**
     * Test the sendSMS method with a valid request
     * 
     * TODO: Implement this test method to verify that sending an SMS works correctly
     */
    @IsTest
    static void testSendSMS() {
        // TODO: Setup test data
        // - Create test phone number and message body
        String testPhoneNumber = '+18777804236'; // Replace with your test phone number
        String testMessage = 'Test message from Salesforce ' + Datetime.now();
        // TODO: Setup mock callout response
        // - Use TwilioCalloutMock to simulate a successful response
        Test.setMock(HttpCalloutMock.class, new TwilioCalloutMock(201, 'success'));
        // TODO: Execute the test
        Test.startTest();
        // - Call TwilioService.sendSMS() method
        TwilioResponse response = TwilioService.sendSMS(testPhoneNumber, testMessage);
        Test.stopTest();
        // TODO: Verify results
        // - Verify that response is successful
        Assert.areEqual(true, response.success, 'Response is successful');
        // - Verify status code is correct
        Assert.areEqual(201, response.statusCode);
        // - Verify response body contains expected values (sid, status, etc.)
        String respBody = response.body.toString();
        Map<String, Object> payload = response.getBodyAsJson();
        String sid = (String)payload.get('account_sid');
        String status = (String)payload.get('status');
        Assert.areNotEqual(null, sid, 'sid is presented');
        Assert.areEqual('queued', status, 'status is presented');
        String errorMessage = response.getErrorMessage();
        System.assertEquals(null, errorMessage, 'Error message is null');
    }
    
    /**
     * Test the sendSMS method with an error response
     * 
     * TODO: Implement this test method to verify error handling in sendSMS
     */
    @IsTest
    static void testSendSMSError() {
        // TODO: Setup test data
        // - Create test phone number and message body
        String testPhoneNumber = '+183122281231'; // Replace with your test phone number
        String testMessage = 'Test message from Salesforce ' + Datetime.now();
        // TODO: Setup mock callout response
        // - Use TwilioCalloutMock to simulate an error response
        Test.setMock(HttpCalloutMock.class, new TwilioCalloutMock(400, 'error'));
        // TODO: Execute the test
        Test.startTest();
        // - Call TwilioService.sendSMS() method
        TwilioResponse response = TwilioService.sendSMS(testPhoneNumber, testMessage);
        Test.stopTest();
        // TODO: Verify results
        // - Verify that response is not successful
        Assert.areNotEqual(true, response.success, 'Response is not successful');
        // - Verify error status code is correct
        Assert.areEqual(400, response.statusCode, '400 Status code is received');
        // - Verify error message is extracted correctly
        String respBody = response.body.toString();
        Map<String, Object> payload = (Map<String, Object>)JSON.deserializeUntyped(respBody);
        String errorMessage = (String)payload.get('message');
        System.assertNotEquals(null, errorMessage, 'Error message is exctracted correctly');
        String parsedErrMessage = response.getErrorMessage();
        System.assertNotEquals(null, parsedErrMessage, 'Error message was excracted correctly');
    }
    
    /**
     * Test the getMessages method
     * 
     * TODO: Implement this test method to verify the getMessages functionality
     */
    @IsTest
    static void testGetMessages() {
        // TODO: Setup mock callout response
        // - Use TwilioCalloutMock to simulate a successful response with message list
        Test.setMock(HttpCalloutMock.class, new TwilioCalloutMock(200, 'success'));
        // TODO: Execute the test
        Test.startTest();
        // - Call TwilioService.getMessages() method with an appropriate limit
        TwilioResponse response = TwilioService.getMessages(10);
        Test.stopTest();
        // TODO: Verify results
        // - Verify that response is successful
        Assert.areEqual(true, response.success, 'Response is not successful');
        // - Verify status code is correct
        Assert.areEqual(200, response.statusCode, '200 Status code is received');
        // - Verify response body contains expected messages data
        String respBody = response.body.toString();
        Map<String, Object> payload = (Map<String, Object>)JSON.deserializeUntyped(respBody);
        List<Object> messagesList = (List<Object>)payload.get('messages');
        System.assertNotEquals(0, messagesList.size(), 'Messages are exctracted correctly');
    }
    
    /**
     * Test the getMessages method with null/invalid limit
     * 
     * TODO: Implement this test method to verify handling of edge cases
     */
    @IsTest
    static void testGetMessagesWithInvalidLimit() {
        // TODO: Setup mock callout response
        // - Use TwilioCalloutMock to simulate a successful response
        Test.setMock(HttpCalloutMock.class, new TwilioCalloutMock(200, 'success'));
        // TODO: Execute the test with null limit
        // - Call TwilioService.getMessages() method with null
        Test.startTest();
        TwilioResponse responseWithNull = TwilioService.getMessages(null);
        // TODO: Execute the test with negative limit
        // - Call TwilioService.getMessages() method with a negative number
        TwilioResponse responseWithNegative = TwilioService.getMessages(-1);
        Test.stopTest();
        // TODO: Verify results
        // - Verify that both responses are successful
        Assert.areEqual(true, responseWithNull.success, 'Response is not successful');
        Assert.areEqual(true, responseWithNegative.success, 'Response is not successful');
        // - Verify that the service handles these edge cases correctly
        String respBodyWithNull = responseWithNull.body.toString();
        Map<String, Object> payloadWitNull = (Map<String, Object>)JSON.deserializeUntyped(respBodyWithNull);
        Integer pageSize = (Integer)payloadWitNull.get('page_size');
        Assert.areEqual(20, pageSize, 'pageSize is set to 20 by default');
        String respBodyWitNegative = responseWithNegative.body.toString();
        Map<String, Object> payloadWithNegative = (Map<String, Object>)JSON.deserializeUntyped(respBodyWitNegative);
        Integer pageSizeWithNegative = (Integer)payloadWithNegative.get('page_size');
        Assert.areEqual(20, pageSizeWithNegative, 'pageSize is set to 20 by default');
    }
    
    /**
     * Test exception handling in makeHttpRequest
     * 
     * TODO: Implement this test method to verify exception handling
     */
    @IsTest
    static void testMakeHttpRequestException() {
        String testPhoneNumber = '+183122281231'; // Replace with your test phone number
        String testMessage = 'Test message from Salesforce ' + Datetime.now();
        // TODO: Setup mock that throws exception
        // - Use TwilioCalloutMock.createExceptionMock()
        Test.setMock(HttpCalloutMock.class, new TwilioCalloutMock(500, 'exception'));
        // TODO: Execute the test
        // - Call a TwilioService method that will use the mock
        Test.startTest();
        TwilioResponse response = TwilioService.sendSMS(testPhoneNumber, testMessage);
        Test.stopTest();
        // TODO: Verify results
        // - Verify that response indicates failure
        System.assertNotEquals(true, response.success, 'Response is not successful');
        // - Verify that status code is set to 500 (or appropriate error code)
        System.assertEquals(500, response.statusCode, '500 Status code is responsed');
        // - Verify that error message is set correctly
        System.assertNotEquals(null, response.getErrorMessage(), 'Error message is exctracted correctly');
    }
    @IsTest
    static void testMakeHttpRequestNull(){
        String testPhoneNumber = '+183122281231'; // Replace with your test phone number
        String testMessage = 'Test message from Salesforce ' + Datetime.now();
        Test.setMock(HttpCalloutMock.class, new TwilioCalloutMock(404, 'error'));
        Test.startTest();
        TwilioResponse response = TwilioService.sendSMS(testPhoneNumber, testMessage);
        Test.stopTest();
        System.assertEquals(null, response.getErrorMessage(), 'Error message is exctracted correctly');
    }
    @IsTest
    static void testMakeHttpRequestNotAcceptable(){
        String testPhoneNumber = '+183122281231'; // Replace with your test phone number
        String testMessage = 'Test message from Salesforce ' + Datetime.now();
        Test.setMock(HttpCalloutMock.class, new TwilioCalloutMock(406, 'error'));
        Test.startTest();
        TwilioResponse response = TwilioService.sendSMS(testPhoneNumber, testMessage);
        Test.stopTest();
        System.assertNotEquals(null, response.getErrorMessage(), 'Error message is exctracted correctly');
    }
} 