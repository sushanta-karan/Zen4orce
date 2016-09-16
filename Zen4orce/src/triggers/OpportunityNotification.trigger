trigger OpportunityNotification on Opportunity (after insert) {
Opportunity i=[select ownerid, id,Owner.manager.email,Owner.manager.name from opportunity where id=:trigger.newMap.keySet()];
    EmailTemplate et=[Select id from EmailTemplate where name=:'Opps Template'];
    List<Messaging.SingleEmailMessage> email = new List<Messaging.SingleEmailMessage>();
for (Opportunity o : Trigger.new) 
{ 
if(o.Amount>25000){  
    String userEmail = i.Owner.manager.email; 
   Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
    mail.setTargetObjectId(i.owner.manager.Id);
    mail.setTemplateID(et.Id);
    mail.setSaveAsActivity(false);
    String[] toAddresses = new String[] {userEmail}; 
        mail.setToAddresses(toAddresses); 
    email.add(mail);
    system.debug('opp'+email);


//mail.setSubject('Automated email: Opps Details'); 
//String body = 'Amount is greater than 25000'; 
//mail.setPlainTextBody(body); 
Messaging.sendEmail(email);
} 
} 
}