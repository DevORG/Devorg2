public class ESEPocAccountExtController {
 

    public String SelectedAcc{get; set;} 
    public  SET<ID> Keys= new SET<ID>() ; 
    public Account acct {get; set;}
    public Account SelectAccount {get; set;}
    public String SelectedAccId {get; set;}
    public Boolean showPanel   {get; set;}
    Public Boolean insertflag {get;set;}
  //  public void setSelectedAccId(String AccId)
  //  {
  //      SelectedAccId=AccId;
  //  }
  //    public string getSelectedAccId()
  //  {
  //     return SelectedAccId;
  //  }
    
    public ESEPocAccountExtController() {
    
    System.debug('first' + SelectedAccId );
    
        showPanel = False; 
    //this.acct = (Account)controller.getRecord();
    If (acct==null)
    {
     this.acct=new Account();
     }
    selectedAccounts.clear();
    for(accountwrapper accwrapper : accountList)
        if(accwrapper.selected == true)
        selectedAccounts.add(accwrapper.acc);

    }
     
public PageReference SaveExt()
{
try{
Insert acct;
insertflag = true;
System.debug('after Innsert ' + acct);
//PageReference pageref = ApexPages.currentPage();
//pageref.setRedirect(true);
//return pageref;
return null;
}
catch(DmlException ex)
{
System.debug('Exception ' + acct);
insertflag = false;
ApexPages.addMessages(ex);
return null;
} 

//return null;
} 
   /*
   * This source code was written by SrinivasaRao Pendala. 
   * I have made every effort and taken great care in making sure that the source
   * code and other content included on my wiki is technically accurate.
   * As with any code, ensure to test this code in a development environment 
   * before attempting to run it in production.
   */

    List<accountwrapper> accountList = new List<accountwrapper>();
    List<Account> selectedAccounts = new List<Account>();
    
    public List<accountwrapper> getAccounts()
    {
        accountList.clear();
        for(Account a: [select Id, Name, AccountNumber, Phone ,Fax,Industry from Account where Id NOT IN :Keys ORDER BY CreatedDate DESC limit 5])
        accountList.add(new accountwrapper(a));
        return accountList;
    }
    
    public void getSelected()
    {
        selectedAccounts.clear();
        for(accountwrapper accwrapper : accountList)
        if(accwrapper.selected == true)
        selectedAccounts.add(accwrapper.acc);
       // return null;
    }
    public void getSelectedDemo( )
    {
        
        //selectedAccounts.clear(); String SelectedId
        //for(accountwrapper accwrapper : accountList)
        //if(accwrapper.selected == true)
        //selectedAccounts.add(accwrapper.acc);
        //system.debug('****');
        //System.debug('Hi'+ SelectedAcc);
        Keys.add(SelectedAcc);
        //return null;
    }
    
    public List<Account> GetSelectedAccounts()
    {
        if(selectedAccounts.size()>0)
        return selectedAccounts;
        else
        return null;
    }    
    
    public class accountwrapper
    {
        public Account acc{get; set;}
        public Boolean selected {get; set;}
        public accountwrapper(Account a)
        {
            acc = a;
            selected = false;
        }
    }
  
    
    public void getAccountDetails()
    {
        SelectAccount = [ Select a.Id, a.Rating, a.Phone, a.ParentId, a.Name, 
             a.Industry, a.Fax, a.CreatedDate, a.CreatedById, a.BillingStreet, 
             a.BillingState, a.BillingPostalCode, a.BillingCountry, a.BillingCity, a.AccountNumber From Account a where a.Id = :SelectedAccId limit 1 ];
          //SelectedAccId=Apexpages.currentPage().getParameters().get('SelectedId');
         //SelectedAccId=Apexpages.currentPage().getParameters().get('AccSelId');
         System.debug('$$$$$');
         System.debug('hi ' + SelectedAccId );
         
         showPanel = True;
          
        // return null;
    }
}