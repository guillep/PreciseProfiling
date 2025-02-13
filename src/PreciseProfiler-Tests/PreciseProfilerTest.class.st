Class {
	#name : #PreciseProfilerTest,
	#superclass : #TestCase,
	#instVars : [
		'interpreter'
	],
	#category : #'PreciseProfiler-Tests'
}

{ #category : #setup }
PreciseProfilerTest >> setUp [
	super setUp.
	interpreter := PreciseProfiler new.
	
]

{ #category : #test }
PreciseProfilerTest >> testInterpreteBiggerExponentiation [
	self
		assert: (interpreter runOn: 5 method: #** andArguments: #(300))
		equals: (5 ** 300).
]

{ #category : #test }
PreciseProfilerTest >> testInterpreteCHInterpretableLastExpression [
	self
		assert: (interpreter runOn: (CHInterpretable new) method: #lastExpression andArguments: #() )
		equals: 43.
	self
		assert: (interpreter methodList) 
		= (Dictionary newFrom: { 
			CHInterpretable>>#lastExpression -> 1 .
			True>>#ifTrue: -> 1 .
			FullBlockClosure>>#value -> 1 .
			SmallInteger>>#+ -> 1}).
]

{ #category : #test }
PreciseProfilerTest >> testInterpreteColorTranslucent [
	self
		assert: (interpreter runOn: Color red method: #translucent)
		equals: Color red translucent.
]

{ #category : #test }
PreciseProfilerTest >> testInterpreteEmptyArray [
	self
		assert: (interpreter runOn: CHInterpretable new method: #returnEmptyLiteralArray)
		equals: #().
]

{ #category : #test }
PreciseProfilerTest >> testInterpreteExponentiation [
	self
		assert: (interpreter runOn: 5 method: #** andArguments: #(3))
		equals: 125.
]

{ #category : #test }
PreciseProfilerTest >> testInterpreteFactorial1 [
	self
		assert: (interpreter runOn: 1 method: #factorial)
		equals: 1.
]

{ #category : #test }
PreciseProfilerTest >> testInterpreteFactorial5 [
	self
		assert: (interpreter runOn: 5 method: #factorial)
		equals: 120.
]

{ #category : #test }
PreciseProfilerTest >> testInterpreteJavadocClass [
	self
		assert: (interpreter
			runOn: Javadoc 
			method: #runOnClass: 
			andArguments: { SmallInteger })
		equals: (Javadoc runOnClass: SmallInteger)
]

{ #category : #test }
PreciseProfilerTest >> testInterpreteJavadocPackage [
	self
		assert: (interpreter
			runOn: Javadoc 
			method: #runOnPackage: 
			andArguments: { PreciseProfilerTest package })
		equals: (Javadoc runOnPackage: PreciseProfilerTest package)
]

{ #category : #test }
PreciseProfilerTest >> testInterpreteObjectNew [
	self
		assert: (interpreter runOn: Object method: #new) class
		equals: Object.
]

{ #category : #test }
PreciseProfilerTest >> testInterpreteSmallIntegerAddition [
	self
		assert: (interpreter runOn: 3 method: #+ andArguments: #(5) )
		equals: 8.
	self
		assert: (interpreter methodList) 
		= (Dictionary newFrom: { 
			SmallInteger>>#+ -> 1})
]

{ #category : #test }
PreciseProfilerTest >> testInterpreteTimeNow [
	self
		assert: (interpreter
			runOn: Time 
			method: #now )
		<= Time now
]
