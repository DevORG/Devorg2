public with sharing class AccountController {

public Account acc {get; set;}
public boolean IsLogComments {get; set;}

public void saveaccount()
{
insert acc ;
}

public PageReference ShowLogComments()
{
        
        IsLogComments= true;
        return null;
}

public void InitalActions()
{    
acc = new Account ();

}

}