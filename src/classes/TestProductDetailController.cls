@isTest
public class TestProductDetailController {
	
    @isTest
    public static void testGettingProduct() {
        
        // это нужно, чтобы тест видел эту пользовательску настройку, иначе он падает
        TestDataFactory.orgConfiguration();
        
        // создаем продукт и добавляем в БД
        Product_Table__c product = new Product_Table__c();
        insert product;
        
        // создаем с pagereference и кладем в параметры id
        PageReference pageRef = Page.ProductDetail;
        pageRef.getParameters().put('id',product.id);
		
        // меняем текущую страницу теста
        Test.setCurrentPage(pageRef);
        
        // создаем контроллер получения деталей о продукте
        ProductDetailController pdController = new ProductDetailController();
        
        System.assertEquals(product.Id, pdController.getProduct().Id);
        
    }
}