trigger opportunityLocationTrigger on OpportunityLocation__c (before insert,before update) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            opportunityLocationHandler.beforeInsert(Trigger.new);
        }
    }
}