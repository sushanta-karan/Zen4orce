public class opportunityLocationHandler {
    public static void beforeInsert(List<OpportunityLocation__c> oppLoc){
        Map<id,HR__c> hrEmployeenumberMap = new Map<id,HR__c> ();
        Map<string,HR__c> hrEmployeenumberMapstr = new Map<string,HR__c> ();
        Set<String> hrEmployeenumber = new set<String> ();
        List <HR__c> hrList = [SELECT id, Employee_Number__c FROM HR__c WHERE Employee_Number__c !=null];
        for(HR__c hr1 : hrList){
            hrEmployeenumberMap.put(hr1.id,hr1);
            hrEmployeenumber.add(hr1.Employee_Number__c);
            hrEmployeenumberMapstr.put(hr1.Employee_Number__c, hr1);
        }
       
        List<Contact> conList = [Select id,Employee_Id__c,Reports_To_Employee_Id__c from Contact WHERE 
                                 Employee_Id__c in: hrEmployeenumber and Reports_To_Employee_Id__c in: hrEmployeenumber];
        Map<string,Contact> conmap = new Map<string,Contact> ();
        for(Contact con : conList){
            conmap.put(con.Employee_Id__c,con);
        }
        system.debug('contact map'+conmap);
        
        for(OpportunityLocation__c opploc1 : oppLoc){
            if(opploc1.Current_Year_Rep__c != null){
                string hrstr = hrEmployeenumberMap.get(opploc1.Current_Year_Rep__c).Employee_Number__c;
                string idstr = conmap.get(hrstr).Employee_Id__c;
                string hrstr1 = hrEmployeenumberMapstr.get(conmap.get(hrstr).Reports_To_Employee_Id__c).Employee_Number__c;
                string constr = conmap.get(hrstr).Reports_To_Employee_Id__c;
                system.debug('string123' + constr);
                if(hrstr == idstr){
                    //system.debug('contact new' + conmap.get(hrEmployeenumberMap.get(opploc1.Current_Year_Rep__c).Employee_Number__c).Employee_Id__c);
                    if(constr == hrstr1){
                           opploc1.Current_Year_Manager__c = hrEmployeenumberMapstr.get(constr).id;
                       }
                }
            }
            if(opploc1.Product_Specialist__c != null){
                string hrstr = hrEmployeenumberMap.get(opploc1.Product_Specialist__c).Employee_Number__c;
                string idstr = conmap.get(hrstr).Employee_Id__c;
                string hrstr1 = hrEmployeenumberMapstr.get(conmap.get(hrstr).Reports_To_Employee_Id__c).Employee_Number__c;
                string constr = conmap.get(hrstr).Reports_To_Employee_Id__c;
                system.debug('string123' + constr);
                if(hrstr == idstr){
                    //system.debug('contact new' + conmap.get(hrEmployeenumberMap.get(opploc1.Current_Year_Rep__c).Employee_Number__c).Employee_Id__c);
                    if(constr == hrstr1){
                           opploc1.Product_Specialist_Manager__c = hrEmployeenumberMapstr.get(constr).id;
                       }
                }
            }
            
            if(opploc1.Second_Specialist__c	!= null){
                string hrstr = hrEmployeenumberMap.get(opploc1.Second_Specialist__c).Employee_Number__c;
                string idstr = conmap.get(hrstr).Employee_Id__c;
                string hrstr1 = hrEmployeenumberMapstr.get(conmap.get(hrstr).Reports_To_Employee_Id__c).Employee_Number__c;
                string constr = conmap.get(hrstr).Reports_To_Employee_Id__c;
                system.debug('string123' + constr);
                if(hrstr == idstr){
                    //system.debug('contact new' + conmap.get(hrEmployeenumberMap.get(opploc1.Current_Year_Rep__c).Employee_Number__c).Employee_Id__c);
                    if(constr == hrstr1){
                           opploc1.Second_Specialist_Manger__c = hrEmployeenumberMapstr.get(constr).id;
                       }
                }
            }
        }
        
        
    }
}