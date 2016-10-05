public class User_MyCustomMyClass {
     public User use1{get;set;}
     public HR__c hrobj{get;set;}
    
    public User_MyCustomMyClass() {
        use1 = new User();
        hrobj =  [SELECT Id, Name, Email__c ,Employee_Number__c ,First_Name__c,Last_Name__c FROM HR__c
                   WHERE Id = :ApexPages.currentPage().getParameters().get('id')];
                    use1.FirstName = hrobj.First_Name__c;
                    use1.LastName = hrobj.Last_Name__c;
                    use1.Email = hrobj.Email__c;
                    use1.EmployeeNumber = hrobj.Employee_Number__c;
                    use1.ProfileId = '00e90000001rSe0';
                    //use1.UserRole = [ select id from userrole where id ='00E28000001QlY5' ];
                    use1.Profile = [ select id from profile where id = '00e90000001rSe0' ];
                    

            }
    public PageReference save() {
        try {
            insert use1;
           
            hrobj.User__c = use1.id;
            upsert hrobj;
        } catch(System.DMLException e) {
            ApexPages.addMessages(e);
            return null;
        }
        
        PageReference redirectSuccess = new ApexPages.StandardController(hrobj).view();
        return (redirectSuccess);
            }
}