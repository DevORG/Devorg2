/*
BatchLeadDescr Blp = new BatchLeadDescr();
ID batchprocessid = Database.executeBatch(Blp);
System.Debug('####batchprocessid='+batchprocessid);

for single lead

 BatchLeadDescr Blp = new BatchLeadDescr();
Blp.query = 'Select Description From lead Where ID=\'00Q90000004M0tr\' ';
System.Debug('$$$$$');
System.Debug(Blp.query);
ID batchprocessid = Database.executeBatch(Blp);
System.Debug('####batchprocessid='+batchprocessid);


*/
global class BatchLeadDescr implements Database.Batchable<sObject>{
    public String query;
    global database.querylocator start(Database.BatchableContext BC){
        if ((query==null) || (query=='')) query='Select l.Description From Lead l';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<sObject> scope){
        List<Lead> Leads = new List<Lead>();
        for(sObject s : scope){
                Lead l = (Lead)s;
                String descr = l.Description.replaceAll('[^\\d]*','');
                if (descr != l.Description) {
                    l.Description = descr;
                    Leads.Add(l);
                }
        }
        if (Leads.Size()>0) update Leads; 
    }
    
    global void finish(Database.BatchableContext BC){
    }
    
    // test method
    static testMethod void test_BatchLeadPhones() {
        Lead l = new lead(LastName='lead test 123', Description='+1 (555)123-4567', company='test company 456');
        insert l;
        Test.StartTest();
        BatchLeadDescr Blp = new BatchLeadDescr();
        Blp.query = 'Select Description From lead Where ID=\''+l.Id+'\'';
        ID batchprocessid = Database.executeBatch(Blp);
        Test.StopTest(); 
    }
}