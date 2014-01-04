/***********************************************************************
* Author        : Ayush / Nirdesh
* Description   :  This is the test class of class "CS_ProductTreeView".
* 
* 
************************************************************************/

@isTest
private class CS_Test_CS_ProductTreeView{
    static testMethod void CS_ProductTreeViewTestOne() {
         Profile p = [SELECT Id FROM Profile WHERE Name='System administrator'];
         User u = new User(Alias = 'newUser', Email='developersatWork@wipro.com',
                     EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
                     LocaleSidKey='en_US', ProfileId = p.Id,
                     TimeZoneSidKey='America/Los_Angeles',UserName='developersatWork@wipro.com',Country='india'); 
         insert u;
         /*Creating the test account.*/
         
         Account objacc = new Account(Name='AkzoWipro',Ownerid=u.id);
         insert objacc;
         Account acc=[Select id,name from account where id=:objacc.id];
         system.assertEquals('AkzoWipro',acc.Name);
         /*Creating the test Case record. */
         
         Case cs=new Case(Status='New',Origin='Phone',AccountId=objacc.id);
         insert cs;
         
         /*Calling the method to create the product structure.*/
         
         createProd();
         
         /*Test Starts here  */
         
         Test.startTest();
         ApexPages.currentPage().getParameters().put('id',cs.Id); 
         
         /*Creating the controller object*/
         
         CS_ProductTreeView prodTreeView=new CS_ProductTreeView(new ApexPages.StandardController(cs));
         
         /*Calling the generatTreeStructureForProducts */
         
         prodTreeView.GenerateTreeStructureForProducts();
         
         /*Calling the update case method*/
         
         prodTreeView.updateCase();
         
         /*Test Ends here*/
         Test.stopTest();
    }
    
    /*Method for creating the product starts here */
    
    public static void createProd(){
        Product2 pd=new Product2(Name='Grand Parent',Description='GParent',CS_Parent_Product__c=null,isActive=true);
        insert pd;
        Product2 cpd=new Product2(Name='Child of pd',Description='Test',CS_Parent_Product__c=pd.id,isActive=true);
        insert cpd;
        system.assertEquals(cpd.CS_Parent_Product__c,pd.id);
        Product2 cpd1=new Product2(Name='Child of pd',Description='Test',CS_Parent_Product__c=pd.id,isActive=true);
        insert cpd1;
        Product2 cpd2=new Product2(Name='Child of cpd',Description='Test',CS_Parent_Product__c=cpd.id,isActive=true);
        insert cpd2; 
        system.assertEquals(cpd2.CS_Parent_Product__c,cpd.id);   
    }
    /*Method for creating the product ends here*/
}