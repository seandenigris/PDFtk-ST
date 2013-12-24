Class {
	#name : #PdfFormField,
	#superclass : #Object,
	#instVars : [
		'name',
		'value',
		'default'
	],
	#category : #PDFtk
}

{ #category : #accessing }
PdfFormField >> default [

	^ default
]

{ #category : #accessing }
PdfFormField >> default: aString [

	default := aString.
]

{ #category : #accessing }
PdfFormField >> name [

	^ name.
]

{ #category : #accessing }
PdfFormField >> name: aString [

	name := aString.
]

{ #category : #'as yet unclassified' }
PdfFormField >> printOn: aStream [

	aStream
		nextPutAll: 'Field ';
		nextPutAll: self name surroundedBySingleQuotes;
		nextPutAll: ' = ';
		nextPutAll: self value surroundedBySingleQuotes.
]

{ #category : #accessing }
PdfFormField >> value [

	^ value.
]

{ #category : #accessing }
PdfFormField >> value: aString [

	value := aString.
]
