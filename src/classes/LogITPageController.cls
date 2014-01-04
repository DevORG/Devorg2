public with sharing class LogITPageController {
public List<Activity_Logs__c> getChartData() {
        List<Activity_Logs__c> data = new List<Activity_Logs__c>([select Name,Start_Time__c,End_Time__c ,Duration_In_Time__c,Duration__c,Owner.Name from Activity_Logs__c where End_Time__c != null and Start_Time__c = TODAY  order  by End_Time__c limit 100]);
         
        return data;
    }
   public void LogITPageController (){
   
   }

}