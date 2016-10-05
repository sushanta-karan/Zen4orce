public with sharing class ControllerBioBriefing {
        private final BioBriefing__c bio;
        public blob picture {get;set;}
    public String errorMessage { get; set; }
    public ApexPages.StandardController stdController;
    
    public ControllerBioBriefing(apexpages.standardController stdController){
        this.bio = (BioBriefing__c)stdController.getRecord();
        this.stdController = stdController;
    }
    
    public  PageReference uploadphoto(){
        
        try {
            
  			
             if(picture != null) {
                Attachment attachment = new Attachment();
                attachment.body = picture;
                attachment.name = 'bio_' + bio.id + '.jpg';
                attachment.parentid = bio.id;
                attachment.ContentType = 'application/jpg';
                insert attachment;
                bio.imageUrl__c =  attachment.id;
                update bio;
            }
            return (new ApexPages.StandardController(bio)).view();
            
}
        catch(System.Exception ex) {
            errorMessage = ex.getMessage();
            return null;
    
}
}
}