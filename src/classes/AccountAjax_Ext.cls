public class AccountAjax_Ext {
private User requestor;
User Manager;
private final Account request;
public string UserManager{get; set;}

public AccountAjax_Ext(ApexPages.StandardController stdController) {
                request = (Account) stdController.getRecord();
                }

public PageReference updateManager(){
                
                requestor = [select id, managerid
                        from user
                        where id=:request.OwnerId
                        ]; 
                List<User> managers = [select id 
                        from user 
                        where id=:requestor.managerid
                        ];
                if (managers.size() == 1){
                        //request.Manager__c = managers[0].id; 
                        UserManager = managers[0].id;
                        request.OwnerId= managers[0].id;
                }
                return null;
                
        }
}