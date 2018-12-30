public class ProductDetailController {
    private final Product_Table__c product;
    
    public ProductDetailController(){
        product = [SELECT   Id, 
                            Image_Url__c, 
                            Product_Name__c, 
                            Product_Description__c, 
                            Unit_Price__c,
                            Units_Available__c,
                            Title__c
                   FROM     Product_Table__c
                   WHERE    Id = :ApexPages.currentPage().getParameters().get('id')
                   LIMIT	1
                  ];
    }
    
    public Product_Table__c getProduct(){
        return product;
    }
}