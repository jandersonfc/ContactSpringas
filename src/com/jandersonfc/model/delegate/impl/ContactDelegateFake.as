package com.jandersonfc.model.delegate.impl
{
	import com.jandersonfc.model.delegate.IContactDelegate;
	import com.jandersonfc.model.entity.Contact;
	
	import mx.collections.ArrayCollection;
	
	import org.springextensions.actionscript.core.operation.IOperation;
	import org.springextensions.actionscript.core.operation.MockOperation;
	
	[Component]
	public class ContactDelegateFake implements IContactDelegate{
		
		[Bindable]
		private var contacts:ArrayCollection;
		
		public function ContactDelegateFake():void{
			contacts = new ArrayCollection();
			contacts.addItem(createContactFake(1,"Janderson"));
			contacts.addItem(createContactFake(2,"Fernanda"));
			contacts.addItem(createContactFake(3,"Murilo"));
		}
		
		public function getContacts():IOperation {
			return new MockOperation(contacts);
		}
		
		public function save(contact:Contact):IOperation {
			if (contact.id){
				contacts.setItemAt(contact,contact.id-1);
			}else {
				contact.id = contacts.length+1;
				contacts.addItem(contact);
			}
			return new MockOperation(contact);
		}
		
		public function remove(contact:Contact):IOperation{
			contacts.removeItemAt(contact.id-1);			
			for (var i:int=0; i < contacts.length; i++ ){
				Contact(contacts.getItemAt(i)).id = i+1;
			}
			return new MockOperation(contact);
		}
		
		private function createContactFake(id:int,name:String):Contact{
			var contact:Contact = new Contact();
			contact.id = id;
			contact.name = name;
			contact.lastName = "Cardoso";
			contact.phone = "22 2222-2222";			
			contact.email= "teste@teste.com.br";			
			contact.birthDate = new Date();
			return contact;
		}
		
	}
}