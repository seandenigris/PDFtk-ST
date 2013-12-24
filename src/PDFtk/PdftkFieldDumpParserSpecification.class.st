Class {
	#name : #PdftkFieldDumpParserSpecification,
	#superclass : #BabyPhexample,
	#instVars : [
		'sampleInput'
	],
	#category : #'PDFtk-Specification'
}

{ #category : #private }
PdftkFieldDumpParserSpecification >> sampleInput [

	^ sampleInput
]

{ #category : #accessing }
PdftkFieldDumpParserSpecification >> sampleInput: aString [

	sampleInput := aString withUnixLineEndings.
]

{ #category : #'tests-unit' }
PdftkFieldDumpParserSpecification >> testFieldWithValue [

	| field |
	self sampleInput: '---
FieldType: Text
FieldName: Station
FieldFlags: 0
FieldValue: 1
FieldJustification: Center
'.

	field := PDFtkFieldDumpParser new field parse: self sampleInput.
	field name should = 'Station'.
	field value should = '1'.
	
]

{ #category : #'tests-unit' }
PdftkFieldDumpParserSpecification >> testFieldWithValueDefault [

	| field |
	self sampleInput: '---
FieldType: Text
FieldName: Station
FieldFlags: 0
FieldValue: 10
FieldValueDefault: 10
FieldJustification: Center
'.

	field := PDFtkFieldDumpParser new field end parse: self sampleInput.
	field default should = '10'.
]

{ #category : #'tests-unit' }
PdftkFieldDumpParserSpecification >> testFieldWithoutValue [

	| field |
	self sampleInput: '---
FieldType: Text
FieldName: Station
FieldFlags: 0
FieldJustification: Center
'.

	field := PDFtkFieldDumpParser new field parse: self sampleInput.
	field name should = 'Station'.
	field value should = ''.
	
]

{ #category : #'private-tests' }
PdftkFieldDumpParserSpecification >> testMandatoryAttributeLine [

	| parser value |
	self sampleInput: 'FieldName: MyField
'.

	parser := PDFtkFieldDumpParser new attributeNamed: 'FieldName'.
	value := parser parse: self sampleInput.
	value should = 'MyField'.
]

{ #category : #'private-tests' }
PdftkFieldDumpParserSpecification >> testOptionalAttributeLine [

	| parser value |
	self sampleInput: 'FieldName: MyField
'.

	parser := PDFtkFieldDumpParser new optionalAttributeNamed: 'FieldName'.
	value := parser parse: self sampleInput.
	value should = 'MyField'.
]

{ #category : #'tests-acceptance' }
PdftkFieldDumpParserSpecification >> testParseFull [

	| fields |
	self sampleInput: '---
FieldType: Text
FieldName: Station
FieldFlags: 0
FieldValue: 1
FieldJustification: Center
---
FieldType: Text
FieldName: Relief
FieldFlags: 0
FieldValue: Jimmy
FieldJustification: Left
'.

	fields := PDFtkFieldDumpParser parse: self sampleInput.
	fields first name should = 'Station'.
	fields first value should = '1'.
	fields second name should = 'Relief'.
	fields second value should = 'Jimmy'.
]
