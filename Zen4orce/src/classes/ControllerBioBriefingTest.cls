@isTest
public class ControllerBioBriefingTest {
    private static testmethod void uploadphotoTest(){
        BioBriefing__c biob = new BioBriefing__c();
        biob.Name = 'TestA';
        insert biob;
        // For Page Reference
        ControllerBioBriefing bioctrl = new ControllerBioBriefing (new ApexPages.StandardController (biob));
        //For Blob
        bioctrl.picture = Blob.valueOf('Test Data');
        bioctrl.bio.id = biob.id; 
        bioctrl.uploadphoto();
        List <Attachment> attach = [Select id,parentid From Attachment WHERE parentid =: biob.id];
        //system.debug('size'+attach.size());
        system.assertEquals(1, attach.size());
        List<BioBriefing__c> biob1 = [Select id,imageUrl__c FROM BioBriefing__c];
        for(BioBriefing__c b1 : biob1){
            system.debug('image'+b1.imageUrl__c);
        system.assertEquals(String.valueOf(attach[0].Id),b1.imageUrl__c);
              }
    }
}