TestCase subclass: #BoardTest
	instanceVariableNames: 'board graphicBoard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Chess-Q1-Test'!

!BoardTest methodsFor: 'as yet unclassified' stamp: 'NT 4/28/2025 15:25'!
testBoardInitialization
    | board |
    board := Board restricted: #(1,1).
    self assert: board notNil. ! !

!BoardTest methodsFor: 'as yet unclassified' stamp: 'NT 4/28/2025 15:25'!
testPieceTerminator
    | terminator |
    terminator := QueenTerminator new.
    self deny: (terminator canAttack: 1 x: 1).
    self assert: terminator firstSolution.
    self deny: terminator nextSolution.
    self assert: (terminator result isEmpty).! !

!BoardTest methodsFor: 'as yet unclassified' stamp: 'NT 4/28/2025 15:32'!
testRestrictedSquares
    | restrictedSquares |
    graphicBoard := GraphicBoard new open.
    (graphicBoard submorphs first) mouseDown: nil. "Simulate click on first square from bottom"
    restrictedSquares := graphicBoard restrictedSquares.

    self assert: restrictedSquares notEmpty.
    self assert: (restrictedSquares anySatisfy: [:coord | coord = (Array with: 8 with: 8)]).! !

!BoardTest methodsFor: 'as yet unclassified' stamp: 'NT 4/28/2025 15:32'!
testSquareRestriction
    | square |
    square := Square new.
    square setRow: 1 column: 1.
    self assert: (square isRestricted not).
    square mouseDown: nil. 
    self assert: square isRestricted.! !
