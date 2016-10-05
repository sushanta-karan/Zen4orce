public with sharing class My_Student {
    public Student__c stu{get;set;}
    public String Name{get;set; }
        

      
  
    public My_Student(){
        stu = new Student__c();
        
       List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('', '-- Select One --'));
        Map<String, Language__c> languages = Language__c.getAll();
        List<String> countryNames = new List<String>();
        countryNames.addAll(languages.keySet());
        countryNames.sort();
       for (String countryName : countryNames) {
            Language__c lang = languages.get(countryName);
            options.add(new SelectOption(lang.Name, lang.Name));
        }
        //return options;
      
    }
    public PageReference save(){
        insert stu;
        PageReference redirectSuccess = new ApexPages.StandardController(stu).view();
        return (redirectSuccess);
    }
    public PageReference cancel(){
        
        return null;
    }

}