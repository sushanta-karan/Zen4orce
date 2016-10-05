public with sharing class HRExtension {
    
    private final HR__c hr1;
     public String errorMessage { get; set; }
    public ApexPages.StandardController stdController{get;set;}
    
    public HRExtension(apexpages.standardController stdController){
        this.hr1 = (HR__c)stdController.getRecord();
        this.stdController = stdController;
    }
        public  PageReference activateuser(){
            try{
                PageReference pageRef= new PageReference('/apex/NewUser?HR__c.Id='+hr1.Id);
                pageRef.setredirect(true);
                return pageRef;
            }
            catch(System.Exception ex) {
            errorMessage = ex.getMessage();
            return null;
        }

}
}