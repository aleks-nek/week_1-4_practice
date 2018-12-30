@isTest
public class TestProductListController {
    
	@isTest
    public static void testGettingProducts() {
        ProductListController plController = new ProductListController();
        List<Product_Table__c> products = new List<Product_Table__c>();
        
        // это нужно, чтобы тест видел эту пользовательску настройку, иначе он падает
        TestDataFactory.orgConfiguration();
            
        // добавляем в БД именно 50 объектов, так контроллер возвращает 50 
        // (А контроллер возвращает 50, т.к. в Week 3 Practice была рекомендация 
        // ограничить число объектов при SELECT запросах)
        for(Integer i = 0; i < 50; i++){
            products.add(new Product_Table__c());
        }
        insert products;
        
        System.assertEquals(products.size(), plController.getProducts().size());
    }
}