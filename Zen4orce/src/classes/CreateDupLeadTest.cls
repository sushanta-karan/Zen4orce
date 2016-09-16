@isTest
public class CreateDupLeadTest {
    static testmethod void LeadPositive(){
        List <Lead> leadList=new List<Lead> ();
        Lead l=new Lead();
    l.lastname='AAA';
    l.Company='Company';
        l.Status='Open - Not Contacted';
    leadList.add(l);
    insert leadlist;
        List <Lead> leadListnew=new List<Lead> ();
        Lead l1=new Lead();
        l1.LastName = l.LastName;
        l1.FirstName = l.FirstName;
        l1.Company = l.Company;
        l1.Status = 'Working - Contacted';
        leadListnew.add(l1);
        insert leadListnew;
    }
}