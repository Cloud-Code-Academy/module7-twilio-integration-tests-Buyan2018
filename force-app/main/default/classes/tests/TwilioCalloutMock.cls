/**
 * TwilioCalloutMock - Mock implementation for Twilio API callouts
 * Used in test classes to simulate HTTP responses from Twilio
 * 
 * TODO: Implement this mock class to simulate Twilio API responses for testing
 */
@IsTest
public class TwilioCalloutMock implements HttpCalloutMock {
    private Integer statusCode;
    private String responseBody;
    private Boolean throwException;
    private String exceptionMessage;
    
    /**
     * Constructor to initialize with specific status code and response body
     * @param statusCode HTTP status code to return
     * @param responseBody JSON body to return
     */
    public TwilioCalloutMock(Integer statusCode, String responseBody) {
        // TODO: Initialize the mock with the provided status code and response body
        this.statusCode = statusCode;
        this.responseBody = responseBody;
    }
    
    /**
     * Constructor to create a mock that throws an exception
     * @param exceptionMessage The exception message to throw
     */
    public TwilioCalloutMock(String exceptionMessage) {
        // TODO: Initialize the mock to throw an exception with the given message
        this.exceptionMessage = exceptionMessage;
    }
    
    /**
     * Creates an exception-throwing mock with default message
     * @return TwilioCalloutMock An instance that will throw an exception
     */
    public static TwilioCalloutMock createExceptionMock() {
        // TODO: Return a new instance that will throw an exception with a default message
        TwilioCalloutMock mock = new TwilioCalloutMock(500, 'exception');
        mock.exceptionMessage = 'Internal Server Error';
        mock.responseBody = '{"code":20001,"message":"Internal Server Error","more_info":"https://www.twilio.com/docs/errors/20001","status":500}';
        mock.throwException = true;
        return mock;
    }
    
    /**
     * Implementation of the HttpCalloutMock interface
     * @param request The HttpRequest being processed
     * @return HttpResponse A predefined response with the configured status code and body
     * @throws CalloutException If this mock is configured to throw an exception
     */
    public HttpResponse respond(HttpRequest request) {
        // TODO: Implement the response logic based on the configuration
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        // If throwException is true, throw a CalloutException
        // Otherwise, create and return an HttpResponse with the appropriate status code and body
        if (statusCode == 201 && responseBody == 'success') {
            res.setStatusCode(201);
            res.setBody(
                '{ "account_sid": "ACc7dc268459a4de737183caee7109bb7f", "api_version": "2010-04-01",' +
                '"body": "Sent from your Twilio trial account - Hello world",' +
                '"date_created": "Mon, 29 Sep 2025 10:20:22 +0000",' + 
                '"date_sent": null, "date_updated": "Mon, 29 Sep 2025 10:20:22 +0000",' +
                '"direction": "outbound-api", "error_code": null, "error_message": null,' +
                '"from": "+18312228123", "messaging_service_sid": null, "num_media": "0",' +
                '"num_segments": "1", "price": null, "price_unit": "USD", "sid": ' + '"SMcf7e5744901853efe836b54dfd97debd", "status": "queued",' + 
                '"subresource_uris": {' +
                '"media": "/2010-04-01/Accounts/ACc7dc268459a4de737183caee7109bb7f/Messages/SMcf7e5744901853efe836b54dfd97debd/Media.json"}, "to": "+18777804236",' +
                '"uri": "/2010-04-01/Accounts/ACc7dc268459a4de737183caee7109bb7f/Messages/SMcf7e5744901853efe836b54dfd97debd.json"}'
            );
        } else if (statusCode == 400 && responseBody == 'error') {
            res.setStatusCode(400);
            res.setBody('{"code": 21212, "message": "Invalid From Number (caller ID):  183122281231",'+
                        '"more_info": "https://www.twilio.com/docs/errors/21212", "status": 400}');
        } else if (statusCode == 500 && responseBody == 'exception') {
            TwilioCalloutMock exceptionMock = TwilioCalloutMock.createExceptionMock();
            res.setStatusCode(exceptionMock.statusCode);
            res.setBody(exceptionMock.responseBody);
            throw new CalloutException(exceptionMock.exceptionMessage);                
        } else if (statusCode == 200 && responseBody == 'success') {
            res.setStatusCode(200);
            res.setBody('{"end": 7, "first_page_uri": "/2010-04-01/Accounts/ACc7dc268459a4de737183caee7109bb7f/Messages.json?PageSize=20&Page=0", "messages": [{"account_sid": "ACc7dc268459a4de737183caee7109bb7f", "api_version": "2010-04-01", "body": "Sent from your Twilio trial account - Hello world", "date_created": "Tue, 30 Sep 2025 09:23:34 +0000", "date_sent": "Tue, 30 Sep 2025 09:23:34 +0000", "date_updated": "Tue, 30 Sep 2025 09:23:35 +0000", "direction": "outbound-api", "error_code": null, "error_message": null, "from": "+18312228123", "messaging_service_sid": null, "num_media": "0", "num_segments": "1", "price": "-0.00830", "price_unit": "USD", "sid": "SMb02dc7923ceece079c585637fbeaafdb", "status": "delivered", "subresource_uris": {"feedback": "/2010-04-01/Accounts/ACc7dc268459a4de737183caee7109bb7f/Messages/SMb02dc7923ceece079c585637fbeaafdb/Feedback.json", "media": "/2010-04-01/Accounts/ACc7dc268459a4de737183caee7109bb7f/Messages/SMb02dc7923ceece079c585637fbeaafdb/Media.json"}, "to": "+18777804236", "uri": "/2010-04-01/Accounts/ACc7dc268459a4de737183caee7109bb7f/Messages/SMb02dc7923ceece079c585637fbeaafdb.json"}, {"account_sid": "ACc7dc268459a4de737183caee7109bb7f", "api_version": "2010-04-01", "body": "Hello world", "date_created": "Mon, 29 Sep 2025 21:44:26 +0000", "date_sent": "Mon, 29 Sep 2025 21:44:26 +0000", "date_updated": "Mon, 29 Sep 2025 21:44:26 +0000", "direction": "outbound-api", "error_code": 21212, "error_message": null, "from": "+183122281231", "messaging_service_sid": null, "num_media": "0", "num_segments": "1", "price": "-0.00100", "price_unit": "USD", "sid": "SM95074a600345997c2efb93ca33f73862", "status": "failed", "subresource_uris": {"feedback": "/2010-04-01/Accounts/ACc7dc268459a4de737183caee7109bb7f/Messages/SM95074a600345997c2efb93ca33f73862/Feedback.json", "media": "/2010-04-01/Accounts/ACc7dc268459a4de737183caee7109bb7f/Messages/SM95074a600345997c2efb93ca33f73862/Media.json"}, "to": " 18777804236", "uri": "/2010-04-01/Accounts/ACc7dc268459a4de737183caee7109bb7f/Messages/SM95074a600345997c2efb93ca33f73862.json"}, {"account_sid": "ACc7dc268459a4de737183caee7109bb7f", "api_version": "2010-04-01", "body": "Sent from your Twilio trial account - Hello world", "date_created": "Mon, 29 Sep 2025 10:20:22 +0000", "date_sent": "Mon, 29 Sep 2025 10:20:22 +0000", "date_updated": "Mon, 29 Sep 2025 10:20:24 +0000", "direction": "outbound-api", "error_code": null, "error_message": null, "from": "+18312228123", "messaging_service_sid": null, "num_media": "0", "num_segments": "1", "price": "-0.00830", "price_unit": "USD", "sid": "SMcf7e5744901853efe836b54dfd97debd", "status": "delivered", "subresource_uris": {"feedback": "/2010-04-01/Accounts/ACc7dc268459a4de737183caee7109bb7f/Messages/SMcf7e5744901853efe836b54dfd97debd/Feedback.json", "media": "/2010-04-01/Accounts/ACc7dc268459a4de737183caee7109bb7f/Messages/SMcf7e5744901853efe836b54dfd97debd/Media.json"}, "to": "+18777804236", "uri": "/2010-04-01/Accounts/ACc7dc268459a4de737183caee7109bb7f/Messages/SMcf7e5744901853efe836b54dfd97debd.json"}, {"account_sid": "ACc7dc268459a4de737183caee7109bb7f", "api_version": "2010-04-01", "body": "Hello world too", "date_created": "Mon, 29 Sep 2025 09:57:19 +0000", "date_sent": "Mon, 29 Sep 2025 09:57:20 +0000", "date_updated": "Mon, 29 Sep 2025 09:57:20 +0000", "direction": "inbound", "error_code": null, "error_message": null, "from": "+18777804236", "messaging_service_sid": null, "num_media": "0", "num_segments": "1", "price": "-0.00830", "price_unit": "USD", "sid": "SM54e0f6e72b993ab048ed8b93025b74a3", "status": "received", "subresource_uris": {"feedback": "/2010-04-01/Accounts/ACc7dc268459a4de737183caee7109bb7f/Messages/SM54e0f6e72b993ab048ed8b93025b74a3/Feedback.json", "media": "/2010-04-01/Accounts/ACc7dc268459a4de737183caee7109bb7f/Messages/SM54e0f6e72b993ab048ed8b93025b74a3/Media.json"}, "to": "+18312228123", "uri": "/2010-04-01/Accounts/ACc7dc268459a4de737183caee7109bb7f/Messages/SM54e0f6e72b993ab048ed8b93025b74a3.json"}, {"account_sid": "ACc7dc268459a4de737183caee7109bb7f", "api_version": "2010-04-01", "body": "Sent from your Twilio trial account - Hello world", "date_created": "Mon, 29 Sep 2025 09:56:19 +0000", "date_sent": "Mon, 29 Sep 2025 09:56:19 +0000", "date_updated": "Mon, 29 Sep 2025 09:56:21 +0000", "direction": "outbound-api", "error_code": null, "error_message": null, "from": "+18312228123", "messaging_service_sid": null, "num_media": "0", "num_segments": "1", "price": "-0.00830", "price_unit": "USD", "sid": "SMd9d93a3b7b8cbb8a0ee41ea772174938", "status": "delivered", "subresource_uris": {"feedback": "/2010-04-01/Accounts/ACc7dc268459a4de737183caee7109bb7f/Messages/SMd9d93a3b7b8cbb8a0ee41ea772174938/Feedback.json", "media": "/2010-04-01/Accounts/ACc7dc268459a4de737183caee7109bb7f/Messages/SMd9d93a3b7b8cbb8a0ee41ea772174938/Media.json"}, "to": "+18777804236", "uri": "/2010-04-01/Accounts/ACc7dc268459a4de737183caee7109bb7f/Messages/SMd9d93a3b7b8cbb8a0ee41ea772174938.json"}, {"account_sid": "ACc7dc268459a4de737183caee7109bb7f", "api_version": "2010-04-01", "body": "Sent from your Twilio trial account - Test message from Salesforce 2025-09-29 09:49:26", "date_created": "Mon, 29 Sep 2025 09:49:26 +0000", "date_sent": "Mon, 29 Sep 2025 09:49:26 +0000", "date_updated": "Mon, 29 Sep 2025 09:49:28 +0000", "direction": "outbound-api", "error_code": null, "error_message": null, "from": "+18312228123", "messaging_service_sid": null, "num_media": "0", "num_segments": "1", "price": "-0.00830", "price_unit": "USD", "sid": "SM90c9dcb60713426d997f3940c3ac37bc", "status": "delivered", "subresource_uris": {"feedback": "/2010-04-01/Accounts/ACc7dc268459a4de737183caee7109bb7f/Messages/SM90c9dcb60713426d997f3940c3ac37bc/Feedback.json", "media": "/2010-04-01/Accounts/ACc7dc268459a4de737183caee7109bb7f/Messages/SM90c9dcb60713426d997f3940c3ac37bc/Media.json"}, "to": "+18777804236", "uri": "/2010-04-01/Accounts/ACc7dc268459a4de737183caee7109bb7f/Messages/SM90c9dcb60713426d997f3940c3ac37bc.json"}, {"account_sid": "ACc7dc268459a4de737183caee7109bb7f", "api_version": "2010-04-01", "body": "Test message from Salesforce 2025-09-29 09:48:25", "date_created": "Mon, 29 Sep 2025 09:48:25 +0000", "date_sent": "Mon, 29 Sep 2025 09:48:25 +0000", "date_updated": "Mon, 29 Sep 2025 09:48:25 +0000", "direction": "outbound-api", "error_code": 21266, "error_message": null, "from": "+18312228123", "messaging_service_sid": null, "num_media": "0", "num_segments": "1", "price": "-0.00100", "price_unit": "USD", "sid": "SMf7a1affcdec26d42cda20f72a0409934", "status": "failed", "subresource_uris": {"feedback": "/2010-04-01/Accounts/ACc7dc268459a4de737183caee7109bb7f/Messages/SMf7a1affcdec26d42cda20f72a0409934/Feedback.json", "media": "/2010-04-01/Accounts/ACc7dc268459a4de737183caee7109bb7f/Messages/SMf7a1affcdec26d42cda20f72a0409934/Media.json"}, "to": "+18312228123", "uri": "/2010-04-01/Accounts/ACc7dc268459a4de737183caee7109bb7f/Messages/SMf7a1affcdec26d42cda20f72a0409934.json"}, {"account_sid": "ACc7dc268459a4de737183caee7109bb7f", "api_version": "2010-04-01", "body": "Sent from your Twilio trial account - \u0442\u0435\u0441\u0442", "date_created": "Sun, 28 Sep 2025 10:44:26 +0000", "date_sent": "Sun, 28 Sep 2025 10:44:26 +0000", "date_updated": "Sun, 28 Sep 2025 10:44:28 +0000", "direction": "outbound-api", "error_code": null, "error_message": null, "from": "+18312228123", "messaging_service_sid": null, "num_media": "0", "num_segments": "1", "price": "-0.00830", "price_unit": "USD", "sid": "SMd2243f7f99b1b178a8bc2289b6bee168", "status": "delivered", "subresource_uris": {"feedback": "/2010-04-01/Accounts/ACc7dc268459a4de737183caee7109bb7f/Messages/SMd2243f7f99b1b178a8bc2289b6bee168/Feedback.json", "media": "/2010-04-01/Accounts/ACc7dc268459a4de737183caee7109bb7f/Messages/SMd2243f7f99b1b178a8bc2289b6bee168/Media.json"}, "to": "+18777804236", "uri": "/2010-04-01/Accounts/ACc7dc268459a4de737183caee7109bb7f/Messages/SMd2243f7f99b1b178a8bc2289b6bee168.json"}], "next_page_uri": null, "page": 0, "page_size": 20, "previous_page_uri": null, "start": 0, "uri": "/2010-04-01/Accounts/ACc7dc268459a4de737183caee7109bb7f/Messages.json?PageSize=20&Page=0"}');
        } else if (statusCode == 404 && responseBody == 'error') {
            res.setBody('-----------');
        } else if (statusCode == 406 && responseBody == 'error') {
            res.setBody('{"code": 2143212, "error_message": "iUnexpected character (\'<\' (code 60)): expected a valid value (number, String, array, object, \'true\', \'false\' or \'null\') at input location [1,2], at line number :: 94","more_info": "https://www.twilio.com/docs/errors/21212", "status": 400}');
        }
        return res;
    }
} 