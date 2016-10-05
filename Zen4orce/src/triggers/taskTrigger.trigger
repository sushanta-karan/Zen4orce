trigger taskTrigger on Task (after insert,after update) {
    if(Trigger.isAfter){
        if(Trigger.isInsert ){
            TaskHandlerClass.OnAfterInsert(Trigger.new);
        }
    }
    if(Trigger.isAfter){
        if(Trigger.isUpdate ){
            TaskHandlerClass.OnAfterUpdate(Trigger.new);
        }
    }
}