public class SelectWarehouseHandler {
    
    // приписывание объекта Product Table к Warehouse
    public static void assignProductTableToWarehouse(List<Product_Table__c> products) {
        
        Org_Configuration__c configuration = Org_Configuration__c.getInstance('period');
        
        for(Product_Table__c product : products){
            
            // если поле Added_Date пустое
            if(product.Added_Date__c == null){
                // устанавливаем текущую дату
                product.Added_Date__c = Date.today();
            }
            
            // ищем подходящий Warehouse
            List<Warehouse__c> warehouses = [SELECT Id
                                             FROM Warehouse__c
                                             WHERE (Warehouse__c.Period_Start__c <= :product.Added_Date__c AND
                                                    Warehouse__c.Period_End__c >= :product.Added_Date__c)];
            
            // если запись найдена
            if(!warehouses.isEmpty()){
                product.Warehouse__c = warehouses.get(0).Id;
            }else{
                
                // иначе создаем новый Warehouse
                Warehouse__c newWarehouse = new Warehouse__c();
                newWarehouse.Name = 'Warehouse ' + product.Added_Date__c + ' ' + 
                                    (product.Added_Date__c + 
                                     Integer.valueOf(configuration.Period_Term__c));
                newWarehouse.Period_Start__c = product.Added_Date__c;
                newWarehouse.Period_End__c = product.Added_Date__c + Integer.valueOf(configuration.Period_Term__c);
                
                // добавляем Warehouse в базу
            	insert newWarehouse;
                
                product.Warehouse__c = newWarehouse.Id;
            }
        }
    }
}