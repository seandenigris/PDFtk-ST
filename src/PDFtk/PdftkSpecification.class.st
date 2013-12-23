Class {
	#name : #PdftkSpecification,
	#superclass : #BabyPhexample,
	#category : #'Pdftk-Specification'
}

{ #category : #'as yet unclassified' }
PdftkSpecification >> testCreation [

	| pathString form |
	pathString := '/usr/local/form.pdf'.
	form := PdfForm at: pathString.
	form fullName should = pathString.
]

{ #category : #'as yet unclassified' }
PdftkSpecification >> testFields [

	| form file fields |
	file := FileLocator imageDirectory / 'Mutual Tour Exchange.pdf'.
	form := PdfForm at: file fullName.
	fields := form fields.
	fields first type should = 'Text'.
	fields first name should = 'Station'.
	fields first value should = '1'.
]

{ #category : #'as yet unclassified' }
PdftkSpecification >> testFormDumpFields [

	| form pdfPathString mockEvaluator output |
	pdfPathString := '/usr/local/form.pdf'.
	form := PdfForm at: pdfPathString.
	
	mockEvaluator := context mock: 'Evaluator'.
	mockEvaluator should
		receive: #waitForCommand:;
		with: Pdftk binary fullName surroundedByDoubleQuotes, pdfPathString surroundedByDoubleQuotes, ' dump_data_fields'.
	mockEvaluator should
		receive: #output;
		answers: 'sample output'.
	
	Pdftk evaluatorClass: mockEvaluator.

	output := Pdftk dumpFieldsOf: form.
	output should = 'sample output'.

	Pdftk evaluatorClass: OSProcess.
]
