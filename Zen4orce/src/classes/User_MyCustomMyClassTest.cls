@isTest
public class User_MyCustomMyClassTest {
    private static testmethod void customUser() {
        HR__c hr = new HR__c ();
        hr.First_Name__c = 'Shilpa';
        hr.Last_Name__c = 'Test';
        hr.Email__c = 'shilpa@abc.com';
        hr.Employee_Number__c = '200';
        insert hr;
        PageReference pageRef = Page.NewUser;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('id', hr.Id);
        User_MyCustomMyClass custuser = new User_MyCustomMyClass ();
        system.assertEquals(custuser.use1.FirstName, hr.First_Name__c);
        system.assertEquals(custuser.use1.LastName, hr.Last_Name__c);
        system.assertEquals(custuser.use1.Email, hr.Email__c);
        system.assertEquals(custuser.use1.EmployeeNumber, hr.Employee_Number__c);
        custuser.use1.ProfileId = '00e28000001m5x9';
        custuser.use1.Profile = [ select id from profile where id = '00e90000001rSer' ];
        custuser.save();
        List <HR__c> hr12 = [Select id, User__c from HR__c];
        system.assertEquals(custuser.use1.id, hr.User__c);


    }

}