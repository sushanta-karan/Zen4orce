@isTest
public class TaskHandlerClassTest {
    public static testmethod void openTaskPositive(){
        List <Lead> leadList=new List<Lead> ();
        for(Integer i=0;i<50;i++){
            Lead l1 = new Lead (LastName = 'Testing',Company = 'Zen4orce',Status = 'Open - Not Contacted');
            leadList.add(l1);
        } Insert leadList;
        List <Task> taskList = new List<Task>();
        Lead l2 = [SELECT id FROM Lead WHERE id =:leadList];
        for(Integer i=0;i<50;i++){
            Task t1 = new Task (WhoId = l2.Id,Status = 'Completed');
            taskList.add(t1);
        }insert taskList;
        List <Lead> checkLead = [SELECT id,Status FROM Lead];
        for(Lead led : checkLead){
        system.assertEquals('Working - Contacted', led.Status);    
        }
        }
    public static testmethod void openTaskNegative(){
        List <Lead> leadList=new List<Lead> ();
        for(Integer i=0;i<50;i++){
            Lead l1 = new Lead (LastName = 'Testing',Company = 'Zen4orce',Status = 'Open - Not Contacted');
            leadList.add(l1);
        } Insert leadList;
        List <Task> taskList = new List<Task>();
        Lead l2 = [SELECT id FROM Lead WHERE id =:leadList];
        for(Integer i=0;i<50;i++){
            Task t1 = new Task (WhoId = l2.Id,Status = 'Not Started');
            taskList.add(t1);
        }insert taskList;
        List <Lead> checkLead = [SELECT id,Status FROM Lead];
        for(Lead led : checkLead){
        system.assertnotEquals('Working - Contacted', led.Status);    
        }
        }
    public static testmethod void closedTaskPositive(){
        List <Lead> leadList=new List<Lead> ();
        for(Integer i=0;i<50;i++){
            Lead l1 = new Lead (LastName = 'Testing',Company = 'Zen4orce',Status = 'Open - Not Contacted');
            leadList.add(l1);
        } Insert leadList;
        List <Task> taskList = new List<Task>();
        Lead l2 = [SELECT id FROM Lead WHERE id =:leadList];
        for(Integer i=0;i<50;i++){
            Task t1 = new Task (WhoId = l2.Id,Status = 'Not Started');
            taskList.add(t1);
        }insert taskList;
        List <Lead> checkLead = [SELECT id,Status FROM Lead];
        for(Lead led : checkLead){
        system.assertEquals('Working - Contacted', led.Status);    
        }
        }

}