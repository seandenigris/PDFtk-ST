Class {
	#name : #PdfFDF,
	#superclass : #Object,
	#instVars : [
		'lines'
	],
	#category : #PDFtk
}

{ #category : #'instance creation' }
PdfFDF class >> for: aPdfForm [ 

	^ self new
		form: aPdfForm;
		yourself.
]

{ #category : #'pdftk adaption' }
PdfFDF >> appendedTo: aString [ 
	self shouldBeImplemented.
]

{ #category : #'pdftk adaption' }
PdfFDF >> asPDFtkArgument [

	^ PDFtkMemoryFileArgument on: self.
]

{ #category : #'as yet unclassified' }
PdfFDF >> at: fieldName put: aString [

"	(self hasFieldNamed: fieldName) ifFalse: [ self error: 'Fdf does not contain a ', fieldName, ' field' ]."
"	lines before: '/T (', fieldName, ')'"
	| nameIndex |
	nameIndex := lines indexOf: '/T (', fieldName, ')' ifAbsent: [ self error: 'Fdf does not contain a ', fieldName, ' field' ].
	lines at: nameIndex - 1 put: '/V (', aString, ')'.
]

{ #category : #'pdftk adaption' }
PdfFDF >> ensureFileDuring: aBlock [
	
	| tempFdfFile |
	tempFdfFile := FileLocator imageDirectory / ('tempFdf', DateAndTime now asString) asLegalSelector.
	self saveTo: tempFdfFile.
	aBlock value ensure: [ tempFdfFile delete ].
]

{ #category : #private }
PdfFDF >> form: aPdfForm [ 

	| contents |
	contents := PDFtk new
		generateFdfFor: aPdfForm;
		toStdOut;
		run.
	lines := contents lines.
]

{ #category : #private }
PdfFDF >> hasFieldNamed: aString [ 

	^ lines anySatisfy: [ :e | '/T (', aString, ')' = e ].
]

{ #category : #'as yet unclassified' }
PdfFDF >> saveTo: file [

	file writeStreamDo: [ :str | lines do: [ :line | str nextPutAll: line ] separatedBy: [ str lf ] ].

]
