trigger opportunityTrigger on Opportunity (after insert,after update) {
    if(trigger.isAfter){
        if(trigger.isInsert || trigger.isUpdate){
            OpportunityHandlerClass.onAfterInsert(Trigger.new);
                                                }
                       }
    if(trigger.isAfter){
        if(trigger.isInsert){
           OpportunityHandlerClass.sendEmailOnAfterInsert(Trigger.new); 
        }
}
}