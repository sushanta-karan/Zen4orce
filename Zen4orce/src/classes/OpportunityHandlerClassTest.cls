@isTest
public class OpportunityHandlerClassTest {
    static testmethod void ClosedOpps(){
        List <Opportunity> opps = new List <Opportunity>();
        for(Integer i=0;i<100;i++){
        Opportunity opp = new Opportunity(Name ='Test Opp',CloseDate = system.today(),Amount = 100,StageName = 'Closed Won');    
            opps.add(opp);
        }
        Database.SaveResult[] srList = Database.insert(opps, false);
        for (Database.SaveResult sr : srList) {
    if (sr.isSuccess()) {
       
        System.debug('Successfully inserted Opportunity: ' + sr.getId());
    }else {
        
        for(Database.Error err : sr.getErrors()) {
            System.debug('The following error has occurred.');                    
            System.debug(err.getStatusCode() + ': ' + err.getMessage());
            System.debug('Opportunity fields that affected this error: ' + err.getFields());
        }
    }
}
        List<Task> t = [SELECT id,WhatId,Subject FROM Task WHERE WhatId =: opps];
  		for(Task t1 : t)
        system.assertEquals(t1.Subject, 'Follow Up Test Task');
        
        
        }
    static testmethod void SendEmailToManagerGreaterThan25000(){
        List <Opportunity> opps = new List <Opportunity>();
        Profile p1 = [SELECT Id FROM Profile WHERE Name='Standard User'];
        User u1 = new User(Alias = 'standt', Email='standarduser@abc.com',EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', LocaleSidKey='en_US', ProfileId = p1.Id,TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@abc.com');
        insert u1;
        User u2 = new User(Alias = 'standt', Email='standarduser@abc.com',EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', LocaleSidKey='en_US', ProfileId = p1.Id,TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@abc.com');
        insert u2;
        u1.ManagerId = u2.Id;
        update u1;
        for(Integer i=0;i<10;i++){
           Opportunity opp = new Opportunity(Name ='Test Opp',CloseDate = system.today(),Amount = 30000,StageName = 'Closed Won',OwnerId=u1.Id); 
            opps.add(opp);
        }
        Database.SaveResult[] srList = Database.insert(opps, false);


for (Database.SaveResult sr : srList) {
    if (sr.isSuccess()) {
        
        System.debug('Successfully inserted Opportunity: ' + sr.getId());
    }
    else {
        
        for(Database.Error err : sr.getErrors()) {
            System.debug('The following error has occurred.');                    
            System.debug(err.getStatusCode() + ': ' + err.getMessage());
            System.debug('Opportunity fields that affected this error: ' + err.getFields());
        }
    }
}
}
    
        
    }