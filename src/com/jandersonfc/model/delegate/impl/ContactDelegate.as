package com.jandersonfc.model.delegate.impl
{
	import com.jandersonfc.model.delegate.IContactDelegate;
	import com.jandersonfc.model.entity.Contact;
	
	import org.springextensions.actionscript.core.operation.IOperation;
	import org.springextensions.actionscript.rpc.remoting.RemoteObjectService;
	
	public class ContactDelegate implements IContactDelegate{	
		
		[Inject(name="contactService")]
		public var contactService:RemoteObjectService;
		
		public function getContacts():IOperation {
			return contactService.call("getContacts");
		}
		
		public function save(contato:Contact):IOperation {
			return contactService.call("save",contato);
		}
		
		public function remove(contato:Contact):IOperation{
			return contactService.call("remove",contato);
		}
		
	}
}