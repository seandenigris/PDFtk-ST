Class {
	#name : #PdfFormSpecification,
	#superclass : #TestCase,
	#category : #'PDFtk-Specification'
}

{ #category : #'tests-unit' }
PdfFormSpecification >> testCreation [

	| pathString form |
	pathString := '/usr/local/form.pdf'.
	form := PdfForm at: pathString.
	form fullName should = pathString.
]

{ #category : #'tests-acceptance' }
PdfFormSpecification >> testFields [

	| form file fields |
	file := FileLocator imageDirectory / 'Mutual Tour Exchange.pdf'.
	form := PdfForm at: file fullName.
	fields := form fields.
	fields first name should = 'Station'.
	fields first value should = '1'.
]
