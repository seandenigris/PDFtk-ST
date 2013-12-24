Class {
	#name : #PdfForm,
	#superclass : #FileReference,
	#instVars : [
		'fdf'
	],
	#category : #Pdftk
}

{ #category : #'instance creation' }
PdfForm class >> at: absolutePathString [

	| path |
	path := Path from: absolutePathString.
	^ self fileSystem: FileSystem disk path: path.
]

{ #category : #accessing }
PdfForm >> at: fieldName put: aString [

	self fdf at: fieldName put: aString.
]

{ #category : #private }
PdfForm >> fdf [

	^ fdf ifNil: [ fdf := PdfFDF for: self ].
]

{ #category : #accessing }
PdfForm >> fields [

	^ Pdftk dumpFieldsOf: self.
]

{ #category : #'as yet unclassified' }
PdfForm >> saveAs: anAbstractFileReference [

	Pdftk new
		saveFilledForm: self to: anAbstractFileReference;
		run.
		
]

{ #category : #'as yet unclassified' }
PdfForm >> tempFdfFileDuring: aBlock [
	
	| tempFdfFile |
	tempFdfFile := FileLocator imageDirectory / (self fullName, DateAndTime now asString) asLegalSelector.
	self fdf saveTo: tempFdfFile.
	aBlock value: tempFdfFile.
	tempFdfFile delete.
]
