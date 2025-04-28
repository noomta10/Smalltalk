TestCase subclass: #BoardTest
	instanceVariableNames: 'board graphicBoard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Chess-Q2-Test'!

!BoardTest methodsFor: 'as yet unclassified' stamp: 'NT 4/28/2025 13:54'!
testBoardInitialization
    | board |
    board := Board new.
    board initialize: Queen new size: 4.
    self assert: board notNil.  ! !

!BoardTest methodsFor: 'as yet unclassified' stamp: 'NT 4/28/2025 13:59'!
testPieceTerminator
    | terminator |
    terminator := PieceTerminator new.
    self deny: (terminator canAttack: 1 x: 1).
    self assert: terminator firstSolution.
    self deny: terminator nextSolution.
    self assert: (terminator result isEmpty).! !

!BoardTest methodsFor: 'as yet unclassified' stamp: 'NT 4/28/2025 13:54'!
testQueenAttack
    | queen |
    queen := Queen new.
    queen setRow: 4 column: 4.

    self assert: (queen canAttack: 4 x: 7).
    self assert: (queen canAttack: 8 x: 8).
    self assert: (queen canAttack: 2 x: 6).! !

!BoardTest methodsFor: 'as yet unclassified' stamp: 'NT 4/28/2025 13:35'!
testRestrictedSquares
    | restrictedSquares |
    graphicBoard := GraphicBoard new.
    graphicBoard open: 8.
    (graphicBoard submorphs first) mouseDown: nil. "Simulate click on first square from bottom"
    restrictedSquares := graphicBoard restrictedSquares.

    self assert: restrictedSquares notEmpty.
    self assert: (restrictedSquares anySatisfy: [:coord | coord = (Array with: 8 with: 8)]).
! !

!BoardTest methodsFor: 'as yet unclassified' stamp: 'NT 4/28/2025 13:58'!
testSquareRestriction
    | square |
    square := Square new.
    square setRow: 1 column: 1.
    self assert: (square isRestricted not).
    square mouseDown: nil. 
    self assert: square isRestricted.
 ! !
