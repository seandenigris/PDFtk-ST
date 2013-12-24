Class {
	#name : #PdftkSpecification,
	#superclass : #BabyPhexample,
	#category : #'Pdftk-Specification'
}

{ #category : #'as yet unclassified' }
PdftkSpecification >> setUp [
	
	Pdftk runnerClass: PipeableOSProcessDouble.
]

{ #category : #'as yet unclassified' }
PdftkSpecification >> tearDown [

	Pdftk runnerClass: PipeableOSProcess.
	PipeableOSProcessDouble reset.
]

{ #category : #'as yet unclassified' }
PdftkSpecification >> testFormDumpFields [

	| form pdfPathString fields |
	pdfPathString := '/usr/local/form.pdf'.
	form := PdfForm at: pdfPathString.
	
	PipeableOSProcessDouble
		onCommand: Pdftk binary fullName surroundedByDoubleQuotes, ' ', pdfPathString surroundedByDoubleQuotes, ' dump_data_fields'
		answer: Pdftk sampleFieldDumpOutput.
	
	fields := Pdftk dumpFieldsOf: form.
	fields size = 1.
	fields first name should = 'Station'.
]
