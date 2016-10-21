public with sharing class FetchObjects 
{
    
    public String strQuery { get; set; }
    public String value1 {get;set;}
    public list<Selectoption> lstOptions {get;set;}
    public String selectedstage{get;set;}
    public String selectedObject{get;set;}
    public Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
    public List<Selectoption> lstfieldname{get;set;}
    public List<Sobject> lstObject{get;set;}
    public List<String> lstSelectedFields{get;set;}
    public FetchObjects()
    {
        Apexpages.addMessage(new Apexpages.Message(ApexPages.Severity.INFO,'First choose an object to use the SOQL builder wizard.'));
        try
        {
            lstOptions = new List<Selectoption>();
            lstfieldname=new List<Selectoption>();
            lstObject=new List<Sobject>();
            lstOptions.add(new Selectoption('','--None--'));
            for(Schema.Sobjecttype objSobject: schemaMap.values())
            {           
                if(objSobject.getDescribe().isQueryable())          
                    lstOptions.add(new Selectoption(objSobject.getDescribe().getname(),objSobject.getDescribe().getLabel())); 
            }
            lstOptions.sort();
            value1 = 'ASC';
        }
        catch(Exception e)
        {
            if(lstOptions.isEmpty())
                Apexpages.addMessage(new Apexpages.Message(ApexPages.Severity.INFO,'There is No @@@!!'));
        }
    }
	public void getFields()
    {
        try
        {
            lstfieldname.clear();
            Map<String,schema.Sobjectfield> mapFields = schemaMap.get(selectedObject).getDescribe().fields.getMap();
            Set<String> keys=mapFields.keySet();

            for(schema.Sobjectfield objSobjectFeild:mapFields.values())
                lstfieldname.add(new Selectoption(objSobjectFeild.getDescribe().getname(),objSobjectFeild.getDescribe().getLabel ()));
          }
        catch(Exception e)
        {
            if(lstfieldname.isEmpty())
                Apexpages.addMessage(new Apexpages.Message(ApexPages.Severity.INFO,'There is No fields!!'));
        }
    }
    
    public void getRecords()
    {
        try
        {
            lstObject = Database.query(strQuery) ;
            
        } 
        catch(Exception e)
        {
            if(lstObject.isEmpty())
                Apexpages.addMessage(new Apexpages.Message(ApexPages.Severity.INFO,'There is No Records!!'));
        }
    }
    
    public List<SelectOption> getstagelist()
    {
        List<SelectOption> stagelist=new List<SelectOption>();
        stagelist.add(new SelectOption('500','500'));
        stagelist.add(new SelectOption('1000','1000'));
        stagelist.add(new SelectOption('5000','5000'));
        stagelist.add(new SelectOption('50000','50000'));
        return stagelist;
    }
    
    public void getquery(){
        lstObject = new List <Sobject>();
      strQuery = 'SELECT ' +
      String.join( lstSelectedFields, ',' ) +
  ' FROM ' + selectedObject+ ' ORDER BY '+' CreatedDate '+ value1 +' LIMIT '+ selectedstage ; 
        
    }
}