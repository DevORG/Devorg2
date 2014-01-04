public with sharing class LogITControllerDemo {

Public Activity_Logs__c ActivityLogRecord {get; set;}
public Activity_Logs__c RecentActivityLogRecord;
public Datetime CurrentTime {get; set;}
public decimal LoggedInTime {get; set;}
public string Logging {get; set;}
public Boolean IsLogging {get; set;}
public Boolean IsLogDone{get; set;}
public String RecentAcitivityDisplay{get; set;}
public String AcitivityDisplay{get; set;}
public Boolean IsLogComments {get; set;}
public Boolean IsLogNotes ;

Public Boolean getIsLogNotes()

 {return IsLogComments ;}

Public Void setIsLogNotes(Boolean value)
     {IsLogComments = value;
          
 }


public string LogNotes {get; set;}
Public Activity_Logs__c getActivityLog()

 {return ActivityLogRecord ;}
 
 Public Void setActivityLog(Activity_Logs__c  value)
     {ActivityLogRecord = value;
         system.debug('Richard $$$'+ ActivityLogRecord.Notes__c);
         system.debug('Richard ***'+ LogNotes );
 }
  
    
    public void LogSave()
    {
        insert ActivityLogRecord;
        system.debug('Richard ***'+ LogNotes );
        system.debug('Richard $$$'+ ActivityLogRecord.Notes__c);
        system.debug('Richard ###'+ + IsLogging + IsLogDone);
        RecentActivityLogRecord  = ActivityLogRecord;
        RecentAcitivityDisplay = buildRecentAcitivityDisplay (RecentActivityLogRecord  );
                 
        ActivityLogRecord = new Activity_Logs__c();
 
        IsLogging=False;
        IsLogDone=False;
        IsLogComments= True;
         //return null;
    }
     public PageReference LogDelete()
    {
        ActivityLogRecord = new Activity_Logs__c();
        //system.debug('Richard ***'+ IsLogging);
        IsLogging=False;
        IsLogDone=False;
        system.debug('Richard ***'+ IsLogging + IsLogDone);
        return null;
    }
    
    public PageReference ShowLogComments()
    {
        if (IsLogDone)
            IsLogComments= True;
            
            
            system.debug('Richard $$$'+ ActivityLogRecord.Notes__c);
        system.debug('Richard ###'+ + IsLogging + IsLogDone);
            //IsLogNotes =true;
            return null;
    
    }
    
    public void LogStartTime()
    {
        ActivityLogRecord.Start_Time__c=system.Now();
        if(ActivityLogRecord.Start_Time__c!= null){
        //LoggedInTime =  (System.Now().getTime()  - ActivityLogRecord.Start_Time__c.getTime()) / (1000.0*60.0*60.0);
        Logging='Hour: 0 Min: 0 Sec: 0';
        }
        IsLogging=true;
        IsLogComments=false;
    }
     public void LogStopTime()
    {
        ActivityLogRecord.End_Time__c=system.Now();
        //ActivityLogRecord.Duration__c =Logging;
        //ActivityLogRecord.Notes__c = 'Check This';
        //insert ActivityLogRecord;
        IsLogDone=true;
        IsLogComments=false;
       // IsLogging=False;
        AcitivityDisplay= 'Activity -' +  ActivityLogRecord.Name + ' Logged From '+ ActivityLogRecord.Start_Time__c + ' Logged To '+ActivityLogRecord.End_Time__c +' Duration ' + ActivityLogRecord.Duration__c ;
    
    }
    
    public void IncrementTimer()
    {
        CurrentTime= System.Now();
        //LoggedInTime = (floor((System.Now() -  ActivityLogRecord.Start_Time__c)*24));
        if(ActivityLogRecord!=null && ActivityLogRecord.Start_Time__c!= null){
        //LoggedInTime =  (System.Now().getTime()  - ActivityLogRecord.Start_Time__c.getTime()) / (1000.0*60.0*60.0);  
        LoggedInTime =  (System.Now().getTime()  - ActivityLogRecord.Start_Time__c.getTime()) ; 
        Logging = formateLogTime(ActivityLogRecord.Start_Time__c);
       
        
        //Logging = 'Hour: '+LoggedInHour +' Min:'+ LoggedInMin +' Sec:' +  LoggedInSec ;
        }
    }
    Public void InitalActions ()
    {
          ActivityLogRecord = new Activity_Logs__c();
          ActivityLogRecord = new Activity_Logs__c();
          if (RecentActivityLogRecord == null) {
                RecentActivityLogRecord = new Activity_Logs__c();
                RecentActivityLogRecord  = [ select Name,Start_Time__c ,End_Time__c , Duration__c from Activity_Logs__c order by LastModifiedDate DESC limit 1  ];
               
        }
        RecentAcitivityDisplay = buildRecentAcitivityDisplay (RecentActivityLogRecord  );
        CurrentTime= System.Now();
            IsLogging=false;
            IsLogDone=false;
            IsLogComments=false;
        
    }
    Private string formateLogTime (datetime StartTime)
    {
        String LogTime;
        decimal LoggedInSec = math.round((math.floor(System.Now().getTime()  - StartTime.getTime())/(1000)));
        decimal LoggedInMin = 0;
        decimal LoggedInHour =0;
     
        
        If (LoggedInSec != null  && LoggedInSec > 60)
        {
            LoggedInMin=math.floor(LoggedInSec /60);
            LoggedInSec = math.floor(LoggedInSec -(LoggedInMin *60));
        }
           If (LoggedInMin != null && LoggedInMin >60)
        {
            LoggedInHour =math.floor(LoggedInMin / 60);
            LoggedInMin =math.floor(LoggedInMin -(LoggedInHour *60));
        }
        LogTime= 'Hour: '+LoggedInHour +' Min: '+ LoggedInMin +' Sec: ' +  LoggedInSec ;
        
        return LogTime;
    }
    
    Private string buildRecentAcitivityDisplay (Activity_Logs__c RecentAcitivityRecord)
    {
        String RetrunString = 'Start Logging';
        If (RecentAcitivityRecord!= null) {
         //RetrunString = ' Last Acitivity Logged ' + RecentAcitivityRecord.Name + '<br/>';
         RetrunString = RecentAcitivityRecord.Name + '<br/>';
        RetrunString = RetrunString + 'Logged For ' + RecentAcitivityRecord.Duration__c + '<br/>';  
        
        }
         
        return RetrunString ;
    
    }

}