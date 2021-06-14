Class {
	#name : #PreciseMemoryPresenter,
	#superclass : #RSCanvas,
	#instVars : [
		'depth',
		'line',
		'scale',
		'interpreter'
	],
	#category : #PreciseProfiler
}

{ #category : #opening }
PreciseMemoryPresenter class >> openOn: aPreciseMemoryInterpreter [
	self new
		initializeWith: aPreciseMemoryInterpreter;
		displayNodes;
		open.
]

{ #category : #display }
PreciseMemoryPresenter >> createBoxFor: aPreciseMemoryNode [
	self add: (RSBox new
		size: 10;
		color: (scale scale: aPreciseMemoryNode memoryUsed);
		translateTo: (depth * 20)@(line * 20);
		yourself).
]

{ #category : #display }
PreciseMemoryPresenter >> displayNode: aPreciseMemoryNode [
	self createBoxFor: aPreciseMemoryNode.
	depth := depth + 1.
	aPreciseMemoryNode childs do: [ :node |
		self displayNode: node.
		line := line + 1 ].
	depth := depth - 1.
	aPreciseMemoryNode childs ifNotEmpty: [ line := line - 1 ].
]

{ #category : #display }
PreciseMemoryPresenter >> displayNodes [
	interpreter rootNode childs do: [ :node | 
		self displayNode: node.
		line := line + 1 ].
	self zoomToFit.
]

{ #category : #initialization }
PreciseMemoryPresenter >> initialize [
	super initialize.
	depth := 0.
	line := 0.
]

{ #category : #initialization }
PreciseMemoryPresenter >> initializeWith: aPreciseMemoryInterpreter [
	| maxMemory |
	interpreter := aPreciseMemoryInterpreter.
	maxMemory := (aPreciseMemoryInterpreter rootNode childs collect: [ :node | node memoryUsed ]) max.
	scale := NSScale linear
	range: { Color blue . Color red }; 
                domain: { 0 . maxMemory }.
]