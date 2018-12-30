trigger SelectWarehouseTrigger on Product_Table__c (before insert) {
    // вызываем вспомогательный метод, 
    // который припишет продукты к складам
    SelectWarehouseHandler.assignProductTableToWarehouse(Trigger.New);
}