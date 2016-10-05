public class UTTransactionExtensionEdit {
    public UT_Transactions__c uttrans{get;set;}
    public ApexPages.StandardController sController;
    
    public UTTransactionExtensionEdit(ApexPages.StandardController controller) {
        this.sController = controller;
        uttrans = (UT_Transactions__c) controller.getrecord();
     }
    public PageReference save() {
       List <UT_Transactions__c> ut = [Select id, Amount__c, No_of_Units__c, Transaction_Price__c from UT_Transactions__c where id=:uttrans.Id ];
        system.debug('old value'+uttrans);
        system.debug('new value'+ut);
        if(uttrans.Transaction_Price__c != null && uttrans.Amount__c != null){
            uttrans.No_of_Units__c = uttrans.Transaction_Price__c / uttrans.Amount__c;
            update uttrans;
            //system.debug('@@@@@@'+uttrans);
            return(new ApexPages.StandardController(uttrans).view());
        }
        else if(uttrans.Transaction_Price__c != null && uttrans.No_of_Units__c != null){
            uttrans.Amount__c = uttrans.Transaction_Price__c * uttrans.No_of_Units__c;
            update uttrans;
            //system.debug('$%$%$%$%$'+uttrans);
            return(new ApexPages.StandardController(uttrans).view());
        }
        else if(uttrans.Transaction_Price__c !=null && uttrans.Transaction_Price__c != ut[0].Transaction_Price__c && (uttrans.Amount__c == null || uttrans.No_of_Units__c == null)){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'You are not allowed to change the Transaction Price'));
            //system.debug('$%$%$%$%$'+uttrans);
            return null;
        }
        return(new ApexPages.StandardController(uttrans).view());
    }
}