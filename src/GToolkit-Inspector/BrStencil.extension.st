Extension { #name : #BrStencil }

{ #category : #'*GToolkit-Inspector' }
BrStencil >> gtLiveFor: aView [
	<gtView>
	self class isAbstract ifTrue: [ ^ aView empty ].
	^ aView forward
		title: 'Live';
		priority: 0;
		object: [ self create ];
		view: #gtLiveFor:;
		actionButtonIcon: BrGlamorousVectorIcons inspect action: [ :aBrButton | 
			aBrButton phlow spawnObject: self create ]
]

{ #category : #'*GToolkit-Inspector' }
BrStencil class >> gtLiveFor: aView [
	<gtView>
	self isAbstract ifTrue: [ ^ aView empty ].
	^ aView forward
		title: 'Live';
		priority: -5;
		object: [ self new ];
		view: #gtLiveFor:
]
