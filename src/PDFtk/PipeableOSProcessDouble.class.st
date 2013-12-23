Class {
	#name : #PipeableOSProcessDouble,
	#superclass : #Object,
	#category : #'Pdftk-Specification'
}

{ #category : #'as yet unclassified' }
PipeableOSProcessDouble class >> waitForCommand: aString [

	^ self new
		output: 'sample output';
		yourself.
]
