public class BuyProductController {
	private final Product_Table__c product;
    public Boolean buyingStatus{get; set;} // показывает результат обработки заказа
    
    public BuyProductController(){
        product = [SELECT   Id, 
                            Product_Name__c,
                            Unit_Price__c,
                            Units_Available__c
                   FROM     Product_Table__c
                   WHERE    Id = :ApexPages.currentPage().getParameters().get('id')
                  ];
        buyingStatus = false;
    }
    
    public Product_Table__c getProduct(){
        return product;
    }
    
    public PageReference buyProduct(){
        String firstName	= ApexPages.currentPage().getParameters().get('firstName'); 
        String lastName		= ApexPages.currentPage().getParameters().get('lastName');
        String email		= ApexPages.currentPage().getParameters().get('email');
        Integer unitCount	= Integer.valueOf(ApexPages.currentPage().getParameters().get('unitCount'));
        
        // ищем контакт по email
        List<Contact> contact = [SELECT id, firstName, lastName FROM Contact WHERE email = :email LIMIT 1];
        
        // если контакт существует
        if(!contact.isEmpty()){
        	// обновляем поля 
        	contact.get(0).firstName = firstName;
            contact.get(0).lastName = lastName;
        } else { 
            // иначе создаем новый контакт
            Contact c = new Contact(firstName	= firstName,
                                    lastName	= lastName,
                                    email		= email);
            
            contact.add(c);
        }
        
        
        
        // считаем сколько остаётся продуктов
        Decimal productsLeft = product.units_Available__c - unitCount;
        
        // если остаётся продуктов >= 0 
        if(productsLeft >= 0){
            
            // обновляем кол-во оставшихся единиц продукта
        	product.units_Available__c = productsLeft;
            
            // обновляем контакт и продукт
            upsert contact;
            update product;
            
            // создаем новую запись в Order Table
            Order_Table__c order = new Order_Table__c();
            
            order.Product__c = product.Id;
            order.Units__c = unitCount;
            order.Order_Amount__c = unitCount * product.Unit_Price__c;
            order.Contact__c = contact.get(0).id;

            
            // добавляем её в базу
            insert order;
            
            // устанавливаем флаг
            buyingStatus = true;
        } else {
            
            //ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.INFO,'Столько продуктов нет в наличии');
            //ApexPages.addMessage(myMsg);
            
            buyingStatus = false;
        }
        
        
        return null;
    }
}