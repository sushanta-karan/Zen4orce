public class ContactAndLeadSearch {
    public static List<List< SObject>> searchContactsAndLeads(String name){
        List<List<sObject>> searchList = [FIND :name IN ALL FIELDS 
                   RETURNING Contact(LastName,FirstName),Lead(FirstName,LastName)];
        Contact[] searchContact = (Contact[])searchList[0];
        List<Lead> searchLead = searchList.size() >  1 ? (List<Lead>)searchList[1] :  new List<Lead>();
		

System.debug('Found the following Lead.');
for (Lead a : searchLead) {
    System.debug(a.LastName);
}
System.debug('Found the following contacts.');
for (Contact c : searchContact) {
    System.debug(c.LastName  +','+ c.FirstName );
    
}
        return searchList;
    }
}