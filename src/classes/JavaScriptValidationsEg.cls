public with sharing class JavaScriptValidationsEg {
	
	/*
	
	/*------------------------------------------------------------------------------------------------------------------------------------------*/ 
// Description: It is a Button of field type List Button 
// Usage: Its Behavior to Execute JavaScript on the basis of 
// opportunity stage it dislpays a alert message 
// or refer to next step (page) 
// Input Parameters: 
// Output: 
// 
// Name Date Changes 
// Created By: Wipro 23052011 Created. 
// Modified By: 
//Version: 1.0 
/*------------------------------------------------------------------------------------------------------------------------------------------*/ 

//On Click of the button Set As Primary this JavaScript executes 
/*var oppstage = '{!Opportunity.StageName}'; 
if(oppstage == 'Closed Won' || oppstage == "Closed Lost"){ 
alert('Cannot Set as Primary, Opportunity is Won or Lost'); 
} 
else { 
{!REQUIRESCRIPT("/soap/ajax/18.0/connection.js")} 
var records = {!GETRECORDIDS($ObjectType.BigMachines__Quote__c)}; 

var setAsPrimary = false; 
if (records == null || records.length == 0) { 
alert("Please check the box next to the quote that you would like to be the primary quote before clicking the 'Set as Primary' button."); 
} 
else if (records.length > 1) { 
alert("Please select only one quote to be the primary quote."); 
} else if ({!Opportunity.HasOpportunityLineItem}) { 
setAsPrimary = confirm("Setting a new quote as the primary quote will delete all of the opportunity products on this opportunity that are associated with the current primary quote. Do you want to continue?"); 
} 
else { 
setAsPrimary = true; 
} 

if (setAsPrimary) { 
var pri_quotes = new Array(); 
var quote = new sforce.SObject("BigMachines__Quote__c"); 
quote.Id = records[0]; 
quote.BigMachines__Is_Primary__c = "true"; 
pri_quotes.push(quote); 
var targetURL = window.parent.location.href; 
var hashPos = targetURL.indexOf("#"); 
if (hashPos != -1) { 
targetURL = targetURL.substring(0, hashPos); 
} 
var result = sforce.connection.update(pri_quotes, function() {navigateToUrl(targetURL);}); 
} 
}
	*/
/*******************************************************************************
var oppstage = '{!Opportunity.StageName}'; 
if(oppstage == 'Closed Won' || oppstage == "Closed Lost"){ 
alert('Cannot create Quote, Opportunity is Lost or Won'); 
} 
else { 
window.parent.location.href = "/apex/BigMachines__QuoteEdit?oppId={!Opportunity.Id}&actId={!Opportunity.AccountId}"; 
}

*******************************/
/*******************************************************************************

*******************************/
/*******************************************************************************

*******************************/

}