@isTest
public class FetchObjectsTest {
    Public static testmethod void MyTest(){
        List<Sobject> objList = new List<Sobject>();
        List<SelectOption> stagelist=new List<SelectOption>();
        FetchObjects qbd =  new FetchObjects();
            qbd.selectedObject = 'Account';
            qbd.getFields();
            qbd.lstSelectedFields =  new List<String>();
            qbd.lstSelectedFields.add('Name');       
            qbd.lstSelectedFields.add('Id');
            qbd.lstSelectedFields.add('OwnerId');
            qbd.lstSelectedFields.add('AccountNumber');
            qbd.lstSelectedFields.add('AnnualRevenue');
            qbd.selectedstage = '5';
            qbd.getstagelist();
            qbd.lstfieldname= stagelist;
            qbd.lstObject = objList ;
            qbd.value1 = 'ASC';
            qbd.strQuery = '';
            
            qbd.getquery();
            qbd.getRecords();
     }
    
    Public static testmethod void MyTestFail(){
        List<Sobject> objList = new List<Sobject>();
        List<SelectOption> stagelist=new List<SelectOption>();
        FetchObjects qbd =  new FetchObjects();
           
           qbd.selectedObject = '';
            qbd.getFields();
            qbd.lstSelectedFields =  new List<String>();
            qbd.lstSelectedFields.add('Name');       
            qbd.lstSelectedFields.add('Id');
            qbd.lstSelectedFields.add('OwnerId');
            qbd.lstSelectedFields.add('AccountNumber');
            qbd.lstSelectedFields.add('AnnualRevenue');
            qbd.selectedstage = '';
            //qbd.getstagelist();
            qbd.lstfieldname= stagelist;
            qbd.lstObject = objList ;
            qbd.value1 = 'ASC';
            qbd.strQuery = '';
            
            qbd.getquery();
            qbd.getRecords();
     }
    Public static testmethod void MyTestFail1(){
        List<Sobject> objList = new List<Sobject>();
        List<SelectOption> stagelist=new List<SelectOption>();
        FetchObjects qbd =  new FetchObjects();
           qbd.lstOptions.clear();
           qbd.selectedObject = 'Account';
            qbd.getFields();
            qbd.lstSelectedFields =  new List<String>();
            qbd.lstSelectedFields.add('Name');       
            qbd.lstSelectedFields.add('Id');
            qbd.lstSelectedFields.add('OwnerId');
            qbd.lstSelectedFields.add('AccountNumber');
            qbd.lstSelectedFields.add('AnnualRevenue');
            qbd.selectedstage = '';
            //qbd.getstagelist();
            qbd.lstfieldname= stagelist;
        	//qbd.lstObject.clear();
            qbd.lstObject = objList ;
            qbd.value1 = 'ASC';
            qbd.strQuery = '';
            
            qbd.getquery();
            qbd.getRecords();
     }

}