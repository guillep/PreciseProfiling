"
I contain the profiling data for a package

    Instance Variables
	classSpies: A list of class spies, each corresponding to a class of the package being spied
"
Class {
	#name : #PackageSpy,
	#superclass : #Object,
	#instVars : [
		'classSpies'
	],
	#category : #'PreciseProfiler-Spy'
}

{ #category : #setting }
PackageSpy >> addClass: aClass [
	| classSpy subclasses |
	classSpy := ClassSpy new initializeWith: aClass.
	subclasses := aClass subclasses select: [ :subclass | 
		(subclass package == aClass package) and: subclass isMeta not ].
	subclasses do: [ :subclass | | subclassSpy |
		subclassSpy := self addClass: subclass.
		subclassSpy setSuperclassSpy: classSpy ].
	classSpies at: aClass put: classSpy.
	^ classSpy
]

{ #category : #accessing }
PackageSpy >> classSpies [
	^ classSpies values 
]

{ #category : #accessing }
PackageSpy >> classSpyAt: aClass [
	(aClass isMeta)
		ifTrue: [ ^ (classSpies at: aClass soleInstance) metaclassSpy ] 
		ifFalse: [ ^ classSpies at: aClass ]
]

{ #category : #initialization }
PackageSpy >> initialize [
	super initialize.
	classSpies := Dictionary new.
]

{ #category : #initialization }
PackageSpy >> initializeWith: aPackage [
	| classes |
	classes := aPackage classes reject: [ :class |
		(aPackage classes includes: class superclass) or:
		(aPackage classExtensionSelectors keys includes: class name) ].
	classes do: [ :class | self addClass: class ]
]
