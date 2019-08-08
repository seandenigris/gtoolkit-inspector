Extension { #name : #TKTCommonQueueWorkerPool }

{ #category : #'*GToolkit-Inspector' }
TKTCommonQueueWorkerPool >> gtFailedTasksFor: aView [
	failedTasks ifNil: [ ^ aView empty ].
	^ aView list
		title: 'Failed Tasks';
		items: [ failedTasks ]
]

{ #category : #'*GToolkit-Inspector' }
TKTCommonQueueWorkerPool >> gtQueueFor: aView [
	<gtView>

	^aView list 
		title: 'Queue';
		priority: 90;
		items: [ (self taskQueue itemArray reject: #isZombie thenCollect: #object) ];
		itemFormat: [ :eachExecution | 
			[ eachExecution ifNotNil: #name ]
				on: Error 
				do: [ :ex | '(unknown name)' ] ];
		send: [ :eachExecution | eachExecution ifNotNil: #task ]
]