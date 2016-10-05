public class UTFundExtension {
    public user currentuser{get;set;}
    private UT_Fund__c utfund;
    ApexPages.StandardController sController;
    public UTFundExtension(ApexPages.StandardController controller) {
        sController = controller;
        utfund = (UT_Fund__c) controller.getrecord();
        currentuser = new user();
        currentuser = [Select id,Name from User where id =:userinfo.getuserId()];
    }
   public PageReference saveAndNew() {
        sController.save(); 
        PageReference pg = new PageReference('/apex/UT_Fund_Entry');
        pg.setRedirect(true);
        return pg;
    }
}