@isTest
public class LeadHandlerClassTest {
    static testmethod void CreateTaskOnLead(){
        List <Lead> leadList=new List<Lead> ();
        for(Integer i=0;i<50;i++){
            Lead l1 = new Lead (LastName = 'Testing',Company = 'Zen4orce',Status = 'Open - Not Contacted');
            leadList.add(l1);
        }
        Database.SaveResult[] srList = Database.insert(leadList, false);
    
    List<Task> tsk = [SELECT id,Subject,WhoId FROM Task WHERE WhoId=:leadList];
    for(Task t:tsk)
    {system.assertEquals(t.Subject, 'Follow Up Test Task');}
        system.assertEquals(leadList.size(), tsk.size());
    }
    
    static testmethod void CreateDupeLeadPositive(){
        List <Lead> leadList=new List<Lead> ();
        for(Integer i=0;i<50;i++){
            Lead l1 = new Lead (LastName = 'Testing',Company = 'Zen4orce',Status = 'Open - Not Contacted');
            leadList.add(l1);
        }
        Database.SaveResult[] srList = Database.insert(leadList, false);
        List<Lead> dupLead = [SELECT id,LastName,Status  FROM Lead WHERE Status = 'Working - Contacted'];
      
        system.assertEquals(50, dupLead.size());
    }
    
    static testmethod void CreateDupeLeadNegative(){
        List <Lead> leadList=new List<Lead> ();
        for(Integer i=0;i<50;i++){
            Lead l1 = new Lead (LastName = 'Testing',Company = 'Zen4orce',Status = 'Closed - Converted');
            leadList.add(l1);
        }
        Database.SaveResult[] srList = Database.insert(leadList, false);
        List<Lead> dupLead = [SELECT id,LastName,Status  FROM Lead WHERE Status = 'Working - Contacted'];
       
        system.assertEquals(0, dupLead.size());
    }
    
    public static testMethod void leadDuplicatePreventer(){
            Lead lead1 = new Lead(LastName='Test1', Company='Test1 Inc.',
                           Phone= '9876787653', Email='test1@duptest.com');
            Lead lead2 = new Lead(LastName='Test2', Company='Test2 Inc.',
                           Phone= '9876787656', Email='test4@duptest.com');
            Lead lead3 = new Lead(LastName='Test3', Company='Test3 Inc.',
                            Phone= '9876787636',Email='test5@duptest.com');
            Lead[] leads = new Lead[] {lead1, lead2, lead3};
            insert leads;
            System.debug('leads***************'+leads);
       
             
            Lead dup1 = new Lead(LastName='Test1Dup', Company='Test1Dup Inc.',
                      Phone= '9876787636',Email='test4@duptest.com');
            Lead dup2 = new Lead(LastName='Test2Dup',
                           Company='Test2Dup Inc.',
                          Phone= '9876787636',  Email='test2@duptest.com');
            Lead dup3 = new Lead(LastName='Test3Dup',
                           Company='Test3Dup Inc.',
                          Phone= '9876787636', Email='test3@duptest.com');
            Lead[] dups = new Lead[] {dup1, dup2, dup3};
                
        try {
       insert dups;
       System.assert(false);
        } catch (DmlException e) {
            String str= e.getMessage();
            System.assertEquals(true,str.contains('FIELD_CUSTOM_VALIDATION_EXCEPTION, Duplicate Lead Found'));

         }
    }
  public static testMethod void leadDuplicatePreventerNew(){
            Lead lead1 = new Lead(LastName='Test1', Company='Test1 Inc.',
                           Phone= '9876787653', Email='test1@duptest.com');
            Lead lead2 = new Lead(LastName='Test2', Company='Test2 Inc.',
                           Phone= '9876787656', Email='test41@duptest.com');
            Lead lead3 = new Lead(LastName='Test3', Company='Test3 Inc.',
                            Phone= '9876787636',Email='test5@duptest.com');
            Lead[] leads = new Lead[] {lead1, lead2, lead3};
            insert leads;
            System.debug('leads****&&&'+leads);
        System.assertEquals(3,leads.size());
    }
  public static testMethod void leadDuplicatePreventerNewBulk(){
      List<Lead>  leadlist = new List<Lead>();
        for(Integer i=0;i<100;i++){
        Lead leadObj = new Lead(LastName = 'Test',Company = 'Zen4orce',LeadSource = 'web',Status = 'Open - Not Contacted',Phone= '9876787631', Email='test2@duptest.com');
            leadlist.add(leadObj);
      Lead leadObj1 = new Lead(LastName = 'Test',Company = 'Zen4orce',LeadSource = 'web',Status = 'Open - Not Contacted',Phone= '9876787630', Email='test92@duptest.com');
            leadlist.add(leadObj1);
      Lead leadObj2 = new Lead(LastName = 'Test',Company = 'Zen4orce',LeadSource = 'web',Status = 'Open - Not Contacted', Phone = '3434545654', Email= 'test29@duptest.com');
            leadlist.add(leadObj2);
            }
         Database.SaveResult[] srList = Database.insert(leadlist, false);
            for (Database.SaveResult sr : srList) {
        if (sr.isSuccess()) {
       
            System.debug('Successfully inserted Leads: ' + sr.getId());
        }else {
                   
        for(Database.Error err : sr.getErrors()) {
            System.debug('The following error has occurred.');                    
            System.debug(err.getStatusCode() + ': ' + err.getMessage());
            System.debug('Lead fields that affected this error: ' + err.getFields());
                 }
            }
    }
    List <Lead> lead  = [SELECT LastName,Company,LeadSource,Status,Phone,Email from Lead ];
    List<Lead>  leadlist1 = new List<Lead>();
        for(Integer i=0;i<100;i++){
        Lead leadObjnew = new Lead(LastName = 'Test',Company = 'Zen4orce',LeadSource = 'web',Status = 'Open - Not Contacted',Phone= '3434545654', Email='test29@duptest.com');
            leadlist1.add(leadObjnew);
          }
        try {
      insert leadlist1;
      System.assert(false);
        } catch (DmlException e) {
            String str= e.getMessage();
            System.assertEquals(true,str.contains('FIELD_CUSTOM_VALIDATION_EXCEPTION, Duplicate Lead Found'));

            }
        
  }
    public static testMethod void updateStateAndTimezoneBeforeInsert(){
        try{
           List<Lead>  leadList = new List<Lead>();
        Lead l1 = new Lead (lastName = 'Test1',Phone = '7028012822',Company = 'ABC');
        Lead l2 = new Lead (lastName = 'Test2',Phone = '7038012822',Company = 'ABC');
        leadList.add(l1);
        leadList.add(l2);
insert leadList;
        List<Time_Zone__c> timeZoneList = new List<Time_Zone__c> ();
        Time_Zone__c t1 = new Time_Zone__c (Area_Code__c ='702',TimeZone__c = 'TimeZone 1',State__c = 'MH');
        Time_Zone__c t2 = new Time_Zone__c (Area_Code__c ='709',TimeZone__c = 'TimeZone 2',State__c = 'MH');
        timeZoneList.add(t1);
        timeZoneList.add(t2);
        insert timeZoneList;
        Lead lead1 = [SELECT id,State__c,Time_Zone__c FROM Lead WHERE id =:l1.Id ] ;
        system.assertEquals('TimeZone 1', lead1.Time_Zone__c);
        system.assertEquals('MH', lead1.State__c);
        Lead lead2 = [SELECT id,State__c,Time_Zone__c FROM Lead WHERE id =:l2.Id];
            system.assert(true);}
        catch (DmlException e) {
            String str= e.getMessage();
            System.assertEquals(false,str.contains('area code not found'));
}
    }
}