public with sharing class EmailManager {
   
    public static Messaging.SingleEmailMessage createMail(String[] addresses, String subject, String body) {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(addresses);
        mail.setSubject(subject);
        mail.setPlainTextBody(body);
        return mail;
    }
    
}