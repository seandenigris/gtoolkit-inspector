Extension { #name : #SymbolicBytecode }

{ #category : #'*GToolkit-Inspector' }
SymbolicBytecode >> gtSourceFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Source';
		look: BrGlamorousCodeEditorLook;
		styler: (BrRBTextStyler new classOrMetaClass: self method methodClass);
		priority: 10;
		text: [ 
			| text |
			text := self method sourceCode asRopedText.
			(text from: self sourceInterval first to: self sourceInterval last) attributes: { 
				BlTextUnderlineAttribute new 
					color: BrGlamorousColors lightBorderColor; 
					beNotOverwritableByStyler }.
			text ]
]
