public with sharing class UTTransactionExtension {
    public user currentuser{get;set;}
    public UT_Transactions__c uttrans{get;set;}
    public UT_Fund__c fund {get;set;}
    public boolean validationWarning = false;
    public ApexPages.StandardController sController;
    public UTTransactionExtension(ApexPages.StandardController controller) {
        this.sController = controller;
        this.uttrans = (UT_Transactions__c) controller.getrecord();
         //uttrans = controller.getRecord();
        if(uttrans == null)
             {
              uttrans = new UT_Transactions__c();
             }
             if(ApexPages.currentpage().getParameters().get('Transaction Type') != null)
             {
              uttrans.Transaction_Type__c = ApexPages.currentpage().getParameters().get('Transaction Type');
             }
             if(ApexPages.currentpage().getParameters().get('UT Fund name') != null)
             {
              uttrans.UT_Fund_name__c = ApexPages.currentpage().getParameters().get('UT Fund name');
              //fetchMemberDetails(); //the method to fetch Price and Currency
             
             }
        //Retrtieve UT Transaction and Fund 
        //trans = (UT_Transactions__c) controller.getrecord();
        currentuser = new user();
        currentuser = [Select id,Name from User where id =:userinfo.getuserId()];
     }
   public void fetchMemberDetails(){
        fund = [SELECT id,Currency__c,Amount__c FROM UT_Fund__c WHERE Id = : uttrans.UT_Fund_name__c];
        uttrans.Currency__c = fund.Currency__c;
        uttrans.Transaction_Price__c = fund.Amount__c;
    }
    
    public PageReference saveNew(){
         PageReference pr = null;
        fund = [SELECT id,Currency__c,Amount__c, Cut_off_Time__c FROM UT_Fund__c WHERE Id = : uttrans.UT_Fund_name__c];
         if(fund.Cut_off_Time__c < = system.now() && !validationWarning){
            
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'CutOFF time is passed'));
            validationWarning = true;
         }
        else{
            if(utTrans.Amount__c != null && utTrans.No_of_Units__c != null){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Either values have to be entered'));
            }
            else 
            {    
                
                if(utTrans.Transaction_Price__c != null)
                {
                    if(utTrans.Amount__c != null ){
                        utTrans.No_of_Units__c =  utTrans.Amount__c/utTrans.Transaction_Price__c;
                    }
                    else if(utTrans.No_of_Units__c != null) {
                        utTrans.Amount__c = utTrans.No_of_Units__c * utTrans.Transaction_Price__c;
                    }
                }
                insert uttrans;
                pr = new ApexPages.StandardController(uttrans).view();
        		if(uttrans.Transaction_Type__c == 'Purchase (switch In)'){
                	/*UT_Transactions__c ut = new UT_Transactions__c ();
                    ut.Transaction_Type__c = 'Redemption (Switch Out)';
                    ut.UT_Fund_name__c = uttrans.UT_Fund_name__c;*/
                    pr = Page.UT_Transaction_Entry;
                    pr.getParameters().put ('Transaction Type','Redemption(Switch Out)');
                    pr.getParameters().put ('UT Fund name',uttrans.UT_Fund_name__c);
                    pr.setRedirect(true);
             } 
            }
        }
        return pr;
    }
    
    /*public PageReference save(){
        if(uttrans.UT_Fund_name__r.Cut_off_Time__c < = system.now()){
           ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'CutOFF time is passed'));
       }
        insert uttrans;
        List <UT_Transactions__c> translist = [Select id,
                                               UT_Fund_name__r.Currency__c,
                                               UT_Fund_name__r.Amount__c,
                                               UT_Fund_name__r.Cut_off_Time__c, 
                                               Confirm_to_Submit__c 
                                               from UT_Transactions__c 
                                               where id =: uttrans.id ];
        system.debug('translist'+translist);
        uttrans.Currency__c = translist[0].UT_Fund_name__r.Currency__c;
        uttrans.Transaction_Price__c = translist[0].UT_Fund_name__r.Amount__c;
        update uttrans; 
        UT_Transactions__c ut = new UT_Transactions__c ();
        if(uttrans.Transaction_Type__c == 'Purchase (switch In)' && uttrans.Transaction_Type__c !=null){
            ut.Transaction_Type__c = 'Redemption (Switch Out)';
            ut.UT_Fund_name__c = uttrans.UT_Fund_name__c;
            insert ut;
            return(new ApexPages.StandardController(ut).edit());
        }
        else if(uttrans.Transaction_Type__c == 'Redemption (Switch Out)' && uttrans.Transaction_Type__c !=null){
           ut.Transaction_Type__c = 'Purchase (switch In)';
            ut.UT_Fund_name__c = uttrans.UT_Fund_name__c;
           insert ut;
            return(new ApexPages.StandardController(ut).edit());
        }
        else if(translist[0].UT_Fund_name__r.Cut_off_Time__c < = system.now()){
            
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'CutOFF time is passed'));
            
            return null;
            
            
        }
        return(new ApexPages.StandardController(uttrans).view());
     
    }*/
    
}