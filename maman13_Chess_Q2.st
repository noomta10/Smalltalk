Morph subclass: #GraphicBoard
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Chess-Q1'!

!GraphicBoard methodsFor: 'as yet unclassified' stamp: 'NT 4/26/2025 14:11'!
open
	| size squareSize |
	size := 8.
	squareSize := 40.

	self color: Color white.
	self extent: (squareSize * size) @ (squareSize * size).

	1 to: size do: [:row |
	    1 to: size do: [:col |
	        | square color |
	        square := Square new.
	        color := (row + col) even ifTrue: [Color white] ifFalse: [Color black].
	        square baseColor: color.
	        square bounds: (((col - 1) * squareSize) @ ((row - 1) * squareSize) extent: squareSize @ squareSize).
		  square setRow: row column: col.
	        self addMorph: square.
	    ]
	].

	self openInWorld.! !

!GraphicBoard methodsFor: 'as yet unclassified' stamp: 'NT 4/26/2025 14:36'!
restrictedSquares
	| restrictedSquares |
	restrictedSquares := Set new.
	self submorphs do: [:aSquare |
		aSquare isRestricted ifTrue: [restrictedSquares add: aSquare coordinate]].
	^ restrictedSquares
	
! !

!GraphicBoard methodsFor: 'as yet unclassified' stamp: 'NT 4/26/2025 14:15'!
showRestrictedSquares
	| restrictedSquares |
	restrictedSquares := Set new.
	self submorphs do: [:aSquare |
		aSquare isRestricted ifTrue: [restrictedSquares add: aSquare coordinate]].
	Transcript show: 'Restricted squares: ', restrictedSquares asString; cr.
	
! !


GraphicBoard subclass: #Board
	instanceVariableNames: 'lastQueen restricted'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Chess-Q1'!
!Board commentStamp: 'RM 4/24/2025 17:01' prior: 0!
This class represents the chessboard and manages the solving process for the Eight Queens problem, considering restricted squares.!


!Board methodsFor: 'initialization' stamp: 'RM 4/24/2025 17:01'!
initializeWithRestricted: restrictedSquares
	restricted := restrictedSquares asSet.
	lastQueen := QueenTerminator new.
	(1 to: 8) do: [:i | lastQueen := (Queen new
			setColumn:i neighbour: lastQueen restricted: restricted)]! !


!Board methodsFor: 'solving' stamp: 'NT 4/26/2025 11:31'!
solve
	| solutionNumber |
	Transcript clear.
	solutionNumber := 1.
	lastQueen firstSolution
		ifTrue: [Transcript show: 'Solution ', solutionNumber printString, ': ', lastQueen result printString; cr.
				solutionNumber := solutionNumber + 1.
				[lastQueen nextSolution]
				whileTrue: [Transcript show: 'Solution ', solutionNumber printString, ': ', lastQueen result printString; cr.
				solutionNumber := solutionNumber + 1].
			Transcript show: 'End of Solutions.'; cr]
		ifFalse: [Transcript show: 'No Solution.'; cr]! !


!Board methodsFor: 'instance creation' stamp: 'RM 4/24/2025 17:01'!
restricted: restrictedSquares
	^ self new initializeWithRestricted: restrictedSquares! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Board class
	instanceVariableNames: ''!

!Board class methodsFor: 'instance creation' stamp: 'RM 4/24/2025 17:01'!
restricted: restrictedSquares
	^ self new initializeWithRestricted: restrictedSquares! !


Object subclass: #Queen
	instanceVariableNames: 'row column neighbour restricted'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Chess-Q1'!

!Queen methodsFor: 'initialization' stamp: 'RM 4/24/2025 17:01'!
setColumn: aColumn neighbour: aQueen restricted: restrictedSquares
	column := aColumn.
	neighbour := aQueen.
	restricted := restrictedSquares asSet! !


!Queen methodsFor: 'calculation' stamp: 'RM 4/24/2025 17:01'!
advance
	row = 8
		ifTrue: [neighbour nextSolution
				ifFalse: [^ false].
				row := 0].
	row := row + 1.
	^ true! !

!Queen methodsFor: 'calculation' stamp: 'RM 4/24/2025 17:01'!
canAttack: theRow x: theColumn
	| diff |
	diff := column - theColumn.
	(theRow = row or:
	 [row + diff = theRow] or:
	 [row - diff = theRow])
		ifTrue: [^ true].
	^ neighbour canAttack: theRow x: theColumn! !

!Queen methodsFor: 'calculation' stamp: 'RM 4/24/2025 17:01'!
firstSolution
	neighbour firstSolution.
	row := 1.
	^ self moveToNextNonAttachedRow! !

!Queen methodsFor: 'calculation' stamp: 'NT 4/26/2025 11:17'!
isRestricted
	^ restricted includes: (Array with: row with: column)! !

!Queen methodsFor: 'calculation' stamp: 'RM 4/24/2025 17:01'!
moveToNextNonAttachedRow
	[self isRestricted or: [neighbour canAttack: row x: column]]
		whileTrue: [self advance ifFalse: [^ false]].
	^ true! !

!Queen methodsFor: 'calculation' stamp: 'RM 4/24/2025 17:01'!
nextSolution
	^ self advance and: [self moveToNextNonAttachedRow]! !

!Queen methodsFor: 'calculation' stamp: 'RM 4/24/2025 17:01'!
result
	^ neighbour result addLast: row; yourself! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Queen class
	instanceVariableNames: 'boardSize'!


Object subclass: #QueenTerminator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Chess-Q1'!

!QueenTerminator methodsFor: 'calculation' stamp: 'RM 2/19/2014 17:10'!
canAttack: theRow x: theColumn
	^ false! !

!QueenTerminator methodsFor: 'calculation' stamp: 'RM 2/19/2014 17:08'!
firstSolution
	^ true! !

!QueenTerminator methodsFor: 'calculation' stamp: 'RM 2/19/2014 17:09'!
nextSolution
	^ false! !

!QueenTerminator methodsFor: 'calculation' stamp: 'RM 2/23/2014 09:49'!
result
	^ OrderedCollection new! !


Morph subclass: #Square
	instanceVariableNames: 'restricted baseColor row column'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Chess-Q1'!

!Square methodsFor: 'as yet unclassified' stamp: 'NT 4/26/2025 13:08'!
baseColor: aColor
    baseColor := aColor.
    self color: baseColor.! !

!Square methodsFor: 'as yet unclassified' stamp: 'NT 4/26/2025 13:19'!
coordinate
    ^ Array with: row with: column! !

!Square methodsFor: 'as yet unclassified' stamp: 'NT 4/26/2025 13:08'!
initialize
    super initialize.
    restricted := false.! !

!Square methodsFor: 'as yet unclassified' stamp: 'NT 4/26/2025 13:16'!
isRestricted
    ^ restricted! !

!Square methodsFor: 'as yet unclassified' stamp: 'NT 4/26/2025 13:08'!
mouseDown: event
    restricted := restricted not.
    self color: (restricted ifTrue: [Color red] ifFalse: [baseColor]).! !

!Square methodsFor: 'as yet unclassified' stamp: 'NT 4/26/2025 13:19'!
setRow: aRow column: aColumn
	row := aRow.
	column := aColumn.! !
