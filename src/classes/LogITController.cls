public with sharing class LogITController {

Private Activity_Logs__c ActivityLogRecord {get; set;}
public Activity_Logs__c RecentActivityLogRecord;
public Datetime CurrentTime {get; set;}
public decimal LoggedInTime {get; set;}
public string Logging {get; set;}
public Boolean IsLogging {get; set;}
public Boolean IsLogDone{get; set;}
public String RecentAcitivityDisplay{get; set;}
public String AcitivityDisplay{get; set;}
public Boolean IsLogComments {get; set;}
 public Boolean isError {get; set;}
public string LogNotes {get; set;}
public string ErrorMsg{get; set;}
private Id UserId ;
Public Activity_Logs__c getActivityLog()

 {return ActivityLogRecord ;}
 
 Public Void setActivityLog(Activity_Logs__c  value)
     {ActivityLogRecord = value;}
  
    
    public PageReference LogSave()
    {   
        try { 
            Update ActivityLogRecord;
            }
         catch (DmlException ex)
         {
             ActivityLogRecord.id= null;
             insert ActivityLogRecord;
         }
         Catch(Exception ex)
         {
             //ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.Error, 'Invalid data entered!'));  
             system.debug('***Log It***'+ ex );
             isError = true;

         }   
         
        //RecentActivityLogRecord  = ActivityLogRecord;
        RecentActivityLogRecord  = null;
        recentActivityBuild ();
        //RecentAcitivityDisplay = buildRecentAcitivityDisplay (RecentActivityLogRecord  );
                 
        ActivityLogRecord = new Activity_Logs__c();
 
        IsLogging=False;
        IsLogDone=False;
         return null;
    }
     public PageReference LogDelete()
    {
        try{
            Delete ActivityLogRecord ;
            }
        Catch (Exception ex)
        {
           
        }    
        
        ActivityLogRecord = new Activity_Logs__c();         
        IsLogging=False;
        IsLogDone=False;
        getLoggingActivity();         
        return null;
    }
    public LogITController ()
    {
            UserId = UserInfo.getUserId();
          ActivityLogRecord = new Activity_Logs__c();
          IsLogging=false;
            IsLogDone=false;
            IsLogComments=false;
            isError = false;
            
          recentActivityBuild ();
          getLoggingActivity();
            CurrentTime= System.Now();
            
        
    
    }
    
    private void recentActivityBuild (){
    
     if (RecentActivityLogRecord == null) {
                List<Activity_Logs__c>  recentActivityList = new list<Activity_Logs__c>([ select id,Name,Start_Time__c ,End_Time__c , Duration__c from Activity_Logs__c where End_Time__c != null and Owner.id=:UserId order  by End_Time__c DESC limit 1  ]);
                
                If (recentActivityList.size()> 0)
               {
                   for (Activity_Logs__c recentActivityListRec:recentActivityList)
                   {    
                       RecentActivityLogRecord=recentActivityListRec;
                   }
               }
        }
        if (RecentActivityLogRecord != null)
        RecentAcitivityDisplay = buildRecentAcitivityDisplay (RecentActivityLogRecord  );
        else
        RecentAcitivityDisplay ='No Recent Activity Logged';
    }
    
    
    private Boolean getLoggingActivity(){
    
          
                List<Activity_Logs__c>  lastRunningActivity = new list<Activity_Logs__c>();
                lastRunningActivity = [ select id, Name,Start_Time__c ,End_Time__c , Duration__c from Activity_Logs__c where End_Time__c = null and Owner.id=:UserId  order  by Start_Time__c DESC limit 1  ];
               If (lastRunningActivity.size()> 0)
               {
               for (Activity_Logs__c lastRunningActivityRec:lastRunningActivity)
               {
                    ActivityLogRecord=lastRunningActivityRec;
                } 
                    IncrementTimer();   
                    IsLogging=true;
                    return true;
                    } 
                else
                return false;    
        }
         
     
    
    
    
    
    public PageReference ShowLogComments()
    {
        if (IsLogDone)
            IsLogComments= true;
            
            return null;
    
    }
    
    public PageReference  LogStartTime()
    {
        If (ActivityLogRecord.Name != null)
        {
        ActivityLogRecord.Start_Time__c=system.Now();
        
        if(ActivityLogRecord.Start_Time__c!= null){
         
        Logging='0:Hour 0:Min';
        }
        
        
        Try {
        getLoggingActivity();
        upsert ActivityLogRecord;
        IsLogging=true;
        IsLogComments=false;
        isError = false;
        }
        Catch (Exception ex)
        {
           system.debug('***Log It***'+ ex );
           isError = true;
           ErrorMsg = 'OOOOPPS System has faced an error/exception.Contact your admin';
        } 
        }
        else
        {
         isError = true;
           ErrorMsg = 'Activity Name Missing';
        }
        return null;
    }
     public void LogStopTime()
    {
        IncrementTimer();
        ActivityLogRecord.End_Time__c=system.Now();
         
        IsLogDone=true;
        IsLogComments=false;
        
        AcitivityDisplay= '<B>Activity -</B>' +  ActivityLogRecord.Name + '<br/>'+ ' <B>Logged From</B> '+ ActivityLogRecord.Start_Time__c + '<br/>'+ ' <B>Logged To</B> '+ActivityLogRecord.End_Time__c + '<br/>'+' <B>Duration</B> ' + Logging ;
    
    }
    
    public void IncrementTimer()
    {
        CurrentTime= System.Now();
         
        if(ActivityLogRecord!=null && ActivityLogRecord.Start_Time__c!= null){ 
        LoggedInTime =  (System.Now().getTime()  - ActivityLogRecord.Start_Time__c.getTime()) ; 
        Logging = formateLogTime(ActivityLogRecord.Start_Time__c); 
         
        }
    }
    Public void InitalActions ()
    {
         
         
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
         
        LogTime= LoggedInHour +':Hour '+LoggedInMin +':Min ';
        
        return LogTime;
    }
    
    Private string buildRecentAcitivityDisplay (Activity_Logs__c RecentAcitivityRecord)
    {
        String RetrunString = 'Start Logging';
        If (RecentAcitivityRecord!= null) {
          
         RetrunString = RecentAcitivityRecord.Name + '<br/>';
        RetrunString = RetrunString + '<B>Logged For</B><BR/> ' + RecentAcitivityRecord.Duration__c ;  
        
        }
         
        return RetrunString ;
    
    }
    
    

}