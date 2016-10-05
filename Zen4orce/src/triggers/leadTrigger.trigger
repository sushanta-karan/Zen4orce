trigger leadTrigger on Lead (after insert,before insert,before update) {
    Lead__c profileCustomSetting = Lead__c.getInstance(UserInfo.getUserId());
    if((profileCustomSetting.Trigger_Objects__c.contains('Lead')
            && !profileCustomSetting.DisableTrigger__c)){
    if(trigger.isAfter){
        if(trigger.isInsert){
            LeadHandlerClass.onAfterInsert(Trigger.new);
        }
    }
    if(trigger.isBefore){
        if(trigger.isInsert){
            LeadHandlerClass.onBeforeInsert(Trigger.new);
            LeadHandlerClass.onBeforeInsertUpdateTimezone(Trigger.new);
            LeadHandlerClass.onBeforeInsertDeDupCheck(Trigger.new);
        }
    }
    if(trigger.isBefore){
        if(trigger.isUpdate){
            LeadHandlerClass.onBeforeUpdateUpdateTimezone(Trigger.new,Trigger.oldMap);
            LeadHandlerClass.onBeforeUpdateDeDupCheck(Trigger.new,Trigger.oldMap);
        }
    }
        }
}