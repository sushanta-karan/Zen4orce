public with sharing class CampaignPagination {
    private final Campaign cmp;
    
    public CampaignPagination(ApexPages.StandardSetController controller){
        this.cmp = (Campaign)controller.getRecord();
       }
    public ApexPages.StandardSetController cmpRecords {
        get {
            if(cmpRecords == null) {
                cmpRecords = new ApexPages.StandardSetController(
                    Database.getQueryLocator([SELECT Name,Status,StartDate,Type FROM Campaign ]));
            }
            return cmpRecords;
        }
        private set;
    }
    public List<Campaign> CampaignPagination() {
         return (List<Campaign>) cmpRecords.getRecords();
    }  

}