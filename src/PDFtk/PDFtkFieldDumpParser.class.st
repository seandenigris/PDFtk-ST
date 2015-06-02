Class {
	#name : #PDFtkFieldDumpParser,
	#superclass : #PPCompositeParser,
	#category : #PDFtk
}

{ #category : #'as yet unclassified' }
PDFtkFieldDumpParser >> attributeNamed: aString [

	"N.B. we use start because the actual value can be absent in some cases"
	^ aString asParser, ': ' asParser, self lineSeparator negate star flatten, self lineSeparator ==> #third.
]

{ #category : #'as yet unclassified' }
PDFtkFieldDumpParser >> field [

	| type name flags value justification header default |
	header := '---' asParser, self lineSeparator ==> #first.
	type := self attributeNamed: 'FieldType'.
	name := self attributeNamed: 'FieldName'.
	flags := self attributeNamed: 'FieldFlags'.
	value := self optionalAttributeNamed: 'FieldValue'.
	default := self optionalAttributeNamed: 'FieldValueDefault'.
	justification := self attributeNamed: 'FieldJustification'.
	^ header, type, name, flags, value, default, justification, header negate star ==> [ :nodes |
			PDFtkFormField new
				name: nodes third;
				value: nodes fifth;
				default: nodes sixth ].
]

{ #category : #'as yet unclassified' }
PDFtkFieldDumpParser >> lineSeparator [

	"PDFtk uses #lf, but #cr is useful for testing e.g. parsing copy/pasted sample data"
	^ #lf asParser / #cr asParser.
]

{ #category : #'as yet unclassified' }
PDFtkFieldDumpParser >> optionalAttributeNamed: aString [ 

	^ (self attributeNamed: aString) optional ==> [ :node | node ifNil: [ '' ] ].
]

{ #category : #'as yet unclassified' }
PDFtkFieldDumpParser >> start [

	^ self field plus end.
]
