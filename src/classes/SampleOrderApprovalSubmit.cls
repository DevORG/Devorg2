public class SampleOrderApprovalSubmit {
}


/*
* File Name:  SampleOrderApprovalSubmitController
* Description: Controller for VF page SampleOrderApprovalSubmit
* Copyright : Wipro Technologies Limited Copyright (c) 2011
* @author : Wipro
* Modification Log Starts ===============================================================
* Controller created for the Sample Order requirment - plymouth Ticket. 
* Modification Log Ends =============================================================== 
* Ver Date Author Modification --- ---- ------ -------------
*/ 
/*public class SampleOrderApprovalSubmit {

	private final ApexPages.StandardController backToCaseController;
	public list<Case> sampleOrderCase;
	public list<String> approverList = new list<String>() ;
    public SampleOrderApprovalSubmit(ApexPages.StandardController stdcontroller) {
    	backToCaseController=stdcontroller;

    }
    // Retrive Records from Approver Matrix Object for the selected Case for the Productline item
    public PageReference  approvalProcess()
    {
    	sampleOrderCase =[Select c.Id, c.Approval_Status__c, c.Sample_Order_Approver__c ,c.Sample_Order_CSR__c, c.Product_Line__c,c.CaseNumber,c.CreatedDate,c.Phone_Number__c,c.Email_Address__c, c.Account_Name__c,c.Other_Comments__c  From Case c where c.id =:backToCaseController.getId()];
    	set<string> ProdctList= new set<string>(); 
    	    	  
    	for (Case tmpCase:sampleOrderCase) {
				
				ProdctList.add(tmpCase.Product_Line__c);
		}
		
		list <Sample_Order_Approver__c> approverProductList = new list <Sample_Order_Approver__c> ([Select s.Product_Line__c,s.Customer_Support_Rep__r.Email, s.Customer_Support_Rep__c, s.Approver__c,s.Approver__r.Email From Sample_Order_Approver__c s where s.Product_Line__c IN :ProdctList ]);
		
		
		
		for (Case tmpCase:sampleOrderCase) {
				// Change the Status for the Case to Pending for Approval
				tmpCase.Approval_Status__c='Pending For Approval';
				if (approverProductList.size() > 0)
				{
					for (Sample_Order_Approver__c smplOdrApp:approverProductList)
					{
						if (tmpCase.Product_Line__c ==smplOdrApp.Product_Line__c )
						{
							// Map the Approver Manager and CSR with the specific Productline of the Case  
							tmpCase.Sample_Order_Approver__c=smplOdrApp.Approver__c;
							tmpCase.Sample_Order_CSR__c=smplOdrApp.Customer_Support_Rep__c;
							
							approverList.add(smplOdrApp.Approver__r.Email);
							
						}
					 
					}
				}
		}
		
    	update sampleOrderCase;
    	sendApprovalMail();
    	
    	return backToCaseController.view().setRedirect(true);
    }
    
    private void sendApprovalMail()
    {
    	// Medthod to send Approval mail.
    	Messaging.SingleEmailMessage approvalMail = new Messaging.SingleEmailMessage();
    	
    	approvalMail.setToAddresses(approverList);
    	approvalMail.setReplyTo('no-reply@honeywell.com');
    	
    	//approvalMail.setReplyTo('support@honeywell.com');
    	approvalMail.setSenderDisplayName('Salesforce Support');
    	string emailSubject='Honeywell M&PS B2B Case  SAMPLE REQUEST Review Required ';
    	string emailText = 'Sample Request Notification  \n \n The following sample request was made via M&PS\'s electronic storefront \n \n';
    	 emailText= emailText+'Please review the order and either approve or deny the sample request by going to the following link';
    	string emailHtmlText = 'Sample Request Notification </BR> ';
    	emailHtmlText = emailHtmlText+'The following sample request was made via M&PS\'s electronic storefront.  </BR> <P>';
    	emailHtmlText = emailHtmlText+'Please review the order and either approve or deny the sample request by going to the following link  </BR> <P>';
    	// To retrive the current server and create the VF page. 
    	string host=ApexPages.CurrentPage().getHeaders().get('Host');
    	string otherComments = '  ';
    	
    	for (Case tmpCase:sampleOrderCase) {
    		
				emailSubject = 'Honeywell M&PS B2B Case '+ tmpCase.CaseNumber +' SAMPLE REQUEST Review Required ';
				//emailSubject=emailSubject+tmpCase.Id;
				emailText=emailText+ 'https://'+host+'/apex/SampleOrderApproval?id='+tmpCase.Id;
				emailHtmlText=emailHtmlText+'To view the request <a href=https://'+host+'/apex/SampleOrderApproval?id='+tmpCase.Id+'>click here.</a> </BR> <P> <P></BR>';
				
				//emailHtmlText = emailHtmlText+ 'Date of Order: '+tmpCase.CaseNumber +'</BR> <P>';
				//emailHtmlText = emailHtmlText+ 'Phone:  '+tmpCase.Phone_Number__c +'</BR> <P>';
				//emailHtmlText = emailHtmlText+ 'E-mail:   '+tmpCase.Email_Address__c+'</BR> <P> <P>';
				emailHtmlText = emailHtmlText+ 'Customer Name is   '+tmpCase.Account_Name__c +'</BR> <P> <P>';
				if (tmpCase.Other_Comments__c == null)
				
				emailHtmlText = emailHtmlText+ 'Other Comments:   '+ otherComments +'</BR> <P>';
				else
				emailHtmlText = emailHtmlText+ 'Other Comments:   '+ tmpCase.Other_Comments__c +'</BR> <P>';
				emailHtmlText = emailHtmlText+ 'By placing an order, you agree to the terms and conditions at https://b2b-mps.honeywell.com/shopTerms.asp </BR> <P>';
				 
				
				 
		}
		
		
    	approvalMail.setSubject(emailSubject);
    	approvalMail.setPlainTextBody(emailText);
    	approvalMail.setHtmlBody(emailHtmlText);
    	
    	// Will send the composed Mail
    	Messaging.sendEmail(new Messaging.SingleEmailMessage[] { approvalMail });
		
    	
    	
    
    } 

}*/