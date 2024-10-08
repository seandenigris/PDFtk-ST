Class {
	#name : #BaselineOfPDFtk,
	#superclass : #BaselineOf,
	#category : #BaselineOfPDFtk
}

{ #category : #baseline }
BaselineOfPDFtk >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
	
		spec
			baseline: #'BabyPhexample' with: [
				spec repository: 'github://seandenigris/Baby-Phexample' ].
				
		spec package: #'PDFtk' with: [ 
			spec requires: #(#'BabyPhexample' )  ] ].
]

{ #category : #accessing }
BaselineOfPDFtk >> customProjectAttributes [
	^ self isGTImage
			ifTrue: [ #(GToolkit) ]
			ifFalse: [ #(notGToolkit) ]
]

{ #category : #testing }
BaselineOfPDFtk >> isGTImage [
	
	^ RPackageOrganizer default packageNames anySatisfy: [ :pn | pn beginsWith: 'Lepiter-' ].
	"Implementation note: used to check for GToolkit prefix, but P7 has a GToolkit-Examples package. Lepiter, OTOH, could only be loaded in a GT image"
]
