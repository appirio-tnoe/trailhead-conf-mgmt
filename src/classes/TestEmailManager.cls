@isTest
private class TestEmailManager {
    static testmethod void TestCreateMail() {
        String[] toAddresses = new String[] {'test@emailaddress.com'};
        String subject = 'This is a test subject';
        String body = 'This is a test email body';
        
        Messaging.SingleEmailMessage testMail = EmailManager.createMail(toAddresses, subject, body);
        System.assertEquals(testMail.toAddresses, toAddresses);
    	System.assertEquals(testMail.subject, subject);
        System.assertEquals(testMail.PlainTextBody, body);
    }
}