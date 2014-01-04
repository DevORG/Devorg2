public class UploadFile_DifferentOrg {

    public UploadFile_DifferentOrg( )
    {

    }
    String ErrorMessage;

    public void Login()
    {
        
        ErrorMessage='';
        final string baseUrl = 'https://login.salesforce.com/'; 
        final string username = 'thomson.reuters@tr.com'; 
        final string password = 'india@123';
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setEndpoint(baseUrl + '?loginType=&un='+username+'&pw='+password);
        HttpResponse res = h.send(req);
        
          
           req.setEndpoint(baseUrl + 'apex/UploadFile_DifferentOrg');
           
           res = h.send(req);
           if (res.getBody().indexOf('success=true')>-1)
           {
              system.debug('Success');
           }  
        }
    

    }