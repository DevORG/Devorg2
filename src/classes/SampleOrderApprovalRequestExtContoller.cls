public with sharing class SampleOrderApprovalRequestExtContoller {

}
/*
public with sharing class SampleOrderApprovalRequestExtContoller {
public Boolean showRec {get; set;}
public list<Case_Products__c> caseProductSelectedList {get; set;}
public list<Case_Products__c> caseProductList {get; set;}
//public list<Case> parentCaseList {get; set;}
//public list <Id> caseProductList2 {get; set;}
    public SampleOrderApprovalRequestExtContoller(ApexPages.StandardSetController controller) {
        
       caseProductSelectedList = controller.getSelected();
        
        //system.debug(caseProductList );
       
        


    }
    public void selectRecords()
    {
    if (caseProductSelectedList.size() > 0)
    {
       showRec = true;
    
       caseProductList = [Select c.Send_for_Approval__c, c.Quantity__c, c.Product__c,c.Id ,c.Case__c  From Case_Products__c c  where c.Id IN :caseProductSelectedList];
       for(Case_Products__c cPL: caseProductList){
       	cPL.Send_for_Approval__c =true;
       	
       }
       if (caseProductList.size()>0)
              update caseProductList;
    }
       else
       {
       showRec =false;     
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Select the records for approval in Case Screen (Previous Screen).'));
       }

 
    }
    public PageReference backToCase()
    {
        //PageReference disPage = new PageReference('/' + parentCaseList.Id);
        return  null; 
    }

} */


//page

/*
<apex:page standardController="Case_Products__c" extensions="SampleOrderApprovalRequestExtContoller" recordSetVar="CaseProducts" action="{!selectRecords}">
  <apex:form >
<apex:pageMessages />

<apex:pageBlock rendered="{!showRec}" >
             
             <apex:pageBlockTable value="{!caseProductList }" var="cPList">
             
             <apex:column value="{!cPList.Case__c}"/>
             <apex:column value="{!cPList.Product__c}"/>
             <apex:column value="{!cPList.Quantity__c}"/>
              

             
             </apex:pageBlockTable>
             
            
           <!--     <center><apex:commandButton value="Go to Discretionary Request" action="{!Back}" rendered="{!backto}" /></center> -->
 
            </apex:pageBlock>
            <center>
<apex:outputText rendered="{!showRec}" style="font-size:16px; text-align:center; color:grey; font:Calibri; " value="Above records are send for approval"/>
</center> 
<center>
<apex:commandButton value="Go to Sample order Case Request" action="{!backToCase}"  />
</center>
</apex:form>

</apex:page>
*/