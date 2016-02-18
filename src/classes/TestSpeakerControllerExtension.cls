@isTest
private class TestSpeakerControllerExtension {
    static testmethod void TestUpdateSpeakerWithoutPicture() {
        Speaker__c speaker = new Speaker__c(First_Name__c='Test',
                                            Last_Name__c='Test');
        insert speaker;
        
        PageReference pageRef = new PageReference('/apex/SpeakerForm?' + speaker.id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdSpeaker = new ApexPages.StandardController(speaker);
        SpeakerControllerExtension ext = new SpeakerControllerExtension(stdSpeaker);
        String nextPage = ext.save().getUrl();
        System.assertEquals('/' + String.valueOf(speaker.Id).substring(0,15), nextPage);
    }
    
    static testmethod void TestUpdateSpeakerWithPicture() {
        Blob pic = Blob.valueOf('test.jpg');
        
        Speaker__c speaker = new Speaker__c(First_Name__c='Test',
                                            Last_Name__c='Test');
        insert speaker;
        
        PageReference pageRef = new PageReference('/apex/SpeakerForm?' + speaker.id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdSpeaker = new ApexPages.StandardController(speaker);
        SpeakerControllerExtension ext = new SpeakerControllerExtension(stdSpeaker);
        ext.picture = pic;
        String nextPage = ext.save().getUrl();
        System.assertEquals('/' + String.valueOf(speaker.Id).substring(0,15), nextPage);
        System.assert(speaker.Picture_Path__c.contains('/servlet/servlet.FileDownload?file='));
    }
}