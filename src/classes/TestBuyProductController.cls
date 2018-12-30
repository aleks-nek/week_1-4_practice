@isTest
public class TestBuyProductController {
	
    // тест успешной покупки
    @isTest
    public static void testSuccessfulBuy() {
        // это нужно, чтобы тест видел эту пользовательску настройку, иначе он падает
        TestDataFactory.orgConfiguration();
        
        Product_Table__c product = new Product_Table__c(); // создаем продукт
        product.Units_Available__c = 100; //устанавливаем количество 
        product.Unit_Price__c = 123;
        insert product; // добавляем продукт в базу
        
        // создаем страницу покупки с параметрами
        PageReference pageRef = TestDataFactory.getBuyProductPage('firstName', 
                                                                  'lastName', 
                                                                  'email@mail.ru', 
                                                                  '2', 
                                                                  product.Id);
        
        // устанавливаем страницу покупки как текущую
        Test.setCurrentPage(pageRef);
        
		//создаем контроллер покупки
		BuyProductController bpController = new BuyProductController();
		
        // совершаем покупку
		bpController.buyProduct();
		
		// проверяем статус покупки
		System.assert(true, bpController.buyingStatus);
		
		// создаем новый экземпляр контроллера
		bpController = new BuyProductController();
        
        // совершаем покупку второй раз
		// теперь контакт с этим email УЖЕ ЕСТЬ В БАЗЕ
		bpController.buyProduct();
        
        // проверяем статус покупки
		System.assertEquals(true, bpController.buyingStatus);
        
        
    }
    
    // тест неудачной покупки. Кол-во покупаемых товаров больше, чем есть в наличии
    @isTest
    public static void testFailureBuy() {
        // это нужно, чтобы тест видел эту пользовательску настройку, иначе он падает
        TestDataFactory.orgConfiguration();
        
        Product_Table__c product = new Product_Table__c(); // создаем продукт
        product.Units_Available__c = 10; //устанавливаем количество 
        product.Unit_Price__c = 123;
        insert product; // добавляем продукт в базу
        
        // создаем страницу покупки с параметрами
        PageReference pageRef = TestDataFactory.getBuyProductPage('firstName', 
                                                                  'lastName', 
                                                                  'email@mail.ru', 
                                                                  '20', 
                                                                  product.Id);
        
        // устанавливаем страницу покупки как текущую
        Test.setCurrentPage(pageRef);
        
		//создаем контроллер покупки
		BuyProductController bpController = new BuyProductController();
		
        // совершаем покупку
		bpController.buyProduct();
		
		// проверяем статус покупки
		System.assertEquals(false, bpController.buyingStatus);
		
    }
    
    @isTest
    public static void testGettingProduct(){
        // это нужно, чтобы тест видел эту пользовательску настройку (Custom Settings) , иначе он падает
        TestDataFactory.orgConfiguration();
        
        Product_Table__c product = new Product_Table__c();
        insert product;
        
        PageReference pageRef = Page.BuyProduct;
        pageRef.getParameters().put('id', product.id);
        Test.setCurrentPage(pageRef);
        
        BuyProductController bpController = new BuyProductController();
        
        System.assertEquals(product, bpController.getProduct());
    }
}