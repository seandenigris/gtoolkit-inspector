Extension { #name : #ZnDefaultServerDelegate }

{ #category : #'*GToolkit-Inspector' }
ZnDefaultServerDelegate >> gtPrefixMapFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Prefixes';
		items: [ self prefixMap associations ];
		column: 'Prefix' text: #key;
		column: 'Handler' text: #value weight: 2;
		actionUpdateButtonTooltip: 'Update prefix map';
		sendTool: [ :anAssoc | 
			| aClass aHandler |
			aHandler := anAssoc value.
			aHandler isSymbol 
				ifTrue: [
					aClass := self class whichClassIncludesSelector: aHandler.
					aClass
						ifNil: [ GtPhlowTool default object: aHandler ]
						ifNotNil: [ GtMethodCoderTool compiledMethod: (aClass >> aHandler) ] ]
				ifFalse: [ aHandler ] ]
]
