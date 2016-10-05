public class ContactHandlerClass {
    public static void onAfterUpdate (List<Contact> conList,Map <id,Contact> conOldMap){
        try{
        List <Contact> conListToUpdate = new List<Contact>();
        Map<ID,Account> accMap = new Map<Id,Account> ([SELECT ID,OwnerID FROM Account]);
        set<Contact> conId = new set<Contact> ();
        for(Contact con : conList){
            if(con.AccountId != conOldMap.get(con.ID).AccountId ){
                conId.add(con);
            }
        }
        if(conId.size()>0){
            for(Contact cont: conId){
                Account a = accMap.get(cont.AccountId);
                cont.OwnerId = a.OwnerId;
                conListToUpdate.add(cont);
                }
          }
    }
        catch(Exception e){
            system.debug('Exception - '+e.getMessage());
        }
    }
}