Class {
	#name : #BaselineOfPreciseProfiler,
	#superclass : #BaselineOf,
	#category : #BaselineOfPreciseProfiler
}

{ #category : #baselines }
BaselineOfPreciseProfiler >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec package: 'Champollion-Core'.
		spec
			package: 'Champollion-Tests'
			with: [ spec requires: #( 'Champollion-Core' ) ].

		spec
			package: 'PreciseProfiler'
			with: [ spec requires: #( 'Champollion-Core' ) ].

		spec
			baseline: 'MethodProxies'
			with: [
			spec repository: 'github://pharo-contributions/MethodProxies' ].
		spec
			package: 'PreciseProfiler-MethodProxies'
			with: [ spec requires: #( 'MethodProxies' 'PreciseProfiler' ) ].

		spec
			package: 'PreciseProfiler-Tests'
			with: [ spec requires: #( 'PreciseProfiler-MethodProxies' ) ] ]
]
