public class MenuController {

    public List<MenuItem__c> getTopLevelItems() {
        return [Select Id, Name, Action__c,(Select Id, Name, Action__c From Sub_Menu_Items__r) From MenuItem__c];
    }

}