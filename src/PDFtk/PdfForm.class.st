Class {
	#name : #PdfForm,
	#superclass : #FileReference,
	#category : #Pdftk
}

{ #category : #'instance creation' }
PdfForm class >> at: absolutePathString [

	| path |
	path := Path from: absolutePathString.
	^ self fileSystem: FileSystem disk path: path.
]

{ #category : #accessing }
PdfForm >> fields [

	^ Pdftk dumpFieldsOf: self.
]
