Class {
	#name : #PDFtkForm,
	#superclass : #Object,
	#instVars : [
		'file',
		'fdf'
	],
	#category : #PDFtk
}

{ #category : #'instance creation' }
PDFtkForm class >> at: aStringOrFileReference [

	^ self new
		file: aStringOrFileReference asFileReference;
		yourself
]

{ #category : #accessing }
PDFtkForm >> at: fieldName put: aString [

	self fdf at: fieldName put: aString.
]

{ #category : #private }
PDFtkForm >> fdf [

	^ fdf ifNil: [ fdf := PDFtkAssembledFDF new ].
]

{ #category : #accessing }
PDFtkForm >> fields [

	^ PDFtk dumpFieldsOf: self.
]

{ #category : #accessing }
PDFtkForm >> file [
	^ file
]

{ #category : #accessing }
PDFtkForm >> file: anObject [
	file := anObject
]

{ #category : #'as yet unclassified' }
PDFtkForm >> saveAs: anAbstractFileReference [

	PDFtk new
		saveFilledForm: self to: anAbstractFileReference;
		run.
		
]
