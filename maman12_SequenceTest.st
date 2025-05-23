TestCase subclass: #MySequnceTest
	instanceVariableNames: 's1 s2'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'SequenceTest'!

!MySequnceTest methodsFor: 'testing' stamp: 'NT 4/3/2025 12:52'!
printSequenceCheck: aString
	| expectedResult actualResult result |
	result := aString.
	expectedResult := ReadStream on: result.
	actualResult := ReadWriteStream on: ''.
	s1 printOn: actualResult.
	self assert: actualResult contents = expectedResult contents.
	self assert: s1 printString = result.! !


!MySequnceTest methodsFor: 'setup' stamp: 'NT 4/1/2025 20:02'!
setUp
	self subclassResponsibility! !


MySequnceTest subclass: #MyArithmeticSequenceTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'SequenceTest'!

!MyArithmeticSequenceTest methodsFor: 'testing' stamp: 'NT 4/1/2025 20:25'!
testArithmetic
	self assert: (s1 valueOf:1) equals: 1 description: 's1 value is wrong'.
	self assert: (s1 sumOf:0) equals: 0 description: 's1 sum of 0 items value is wrong'.
	self assert: (s2 valueOf:2) equals: 14 description: 's2 value is wrong'.
	self assert: (s2 sumOf:0) equals: 0 description: 's2 sum of 0 items value is wrong'.

! !

!MyArithmeticSequenceTest methodsFor: 'testing' stamp: 'NT 4/3/2025 12:53'!
testPrintOn
	| result |
	result := 'MyArithmeticSequence sequence: 1 3 5 7'.
	self printSequenceCheck:result.
		! !


!MyArithmeticSequenceTest methodsFor: 'setup' stamp: 'NT 4/3/2025 12:47'!
setUp
   s1 := MyArithmeticSequence new.
   s1 initializeWithStart:1 step:2 count:4.
   s2 := MyArithmeticSequence new.
   s2 initializeWithStart:4 step:10 count:10.
! !


MySequnceTest subclass: #MyFibonacciSequenceTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'SequenceTest'!

!MyFibonacciSequenceTest methodsFor: 'testing' stamp: 'NT 4/3/2025 12:32'!
testFibonacci
	self assert: (s1 valueOf:1) equals: 1 description: 's1 value is wrong'.
	self assert: (s1 sumOf:5) equals: 12 description: 's1 sum of 5 items value is wrong'.
	self assert: (s2 valueOf:3) equals: 8 description: 's2 value is wrong'.
	self assert: (s2 sumOf:4) equals: 28description: 's2 sum of 4 items value is wrong'.
! !

!MyFibonacciSequenceTest methodsFor: 'testing' stamp: 'NT 4/3/2025 12:53'!
testPrintOn
	| result |
	result := 'MyFibonacciSequence sequence: 1 1 2 3 5'.
	self printSequenceCheck:result.
		! !


!MyFibonacciSequenceTest methodsFor: 'setup' stamp: 'NT 4/3/2025 12:36'!
setUp
   s1 := MyFibonacciSequence new.
   s1 initializeWithStart:1 count:5.
   s2 := MyFibonacciSequence new.
   s2 initializeWithStart:4 count:5.
! !


MySequnceTest subclass: #MyGeometricSequenceTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'SequenceTest'!

!MyGeometricSequenceTest methodsFor: 'testing' stamp: 'NT 4/3/2025 12:42'!
testGeometric
	self assert: (s1 valueOf:2) equals: 2 description: 's1 value is wrong'.
	self assert: (s1 sumOf:6) equals: 63 description: 's1 sum of 6 items value is wrong'.
	self assert: (s2 valueOf:3) equals: 45 description: 's2 value is wrong'.
	self assert: (s2 sumOf:3) equals: 65 description: 's2 sum of 3 items value is wrong'.
! !

!MyGeometricSequenceTest methodsFor: 'testing' stamp: 'NT 4/3/2025 12:53'!
testPrintOn
	| result |
	result := 'MyGeometricSequence sequence: 1 2 4 8 16 32'.
	self printSequenceCheck:result.
		! !


!MyGeometricSequenceTest methodsFor: 'setup' stamp: 'NT 4/3/2025 12:40'!
setUp
   s1 := MyGeometricSequence new.
   s1 initializeWithStart:1 step:2 count:6.
   s2 := MyGeometricSequence new.
   s2 initializeWithStart:5 step:3 count:3.
! !
