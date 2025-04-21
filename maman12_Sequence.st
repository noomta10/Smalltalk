Object subclass: #MySequence
	instanceVariableNames: 'start step count'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Sequence'!

!MySequence methodsFor: 'printing' stamp: 'NT 3/31/2025 21:22'!
printOn: aStream
	|info|
	info := self class printString, (' sequence:').
	1 to:count do:[:i| info:=(info , ' ', (self valueOf:i) printString)].
	aStream nextPutAll: info! !


!MySequence methodsFor: 'values' stamp: 'NT 3/31/2025 21:18'!
sumOf:n 
	| sum |
	(n>=0 and: n<=count)
	ifFalse:[^ self error: 'out of sequence range'].
	
	sum := 0.
	1 to:n do:[:i| sum:=sum+(self valueOf:i) ].
	^sum	
	! !

!MySequence methodsFor: 'values' stamp: 'NT 3/31/2025 21:09'!
valueOf:n 
      self subclassResponsibility.

! !


!MySequence methodsFor: 'initialize-release' stamp: 'NT 3/31/2025 21:11'!
initializeWithStart:theStart step:theStep count:theCount
	start:=theStart.
	step:=theStep.
	count:=theCount.! !


MySequence subclass: #MyArithmeticSequence
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Sequence'!

!MyArithmeticSequence methodsFor: 'values' stamp: 'NT 3/31/2025 21:11'!
valueOf:n 
	(n>0 and: n<=count)
	ifFalse:[^ self error: 'out of sequence range'].
	(n=1) ifTrue:[^start].
	^step+(self valueOf:n-1)! !


MySequence subclass: #MyFibonacciSequence
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Sequence'!

!MyFibonacciSequence methodsFor: 'initialize-release' stamp: 'NT 4/1/2025 18:47'!
initializeWithStart: theStart count: theCount
    ^super initializeWithStart:theStart step:nil count:theCount! !


!MyFibonacciSequence methodsFor: 'values' stamp: 'NT 4/1/2025 18:55'!
valueOf:n 
	(n>0 and: n<=count)
	ifFalse:[^ self error: 'out of sequence range'].
	(n=1 or: n=2) 
		ifTrue:[^start].
	^(self valueOf:(n-1))+(self valueOf:(n-2)).! !


MySequence subclass: #MyGeometricSequence
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Sequence'!

!MyGeometricSequence methodsFor: 'values' stamp: 'NT 3/31/2025 21:28'!
valueOf: n

	(n>0 and: n<=count)
	ifFalse:[^ self error: 'out of sequence range'].
    ^ start * (step raisedTo: (n - 1))! !
