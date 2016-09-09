public class StringArrayTest {
    public static List<String> generateStringArray(integer a){
        
        List <String> listOfString=new List<String>();
        for(integer i =0;i<a ;i++)
        {
           listOfString.add('Test '+i); 
        }
           
         system.debug('ListOfString'+listOfString);
         return listOfString ;
    }
}