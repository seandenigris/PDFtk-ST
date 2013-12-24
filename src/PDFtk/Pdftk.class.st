"
The Pdftk command format consists of:
binary input_file operation output_file

where:
- input_file can be from prompt | stdin | filename
- output_file is keyword output plus any of three above options
- operation seems mostly to be a keyword and possibly a file argument (any of three kinds above)
"
Class {
	#name : #Pdftk,
	#superclass : #Object,
	#instVars : [
		'command',
		'outputConverter',
		'outputFlag',
		'operation',
		'inputFile'
	],
	#classInstVars : [
		'runnerClass'
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

{ #category : #accessing }
Pdftk class >> runnerClass [

	^ runnerClass
]

{ #category : #'as yet unclassified' }
Pdftk class >> runnerClass: aClass [

	 runnerClass := aClass.
]

{ #category : #'*Pdftk-Specification' }
Pdftk class >> sampleFieldDumpOutput [

	^ '---
FieldType: Text
FieldName: Station
FieldFlags: 0
FieldValue: 1
FieldJustification: Center
' withUnixLineEndings.
]

{ #category : #private }
Pdftk >> command [

	| commandTemplate |
	commandTemplate := '"{1}" "{2}" {3} {4}'.
	^ commandTemplate format: { self class binary fullName. inputFile fullName. operation. self outputFlag }.
]

{ #category : #'as yet unclassified' }
Pdftk >> dumpFieldsOf: aPdfForm [ 

	inputFile := aPdfForm.
	operation := 'dump_data_fields'.
	outputConverter := [ :string | | result |
		result := PdftkFieldDumpParser parse: string.
		(result isKindOf: PPFailure) ifTrue: [ self error: 'parse failure: ', result message ].
		result ].
]

{ #category : #'as yet unclassified' }
Pdftk >> generateFdfFor: aPdfForm [ 

	inputFile := aPdfForm.
	operation := 'generate_fdf'.
]

{ #category : #'as yet unclassified' }
Pdftk >> initialize [

	super initialize.
	outputConverter := [ :string | string ].
	outputFlag := ''.
]

{ #category : #'as yet unclassified' }
Pdftk >> outputFlag [

	^ outputFlag.
]

{ #category : #'as yet unclassified' }
Pdftk >> run [

	| process |
	process := self class runnerClass waitForCommand: self command.
	^ outputConverter value: process output.
]

{ #category : #'as yet unclassified' }
Pdftk >> saveFilledForm: aPdfForm to: anAbstractFileReference [

	aPdfForm tempFdfFileDuring: [ :fdf |
		inputFile := aPdfForm.
		operation := 'fill_form ', fdf fullName surroundedByDoubleQuotes.
		outputFlag := 'output ', anAbstractFileReference fullName surroundedByDoubleQuotes ].
]

{ #category : #output }
Pdftk >> toStdOut [

	outputFlag := 'output -'.
]
