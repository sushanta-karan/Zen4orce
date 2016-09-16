public with sharing class LeadHandlerClass {
    public static void onAfterInsert(List<Lead> leadList){
        List <Task> taskList = new List<Task>();
        for ( Lead lead : leadList )
    {
            Task T = new Task();
            T.Subject ='Follow Up Test Task';
            T.Whoid=lead.Id;
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
            System.debug('Account fields that affected this error: ' + err.getFields());
        }
    }
}
        
    }
    public static void onBeforeInsert(List<Lead> leadList){
        List <Lead> leadList1 = new List<Lead>();
        for ( Lead lead : leadList ){
        if(lead.Status == 'Open - Not Contacted'){
            Lead leadnew = new Lead();
            leadnew.FirstName = lead.FirstName;
            leadnew.LastName = lead.LastName + ' ' +'aaaa';
            leadnew.Status = 'Working - Contacted';
            leadnew.Company = lead.Company;
            leadList1.add(leadnew);
            
            system.debug('New Lead'+leadnew);}
        }
            Database.SaveResult[] srList = Database.insert(leadList1, false);
	for (Database.SaveResult sr : srList) {
    if (sr.isSuccess()) {
        System.debug('Successfully inserted Task: ' + sr.getId());
    }
    else {
        for(Database.Error err : sr.getErrors()) {
            System.debug('The following error has occurred.');                    
            System.debug(err.getStatusCode() + ': ' + err.getMessage());
            System.debug('Account fields that affected this error: ' + err.getFields());
        }
    }
}
            
    }
    public static void onBeforeInsertAndBeforeUpdate(List<Lead> lstNewLead){
        set<string> setPhones = new set<string>();
    set<string> setEmails = new set<string>();
        map<string, lead> mapEmailWithLead = new map<string, lead>();
    map<string, lead> mapPhoneWithLead = new map<string, lead>();
        for(Lead oLead : lstNewLead){
            if(oLead.Phone != null){
             setPhones.add(oLead.Phone);
            }
            if(oLead.email != null){
             setEmails.add(oLead.email);
            }
        }
         list<Lead> lstLead = [select id, phone, email from lead where phone in :setPhones or email in :setEmails ];
        for(Lead oLead : lstLead){
            if(string.isNotEmpty(oLead.email)){
                mapEmailWithLead.put(oLead.email, oLead);
            }
            if(string.isNotEmpty(oLead.phone)){
                mapPhoneWithLead.put(oLead.phone, oLead);
            }
        }

        for(Lead oLead : lstNewLead){
            if(mapEmailWithLead.containsKey(oLead.email) || mapPhoneWithLead.containsKey(oLead.phone)){
                oLead.addError('Duplicate Lead Found');
            }
        }


    }
    }