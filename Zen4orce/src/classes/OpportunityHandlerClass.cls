public with sharing class OpportunityHandlerClass {
    public static void onAfterInsert(List<Opportunity> oppList){
        List <Task> taskList = new List<Task>();
    for ( Opportunity opp : oppList )
        if(opp.StageName!=null && opp.StageName == 'Closed Won'){
            Task T = new Task();
            T.Subject ='Follow Up Test Task';
            T.Whatid=opp.Id;
            taskList.add(T);
            system.debug('abc'+taskList);
        }Database.SaveResult[] srList = Database.insert(taskList, false);


for (Database.SaveResult sr : srList) {
    if (sr.isSuccess()) {
        
        System.debug('Successfully inserted Task: ' + sr.getId());
    }
    else {
        
        for(Database.Error err : sr.getErrors()) {
            System.debug('The following error has occurred.');                    
            System.debug(err.getStatusCode() + ': ' + err.getMessage());
            System.debug('Task fields that affected this error: ' + err.getFields());
        }
    }
}
          
     
    }
    
    public static void sendEmailOnAfterInsert(List<Opportunity> oppList){
        Opportunity i=[select ownerid, id,Owner.manager.email,Owner.manager.name from opportunity where id=:trigger.newMap.keySet()];
        EmailTemplate et=[Select id from EmailTemplate where name=:'Opps Template'];
        List<Messaging.SingleEmailMessage> email = new List<Messaging.SingleEmailMessage>();
        for (Opportunity o : oppList) 
    { 
    if(o.Amount>25000){  
        String userEmail = i.Owner.manager.email; 
       Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
        mail.setTargetObjectId(i.owner.manager.Id);
        mail.setTemplateID(et.Id);
        mail.setSaveAsActivity(false);
        String[] toAddresses = new String[] {userEmail}; 
            mail.setToAddresses(toAddresses); 
        email.add(mail);
        system.debug('opp'+email);
    Messaging.sendEmail(email);
    } 
    }
    }
}