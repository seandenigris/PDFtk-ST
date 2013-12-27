Class {
	#name : #PdfForm,
	#superclass : #FileReference,
	#instVars : [
		'fdf'
	],
	#category : #PDFtk
}

{ #category : #'instance creation' }
PdfForm class >> at: stringOrFileReference [

	^ self fileSystem: FileSystem disk path: stringOrFileReference asFileReference path.
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

	^ PDFtk dumpFieldsOf: self.
]

{ #category : #'as yet unclassified' }
PdfForm >> saveAs: anAbstractFileReference [

	PDFtk new
		saveFilledForm: self to: anAbstractFileReference;
		run.
		
]
