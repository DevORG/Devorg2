public with sharing class Account_Email_PDFForm_Ext {
    private final Account request;
    private final User currentUser;
    private final User requestor;
    public boolean sentSuccessfully {get;private set;}
    
    public string toEmailList {get;set;}
    public string ccEmailList {get;set;}
    public string emailBody {get;set;}
    public string emailSubject {get;set;}
    public Account_Email_PDFForm_Ext(ApexPages.StandardController controller) {
        request = (Account) controller.getRecord();
    }

}