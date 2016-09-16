public class AccountHandlerClass {
    public static void onAfterUpdate(List<Account> accListnew ,Map<ID,Account> acctodmap,Map <ID,Account> acctnewmap){
       Map<ID,List<Contact>> acct = new map <Id,List<Contact>>();
        Set <ID> acctId = new Set <ID>();
        for(Account acc: accListNew){
             //Account oldAccount = acctodmap.get(acc.Id);
            if(acc.OwnerId != acctodmap.get(acc.Id).OwnerId){
                acctId.add(acc.Id);
            }
        }
        if(acctId.size()>0){
            for(ID id: acctId){
                acct.put(id, new List<Contact>());
            }
            List<Contact> contactsToUpdate = [select AccountId,OwnerId from Contact where AccountId in :acctId];
            for(Contact con : contactsToUpdate){
                con.OwnerId = acctnewmap.get(con.AccountId).OwnerId;
            }
            if(contactsToUpdate.size()>0){
                update contactsToUpdate;
                system.debug('updated '+contactsToUpdate);
            }
        }
    }
}