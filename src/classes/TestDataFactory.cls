@isTest
public class TestDataFactory {
    
    // возвращает страницу покупки с переданными параметрами
	public static PageReference getBuyProductPage(String firstName, String lastName, String email, String unitCount, String productId){
        PageReference pageRef = Page.BuyProduct;
        
        pageRef.getParameters().put('id', productId);
        pageRef.getParameters().put('firstName', firstName);
        pageRef.getParameters().put('lastName', lastName);
        pageRef.getParameters().put('email', email);
        pageRef.getParameters().put('unitCount', unitCount);
        
        return pageRef;
    }
    
    // добавляет в бд Custom Settings
    public static void orgConfiguration(){
        Org_Configuration__c oc = new Org_Configuration__c();
        oc.Name = 'period';
        oc.Period_Term__c = 123;
        insert oc;
    }
}