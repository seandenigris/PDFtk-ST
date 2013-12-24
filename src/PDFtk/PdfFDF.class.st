Class {
	#name : #PdfFDF,
	#superclass : #Object,
	#instVars : [
		'lines'
	],
	#category : #Pdftk
}

{ #category : #'instance creation' }
PdfFDF class >> for: aPdfForm [ 

	^ self new
		form: aPdfForm;
		yourself.
]

{ #category : #'as yet unclassified' }
PdfFDF >> at: fieldName put: aString [

"	(self hasFieldNamed: fieldName) ifFalse: [ self error: 'Fdf does not contain a ', fieldName, ' field' ]."
"	lines before: '/T (', fieldName, ')'"
	| nameIndex |
	nameIndex := lines indexOf: '/T (', fieldName, ')' ifAbsent: [ self error: 'Fdf does not contain a ', fieldName, ' field' ].
	lines at: nameIndex - 1 put: '/V (', aString, ')'.
]

{ #category : #private }
PdfFDF >> form: aPdfForm [ 

	| contents |
	contents := Pdftk new
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
