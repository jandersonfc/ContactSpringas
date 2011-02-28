package com.jandersonfc.controller
{
	import com.jandersonfc.event.ContactEvent;
	import com.jandersonfc.model.delegate.IContactDelegate;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	import org.springextensions.actionscript.core.operation.IOperation;
	import org.springextensions.actionscript.core.operation.OperationEvent;
	import org.springextensions.actionscript.rpc.remoting.RemoteObjectService;
	
	[RouteEvents]
	[Event(name="returnContacts")]
	[Event(name="savedContact")]
	[Event(name="removedContact")]
	[Component]
	public class ContactController extends EventDispatcher
	{
			
		[Inject]
		public var contactDelegate:IContactDelegate;
		
		[EventHandler]
		public function getContacts(event:ContactEvent):void{
			var operation:IOperation = contactDelegate.getContacts();
			operation.addCompleteListener(onGetContacts);
			operation.addErrorListener(onError);			
		}
		
		[EventHandler]
		public function saveContact(event:ContactEvent):void{
			var operation:IOperation = contactDelegate.save(event.contact);
			operation.addCompleteListener(onSave);
			operation.addErrorListener(onError);
		}
		
		[EventHandler]
		public function removeContact(event:ContactEvent):void{
			var operation:IOperation = contactDelegate.remove(event.contact);
			operation.addCompleteListener(onRemove);
			operation.addErrorListener(onError);
		}
		
		public function onGetContacts(event:OperationEvent):void{
			if (event.result != null){
				var contactEvent:ContactEvent = new ContactEvent(ContactEvent.RETURN_CONTACTS);
				contactEvent.contacts = event.result as ArrayCollection;
				dispatchEvent(contactEvent);
			}
		}
		
		public function onSave(event:OperationEvent):void{
			var contactEvent:ContactEvent = new ContactEvent(ContactEvent.SAVED_CONTACT);
			dispatchEvent(contactEvent);
		}
		
		public function onRemove(event:OperationEvent):void{
			var contactEvent:ContactEvent = new ContactEvent(ContactEvent.REMOVED_CONTACT);
			dispatchEvent(contactEvent);
		}
		
		public function onError(event:OperationEvent):void{
			Alert.show(event.error,"ERRO");
		}
		
	}
}