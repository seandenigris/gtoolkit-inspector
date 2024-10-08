Class {
	#name : #CurrentProcessAnalysis,
	#superclass : #Object,
	#instVars : [
		'signals'
	],
	#category : 'GToolkit-Inspector-Convenience and Utilities'
}

{ #category : #'instance creation' }
CurrentProcessAnalysis class >> signals: aCollection [
	"Open the receiver on the supplied set of signals"

	^self new initializeWith: (aCollection select: 
		[ :each | each class = CurrentProcessSignal ])
]

{ #category : #inspecting }
CurrentProcessAnalysis >> gtStackTreeFor: aView [
	<gtView>

	^aView mondrian 
		title: 'Stack Tree' translated;
		painting: [ :mondrian | self stackTreeFor: mondrian ]
]

{ #category : #initialization }
CurrentProcessAnalysis >> initializeWith: aCollection [

	signals := aCollection.
]

{ #category : #private }
CurrentProcessAnalysis >> stackTreeFor: aMondrian [
	"Display the signals as a tree assuming a common root"

	| nodes |

	nodes := Set new.
	signals do: [ :signal |
		signal preemptedStack reversed do: [ :method |
			nodes add: method ] ].
	nodes := nodes asArray.
	aMondrian nodes 
		stencil: 	[ :each | BlTextElement new text: each asString asRopedText ];
		with: nodes.
	signals do: [ :signal | | stack |
		stack := signal preemptedStack reversed.
		aMondrian edges
			connect: (1 to: stack size - 1)
			from: [ :x | stack at: x ]
			to: [ :x | stack at: x+1 ] ].
	aMondrian layout tree.
	^aMondrian
]
