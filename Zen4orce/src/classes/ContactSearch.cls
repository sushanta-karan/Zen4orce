public class ContactSearch {
    public static List<Contact> searchForContacts(String name,String Mailing) {
        
        List<Contact> Con = [select ID, Name, LastName, MailingPostalCode FROM Contact WHERE LastName = :name AND MailingPostalCode = :Mailing];
        return Con;
    }
}