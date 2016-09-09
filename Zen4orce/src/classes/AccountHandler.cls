public class AccountHandler {
    public static Account insertNewAccount(String name) {
        Account Acct = new Account();
        Acct.Name = name;
        try
        {
          insert Acct;
            return Acct;
        } catch (Exception e) {
            System.debug('A DML exception has occurred: ' + e.getMessage());
            return null;
        }
        
    }
}