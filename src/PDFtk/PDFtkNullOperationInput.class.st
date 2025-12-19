Class {
	#name : 'PDFtkNullOperationInput',
	#superclass : 'Object',
	#category : 'PDFtk',
	#package : 'PDFtk'
}

{ #category : 'as yet unclassified' }
PDFtkNullOperationInput >> appendedTo: aString [ 

	^ aString.
]

{ #category : 'as yet unclassified' }
PDFtkNullOperationInput >> ensureFileDuring: aBlock [
	
	^ aBlock value.
]
