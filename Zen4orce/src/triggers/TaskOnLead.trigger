trigger TaskOnLead on Lead (after insert,before insert,before update) {
    if(trigger.isAfter){
        if(trigger.isInsert){
            LeadHandlerClass.onAfterInsert(Trigger.new);
        }
    }
    if(trigger.isBefore){
        if(trigger.isInsert){
            LeadHandlerClass.onBeforeInsert(Trigger.new);
        }
    }
    if(trigger.isBefore){
        if(trigger.isInsert || trigger.isUpdate){
            LeadHandlerClass.onBeforeInsertAndBeforeUpdate(Trigger.new);
        }
    }
}