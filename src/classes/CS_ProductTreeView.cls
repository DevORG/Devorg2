/***********************************************************************
* Author        : Ayush / Nirdesh
* Functionality : Tree- Like Data Selection
* Description   :  Tree- Like Data Selection for Products on click of
*                  "Search Prouduct" Button available on Case Record.
* This Apex Class is being referenced in VF Page - CS_ShowProductTree.
* 
************************************************************************/
public with sharing class CS_ProductTreeView{
    
    /* Declaration of Variables */ 
       
    private static JSONGenerator gen {get; set;}
    public List<String> LstOfProductNodes{get;set;} 
    
    // Getter Setter Method for searching input text in Product Tree on VF page.   
    public String InputText{get;set;}
    
    // Getter Setter Method for passing Selected Product from VF page to Apex Class. 
    public String ProductId{get;set;}  
     
    Map<id,List<Product2>>MapProductAndLstChildren=new Map<Id,List<Product2>>();
    Map<Id,Product2> MapOfProducts;
    List<Product2> LstOfProducts;
    
    /* Controller Method Starts here.*/
    public CS_ProductTreeView(ApexPages.StandardController controller){
        LstOfProductNodes=new List<String>();
        
        // Fetch all Id and Products in a Map available in Org.
        MapOfProducts=new map<Id,Product2>([Select id,Name,CS_Parent_Product__c from Product2 where isActive=true]);  
        
        // Iterating for loop to add list of Child Products in a Map corresponding to Parent Product Id's.    
        for(Product2 pd:MapOfProducts.values()){           
            if(MapProductAndLstChildren.get(pd.CS_Parent_Product__c)==null){
                LstOfProducts=new List<Product2>();
                LstOfProducts.add(pd);
                MapProductAndLstChildren.put(pd.CS_Parent_Product__c,LstOfProducts);
            }else{               
                LstOfProducts=MapProductAndLstChildren.get(pd.CS_Parent_Product__c);
                LstOfProducts.add(pd);
                MapProductAndLstChildren.put(pd.CS_Parent_Product__c,LstOfProducts);
            }
        } 
    } /*Controller Method Ends here.*/
    
    /* Action method (called from VF:CS_ShowProductTree) starts here.
       Below method parses all Parent Products and adds them to JSON String 
       which is rendered on VF as Tree Structure. */
    public void GenerateTreeStructureForProducts(){
        
        // Generating Tree Strucutre for all Parent Products.             
        for(Product2 pd:[Select id,Name from Product2 where CS_Parent_Product__c=null and isActive=true]){
            
            // Initializing JSON Generator Object.
            gen = JSON.createGenerator(true);
            
            /* Calls CreateTreeStructure method to retrieve Instance of Wrapper Class 
               which contains Parent and Child Nodes for each Product. */
            WrpProductNode node = CreateTreeStructure(pd);
            
            // Calling ConvertNodeToJSON Method. 
            ConvertNodeToJSON(node);
            
            // Creating List of All Product Nodes by adding instance of JSONGenerator as String.
            LstOfProductNodes.add(gen.getAsString());
        }     
    } /* Action method ends here.*/ 
    
    /* CreateTreeStructure Method starts here : Below method creates Parent and Child Nodes for each Product 
       and returns instance of WrpProductNode (Wrapper class) */
    public  WrpProductNode CreateTreeStructure(Product2 prd){            
        WrpProductNode wrpObj=new WrpProductNode();
        wrpObj.prod=prd;
        List<WrpProductNode>lstOfChild;
        if(MapProductAndLstChildren.get(prd.id)!=null){
            wrpObj.hasChildren =true;
            lstOfChild=new List<WrpProductNode >();
            for(Product2 pd:MapProductAndLstChildren.get(prd.id)){
              WrpProductNode temp=CreateTreeStructure(pd);
                lstOfChild.add(temp);
            }           
        }else
             wrpObj.hasChildren =false;     
        wrpObj.prodChildNode=lstOfChild;
        return wrpObj;        
    } /*CreateTreeStrucure Method Ends here.*/
    
    /*ConvertNodeToJSON method starts here : Below method converts 
    instance of each Product Node(Wrapper class) into JSON.*/
    public void ConvertNodeToJSON(WrpProductNode prodNode){ 
        
        // Creating Product Nodes in JSON format which are also attributes of DynaTree JQuery used in VisualForce.      
        gen.writeStartObject();
        gen.writeStringField('title', prodNode.Prod.Name);
        gen.writeStringField('key', prodNode.Prod.Id);
        gen.writeBooleanField('unselectable', false);
        gen.writeBooleanField('expand', false);
        gen.writeBooleanField('isFolder', false);
        gen.writeBooleanField('icon', false);
        
        // Below condition checks for any child Products available for each Parent product.
        if(prodNode.hasChildren ){
            
            // Below line disables Radio buttons for all Parent Products.
            gen.writeBooleanField('hideCheckbox',true);
            gen.writeFieldName('children');
            gen.writeStartArray();   
                    
            // Iterating each child product and adding further child products to Tree nodes by calling ConvertNodeToJSON method recursively.
            for(WrpProductNode temp:prodNode.prodChildNode)
               ConvertNodeToJSON(temp);                                    
            gen.writeEndArray();           
        }
       gen.writeEndObject();            
    }/*ConvertNodeToJSON method ends here.*/
    
    /*Wrapper class starts here : Below class wraps Products,List of Child Products 
    and boolean variable for childs present for each Parent Product.*/
    public class WrpProductNode{        
        public List<WrpProductNode>prodChildNode{get;set;}
        public Boolean hasChildren {get; set;}    
        public Product2 prod{get;set;}        
    } /*Wrapper Class ends here*/   
    
    /*UpdateCase Method starts here : Below method is triggered by clicking Save button on VF page.*/
    public pageReference updateCase(){   
        
        // Below query fetches Case record for updating selected Product in Database.   
        Case cs=[Select id,CS_Product__c from case where id=:ApexPages.currentPage().getParameters().get('id')];
        cs.CS_Product__c=ProductId;
        try{
            update cs;
        }catch(Exception e){
            
        }
        PageReference pg=new PageReference('/'+ApexPages.currentPage().getParameters().get('id'));
        pg.setRedirect(true);
        return pg;
    }/*UpdateCase Method ends here.*/
}