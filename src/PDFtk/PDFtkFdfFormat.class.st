"
Ported from description at http://blog.tremily.us/posts/PDF_forms/

Tested via fill_form on Mac Mountain Lion

We may be able to specify UTF-8 on Windows:
	""There are a number of interesting entries that you can add to the FDF dictionary (§12.7.7.3.1, table 243), some of which require a more advanced FDF version. You can use the /Version key to the FDF catalog (§12.7.7.3.1, table 242) to specify the of data in the dictionary:

1 0 obj<</Version/1.3/FDF<</Fields[…
Now you can extend the dictionary using table 244. Lets set things up to use UTF-8 for the field values (/V) or options (/Opt):

1 0 obj<</Version/1.3/FDF<</Encoding/utf_8/Fields[
<</T(FIELD1_NAME)/V(FIELD1_VALUE)>>
<</T(FIELD2_NAME)/V(FIELD2_VALUE)>>
…
] >> >>
endobj
pdftk understands raw text in the specified encoding ((…)), raw UTF-16 strings starting with a BOM ((\xFE\xFF…)), or UTF-16BE strings encoded as ASCII hex (<FEFF…>). You can use pdf-merge.py and its --unicode option to find the latter. Support for the /utf_8 encoding in pdftk is new. I mailed a patch to pdftk's Sid Steward and posted a patch request to the underlying iText library. Until those get accepted, you're stuck with the less convenient encodings.""
"
Class {
	#name : #PDFtkFdfFormat,
	#superclass : #Object,
	#category : #'PDFtk-Experimental'
}

{ #category : #'as yet unclassified' }
PDFtkFdfFormat >> bodyWith: fields [
	"a body with a single object (ISO 32000 §12.7.7.2.3)"

	^ '1 0 obj
<</FDF
<</Fields[
', (self fieldsWith: fields) , ']
>>
>>
endobj'.
]

{ #category : #'as yet unclassified' }
PDFtkFdfFormat >> fieldsWith: fields [
	"For example:"
	
	^ String streamContents: [ :str |
		fields keysAndValuesDo: [ :key :value | 
			str
				nextPutAll: '<</T(';
				nextPutAll: key;
				nextPutAll: ')/V(';
				nextPutAll: value;
				nextPutAll: ')>>';
				lf ] ].
]

{ #category : #'as yet unclassified' }
PDFtkFdfFormat >> header [
	"(ISO 32000 §12.7.7.2.2)"

	^ '%FDF-1.2'.
]

{ #category : #'as yet unclassified' }
PDFtkFdfFormat >> trailer [
	"Despite the claims in ISO 32000 §12.7.7.2.1 that the trailer is optional, pdftk choked on files without it. Trailers are easy to add, since all they reqire is a reference to the root of the FDF catalog dictionary. If you only have one dictionary, you can always use the simple trailer I gave above."
	
	^ 'trailer
<</Root 1 0 R>>
%%EOF'
]
