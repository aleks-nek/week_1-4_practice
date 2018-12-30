public class ProductListController {
    
    public List<Product_Table__c> getProducts(){
        return [SELECT	Id, 
                        Product_Name__c, 
                        Image_Url__c, Title__c, 
                        Product_Description__c, 
                        Unit_Price__c 
                FROM	Product_Table__c
                LIMIT	50];
        
    }
}