@isTest
public class CampaignDetailExtensionTest {
    private static testmethod void uploadphotoTest(){
        Campaign camp = new Campaign ();
        camp.Name = 'Shilpa';
        camp.EndDate = system.today()+10;
        camp.EndDate = system.today();
        camp.Status = 'Planned';
        camp.Type = 'Conference';
        camp.IsActive = true;
        camp.NumberSent = 200.00;
        insert camp;
        CampaignDetailExtension cam = new CampaignDetailExtension (new ApexPages.StandardController (camp));
        cam.copy();
        List<Campaign> camp1 = [Select id,Campaign_Soft_Delete_Pending__c from Campaign];  
        system.assertEquals(2, camp1.size());
        cam.softdelete();
        List<Campaign> camp2 = [Select id,Campaign_Soft_Delete_Pending__c from Campaign];  
        system.assertEquals(true, camp2[0].Campaign_Soft_Delete_Pending__c);
    }

}