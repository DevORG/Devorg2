@istest(SeeAllData = true)
 Private class TestClass_LogITController
 {
 /*
Richard - created this Test class for LogITController
*/
    static testMethod void TestMethod_LogITController()
    {    
        Activity_Logs__c TestActivityLogRecord = new Activity_Logs__c (Name='TestClass_LogITController_Test Record' ); 
        
        Test.StartTest();        
        LogITController TestContlrObject = new LogITController ();
        TestContlrObject.LogStartTime();
        TestContlrObject.setActivityLog(TestActivityLogRecord );
        TestContlrObject.LogStartTime();
        TestContlrObject.LogStartTime();
        TestContlrObject.LogStopTime();
        TestContlrObject.ShowLogComments();
        TestContlrObject.LogSave();
        TestActivityLogRecord = TestContlrObject.getActivityLog();         
        TestContlrObject.LogDelete();
        
         LogITController NextTestContlrObject = new LogITController ();
         TestActivityLogRecord.Name= 'Test Activity 2';          
         NextTestContlrObject.setActivityLog(TestActivityLogRecord );         
         NextTestContlrObject.LogStartTime();
         TestContlrObject.LogStopTime();
         LogITPageController TestPageContlrObject = new LogITPageController();
         TestPageContlrObject.getChartData();
         Test.StopTest();   
        
        
    }
    
 
 }