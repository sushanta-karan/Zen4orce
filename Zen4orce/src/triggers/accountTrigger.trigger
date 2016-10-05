Trigger accountTrigger on Account (after update) {
AccountHandlerClass.onAfterUpdate(Trigger.new,Trigger.oldMap,trigger.newMap);
}