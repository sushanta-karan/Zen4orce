public  class LeadHandlerClass {
	// Create Task When Lead is created
    public static void onAfterInsert(List<Lead> leadList){
        List <Task> taskList = new List<Task>();
        for ( Lead lead : leadList )
    {
            Task T = new Task();
            T.Subject ='Follow Up Test Task';
            T.Whoid=lead.Id;
            taskList.add(T);
            system.debug('abc'+taskList);
    }
        insert taskList;
        
    }
    
    // Create Duplicate Lead
    public static void onBeforeInsert(List<Lead> leadList){
        List<Lead> leadnew = new List<Lead> ();
        for ( Lead lead : leadList ){
        if(lead.Status == 'Open - Not Contacted'){
            
            Lead cloneLead = lead.clone(false,true,false,false);
            cloneLead.LastName = lead.LastName +' '+'Clone';
            cloneLead.Status = 'Working - Contacted';
            leadnew.add(cloneLead);
            system.debug('clone lead : '+cloneLead);
}
} //insert leadnew;
    }
    
    // Check for duplicate leads before inserting records.
    public static void onBeforeInsertDeDupCheck(List<Lead> lstNewLead){
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
    // Check for duplicate leads before updating records.
    public static void onBeforeUpdateDeDupCheck(List<Lead> lstNewLead, Map<id,Lead> leadOldMap){
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
         list<Lead> lstLead = [select id, phone, email from lead where phone not in :setPhones or email not in :setEmails ];
        for(Lead oLead : lstLead){
            if(string.isNotEmpty(oLead.email)){
                mapEmailWithLead.put(oLead.email, oLead);
            }
            if(string.isNotEmpty(oLead.phone)){
                mapPhoneWithLead.put(oLead.phone, oLead);
            }
        }

        for(Lead oLead : lstNewLead){
            if(oLead.Phone != leadOldMap.get(oLead.Id).Phone || oLead.Phone != leadOldMap.get(oLead.Id).Email){
                if(mapEmailWithLead.containsKey(oLead.email) || mapPhoneWithLead.containsKey(oLead.phone)){
                oLead.addError('Duplicate Lead Found');
            }
            
            }
        }


    }
    
    // Update Custom State and Timezone based on Standard Phone number Before Insert
    public static void onBeforeInsertUpdateTimezone(List<Lead> leadList){
        Map <String,Time_Zone__c> timeZoneMap = new Map <String,Time_Zone__c> ();
        List <String> leadPhoneList = new List <String> ();
        for(Time_Zone__c acode : [SELECT State__c,TimeZone__c,Area_Code__c FROM Time_Zone__c]){
            timeZoneMap.put(acode.Area_Code__c,acode);
        }
        for(Lead lead1 : leadList){
            String firstchar ;
            if(lead1.Phone != null){
                firstchar = lead1.Phone.removeStart('(');
                if(timeZoneMap.get(firstchar.left(3)) != null){
                    lead1.State__c = timeZoneMap.get(firstchar.left(3)).State__c;
                lead1.Time_Zone__c = timeZoneMap.get(firstchar.left(3)).TimeZone__c;
                }
                else{
                  lead1.addError ('area code not found');  
                }
            }
        
   }
}

  // Update Custom State and Timezone based on Standard Phone number Update Insert
    public static void onBeforeUpdateUpdateTimezone(List<Lead> leadList,Map <id,Lead> leadmap){
        Map <String,Time_Zone__c> timeZoneMap = new Map <String,Time_Zone__c> ();
        List <String> leadPhoneList = new List <String> ();
        for(Time_Zone__c acode : [SELECT State__c,TimeZone__c,Area_Code__c FROM Time_Zone__c]){
            timeZoneMap.put(acode.Area_Code__c,acode);
        }
        for(Lead lead1 : leadList){
            if(lead1.Phone != leadmap.get(lead1.Id).phone && timeZoneMap != null){
                //system.debug('Map of timezone'+timeZoneMap);
         String firstchar;
            if(lead1.Phone != null ){
                   firstchar = lead1.Phone.removeStart('(');
               if(timeZoneMap.get(firstchar.left(3)) != null){
                    lead1.State__c = timeZoneMap.get(firstchar.left(3)).State__c;
                     lead1.Time_Zone__c = timeZoneMap.get(firstchar.left(3)).TimeZone__c;
                }
                else{
                    lead1.addError ('area code not found');
                }
}
}
}
}
}