Class {
	#name : #Pdftk,
	#superclass : #Object,
	#instVars : [
		'command'
	],
	#classInstVars : [
		'evaluatorClass'
	],
	#category : #Pdftk
}

{ #category : #accessing }
Pdftk class >> binary [

	^ '/usr/local/bin/pdftk' asFileReference.
]

{ #category : #'as yet unclassified' }
Pdftk class >> dumpFieldsOf: aPdfForm [ 

	^ self new
		dumpFieldsOf: aPdfForm;
		run.
]

{ #category : #'as yet unclassified' }
Pdftk class >> evaluatorClass: aClass [

	 evaluatorClass := aClass.
]

{ #category : #'as yet unclassified' }
Pdftk >> dumpFieldsOf: aPdfForm [ 

	| commandTemplate |
	commandTemplate := '"{1}" "{2}" dump_data_fields'.
	command := commandTemplate format: { self class binary. aPdfForm fullName }.

]

{ #category : #'as yet unclassified' }
Pdftk >> run [

	| process |
	process := PipeableOSProcess waitForCommand: command.
	^ process output.
]
