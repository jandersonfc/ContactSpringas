package com.jandersonfc.model.delegate
{
	import com.jandersonfc.model.entity.Contact;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	
	import org.springextensions.actionscript.core.operation.IOperation;

	public interface IContactDelegate
	{
		
		function getContacts():IOperation;
		function save(contact:Contact):IOperation;
		function remove(contact:Contact):IOperation;
		
	}
}