trigger EmailToCaseValueExtraction on Case (Before Insert) {

        for( Case c : trigger.new){
        
            If (c.Description != '')
            {
                //c.Description = c.Description +c.Subject;
                Integer subStrIndex =  c.Description.indexOf('Date:');
                if (subStrIndex >= 0)
                {
                    c.Due_Date__c= c.Description.substring(subStrIndex ,subStrIndex+12);
                }
            
            }
        
        }


}