public class My_Custom_Controller {

    public PageReference edit() {
        return null;
    }


    public List<Account> ListOfAccount{get;set;}
   
    public My_Custom_Controller() {
    System.debug('richard1');
    string isSave= ApexPages.currentPage().getParameters().get('isSave');
    string getName= ApexPages.currentPage().getParameters().get('Acc');
    if (isSave!= null)
    {
    System.debug('richard1.1'+ ListOfAccount);
    System.debug('richard1.2'+ getName);
    save();
    System.debug('richard2');
    }
    else{
           ListOfAccount=[Select id,Name from Account limit 2];
           System.debug('richard3');
         }  
    }
    Public pagereference Save(){
        System.debug('richard4');
        System.debug('---------Saving------------------'+ListOfAccount);
        update ListOfAccount;
        return null;
    }
          
}