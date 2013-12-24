Class {
	#name : #PdftkFieldDumpParser,
	#superclass : #PPCompositeParser,
	#category : #Pdftk
}

{ #category : #'as yet unclassified' }
PdftkFieldDumpParser >> attributeNamed: aString [

	^ aString asParser, ': ' asParser, self lineSeparator negate plus flatten, self lineSeparator ==> #third.
]

{ #category : #'as yet unclassified' }
PdftkFieldDumpParser >> field [

	| type name flags value justification header default |
	header := '---' asParser, self lineSeparator ==> #first.
	type := self attributeNamed: 'FieldType'.
	name := self attributeNamed: 'FieldName'.
	flags := self attributeNamed: 'FieldFlags'.
	value := self optionalAttributeNamed: 'FieldValue'.
	default := self attributeNamed: 'FieldValueDefault'.
	justification := self attributeNamed: 'FieldJustification'.
	^ header, type, name, flags, value, default optional, justification ==> [ :nodes |
			PdfFormField new
				name: nodes third;
				value: nodes fifth;
				default: nodes sixth ].
]

{ #category : #'as yet unclassified' }
PdftkFieldDumpParser >> lineSeparator [

	^ #lf asParser.
]

{ #category : #'as yet unclassified' }
PdftkFieldDumpParser >> optionalAttributeNamed: aString [ 

	^ (self attributeNamed: aString) optional  ==> [ :node | node ifNil: [ '' ] ].
]

{ #category : #'as yet unclassified' }
PdftkFieldDumpParser >> start [

	^ self field plus end.
]
