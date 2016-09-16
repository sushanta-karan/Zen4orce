trigger CreateDupLead on Lead (before insert,before update) {
List <Lead> leadList = new List<Lead>();
    for ( Lead lead : Trigger.new )
        if(lead.Status == 'Open - Not Contacted'){
            Lead leadnew = new Lead();
            leadnew.FirstName = lead.FirstName;
            leadnew.LastName = lead.LastName + ' ' +'aaaa';
            leadnew.Status = 'Working - Contacted';
            leadnew.Company = lead.Company;
            leadList.add(leadnew);
            
            system.debug('New Lead'+leadnew);
        }if(leadList.size()>0)
            insert leadList;
}