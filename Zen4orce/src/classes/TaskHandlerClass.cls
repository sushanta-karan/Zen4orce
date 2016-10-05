public class TaskHandlerClass {
    public static void OnAfterInsert(List<Task> taskList){
        List <ID> leadListToUpdate = new List<ID> ();
        for(Task tsk : taskList){
            if(tsk.WhoId !=null && String.valueOf(tsk.WhoId).startsWith ('00Q') == TRUE && tsk.Status == 'Completed'){
               leadListToUpdate.add(tsk.WhoId);  
        }
       }//update leadListToUpdate;
        List <Lead> leadList = [SELECT id,Status FROM Lead WHERE id IN : leadListToUpdate];
        for(Lead led : leadList){
            led.Status = 'Working - Contacted';
        }
        update leadList;
        }
    public static void OnAfterUpdate(List<Task> taskList){
        List <ID> leadListToUpdate = new List<ID> ();
        for(Task tsk : taskList){
            if(tsk.WhoId !=null && String.valueOf(tsk.WhoId).startsWith ('00Q') == TRUE && tsk.Status == 'Completed'){
               leadListToUpdate.add(tsk.WhoId);  
        }
       }//update leadListToUpdate;
        List <Lead> leadList = [SELECT id,Status FROM Lead WHERE id IN : leadListToUpdate AND isConverted = False];
        for(Lead led : leadList){
            led.Status = 'Working - Contacted';
        }
        update leadList;
        }
    }