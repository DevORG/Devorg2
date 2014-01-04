public class ListPageCntrl {   
    public List<List<account>> accList{get;set;}   
    public List<List<account>> accList1{get;set;}
    public List<List<account>> accList2{get;set;}
    
    public ListPageCntrl (){
        accList = new List<List<account>>();
        accList1 = new List<List<account>>();
        accList2 = new List<List<account>>();
        for(integer i =0 ;i<2;i++){
            List<account> acc = new List<account>();
            List<account> acc1 = new List<account>();
            acc.add(new account(name = 'test'+i));
            
            for(integer j = 0;j<100;j++){
            
            acc1.add(new account(name = 'test'+i+j));
                                
            }
            accList.add(acc);
            accList.add(acc1);
        }       
    }   
}