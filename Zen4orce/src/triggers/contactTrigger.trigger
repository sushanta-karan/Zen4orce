trigger contactTrigger on Contact (before update) {
ContactHandlerClass.onAfterUpdate(Trigger.new,Trigger.oldMap);
}