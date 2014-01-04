global class TestAutocomplete 
{
    global TestAutocomplete(ApexPages.StandardController myStandardController) {}

    webservice static List<String> 
        GetAutocompleteValuesAjaxAPI(String SearchTerm)
    {            
        String mySourceText = 'ActionScript AppleScript Asp BASIC C '
           + 'C++ Clojure COBOL ColdFusion Erlang Fortran Groovy '
           + 'Haskell Java JavaScript Lisp Perl PHP Python Ruby '
           + 'Scala Scheme';

        List<String> mySourceList = mySourceText.split(' ');
        List<String> myReturnList = new List<String>();

        for(String s : mySourceList)
        {
            if(s.contains(SearchTerm)){ myReturnList.add(s); }
        }

        return myReturnList;
    }
}