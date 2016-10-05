public class CreateUser{
    private final User user;
    public id recordid;
    public HR__C hr1 {get;set;}
    //private final HR__c hr {get;set;} 
    public createuser(Apexpages.standardcontroller cont){
    this.user=(user)cont.getrecord(); 
   this.recordid = ApexPages.currentPage().getParameters().get('id');
        hr1 = [Select ID,First_Name__c,Last_Name__c,Employee_Number__c,Email__c FROM HR__c WHERE id=:recordid];
        system.debug('rec id'+recordid);
        system.debug('hr id'+hr1);
    }
    
    Public list<selectOption> getLicense(){
        List<selectOption> options=new List<selectoption>();
        options.add(new selectOption('', '- None -')); //for default values
        for(UserLicense u:[Select id,Name from UserLicense]){
            options.add(new selectoption(u.id,u.name));      
        
        }
        
        return options; 
    
    
    }    
    public List<selectOption> getProfile() {

      List<selectOption> options1 = new List<selectOption>(); //new list for holding all of the picklist options

      options1.add(new selectOption('', '- None -')); //add the first option of '- None -' in case the user doesn't want to select a value or in case no values are returned from query below

   
   for (Profile users1 :[SELECT Id,Name FROM Profile where UserLicenseId=:user.UserType] )  {   

              options1.add(new selectOption(users1.Id, users1.Name)); //for all records found - add them to the picklist options

      }
    
    return options1;
    }
    }