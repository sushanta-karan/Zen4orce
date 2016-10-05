public with sharing class CampaignDetailExtension {
    public String errorMessage { get; set; }
    public ApexPages.StandardController stdController;
    
    public CampaignDetailExtension(apexpages.standardController stdController){
 		this.stdController = stdController;
       if (!Test.isRunningTest()) {
           this.stdController.addFields(new List<String> {'Name','OwnerID','EndDate','StartDate','Status','Type','IsActive','NumberSent','ID'});}
        //system.debug('con id'+this.stdController);
    }
    
    public PageReference copy() {
    Campaign camp1 =  (Campaign) stdController.getrecord();
        system.debug('rec id'+(Campaign) stdController.getrecord());
    Campaign camobj = new Campaign();
        camobj.Name = camp1.Name;
        camobj.EndDate = camp1.EndDate;
        camobj.StartDate = camp1.StartDate;
        camobj.Status = camp1.Status;
        camobj.Type = camp1.Type;
        camobj.IsActive = camp1.IsActive;
        camobj.NumberSent = camp1.NumberSent;
        insert camobj;
        return(new ApexPages.StandardController(camp1).edit());
    }
    public PageReference softdelete() {
        Campaign camp1 =  (Campaign) stdController.getrecord();
        camp1.Campaign_Soft_Delete_Pending__c = TRUE;
        update camp1;
        return(new ApexPages.StandardController(camp1).view());
    }
    
    
}