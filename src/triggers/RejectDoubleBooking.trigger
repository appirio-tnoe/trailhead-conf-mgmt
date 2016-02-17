trigger RejectDoubleBooking on Session_Speaker__c (before insert, before update) {
	// collect ID's to reduce data calls
	List<Id> speakerIds = new List<Id>();
    Map<Id,DateTime> requestedBookings = new Map<Id,DateTime>();
    
    // get all speakers related to the trigger
    // set booking map with ids to fill later
    for (Session_Speaker__c newItem : trigger.new) {
        requestedBookings.put(newItem.Session__c,null);
        speakerIds.add(newItem.Speaker__c);
    }
    
    // fill out the start date/time for the related sessions
    List<Session__c> relatedSessions = [SELECT ID, Session_Date__c
                                         FROM Session__c
                                         WHERE ID IN :requestedBookings.keySet()];
    for (Session__c relatedSession : relatedSessions) {
        requestedBookings.put(relatedSession.Id, relatedSession.Session_Date__c);
    }
    
    // get related speaker sessions to check against
    List<Session_Speaker__c> relatedSpeakers = [SELECT ID, Speaker__c, Session__c, Session__r.Session_Date__c
                                                FROM Session_Speaker__c
                                                WHERE Speaker__c IN :speakerIds];
    
    // check one list against the other
    for (Session_Speaker__c requestedSessionSpeaker : trigger.new) {
        DateTime bookingTime = requestedBookings.get(requestedSessionSpeaker.Session__c);
        for (Session_Speaker__c relatedSpeaker : relatedSpeakers) {
            if (relatedSpeaker.Speaker__c == requestedSessionSpeaker.Speaker__c &&
                relatedSpeaker.Session__r.Session_Date__c == bookingTime) {
                    requestedSessionSpeaker.addError('The speaker is already booked at that time');
                }
        }
    }
}