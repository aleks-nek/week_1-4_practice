@isTest
public class TestSelectWarehouse {
	
    @isTest
    public static void testSelectingWarehouse(){
        
        // создаем  Warehouse и добавляем в БД
        Warehouse__c warehouse = new Warehouse__c();
        warehouse.Period_Start__c = Date.today();
        warehouse.Period_End__c = Date.today();
		insert warehouse;
        
        // создаем продукт, указываем Added date
        Product_Table__c p1 = new Product_Table__c();
        p1.Added_Date__c = Date.today();
        
        // дату не указываем, её должен будет добавить триггер
        Product_Table__c p2 = new Product_Table__c();
        
        // добвляем p1, p2 в список
        List<Product_Table__c> products = new List<Product_Table__c>();
        products.add(p1);
        products.add(p2);
        
        // приписываем products к warehouse
        SelectWarehouseHandler.assignProductTableToWarehouse(products);
        
        //insert products;
        
        // p1 и p2 должны быть приписаны к созданному warehouse
        System.assertEquals(warehouse.Id, p1.Warehouse__c);
        System.assertEquals(warehouse.Id, p1.Warehouse__c);
      
        System.assertEquals(Date.today(), p2.Added_Date__c);
    }
}