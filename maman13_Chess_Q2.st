Object subclass: #Board
	instanceVariableNames: 'size lastPiece'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Chess-Q2'!

!Board methodsFor: 'solve' stamp: 'NT 4/24/2025 12:31'!
solve
| solutionNumber |
	Transcript clear.
	solutionNumber := 1.

	lastPiece firstSolution
		ifTrue: [
			Transcript show: 'Solution ', solutionNumber printString, ': ', lastPiece result printString; cr.
			solutionNumber := solutionNumber + 1.
			[lastPiece nextSolution]
			whileTrue: [
				Transcript show: 'Solution ', solutionNumber printString, ': ', lastPiece result printString; cr.
				solutionNumber := solutionNumber + 1
			].
		]
		ifFalse: [Transcript show: 'No Solution.'; cr].
! !

!Board methodsFor: 'solve' stamp: 'NT 4/23/2025 20:21'!
solveBishops
	self initialize: Bishop new.
	self solve

! !

!Board methodsFor: 'solve' stamp: 'NT 4/23/2025 20:21'!
solveBishops: aSize
	self initialize: Bishop new size: aSize.
	self solve

! !

!Board methodsFor: 'solve' stamp: 'NT 4/23/2025 20:21'!
solveKnights
	self initialize: Knight new.
	self solve

! !

!Board methodsFor: 'solve' stamp: 'NT 4/23/2025 20:21'!
solveKnights: aSize
	self initialize: Knight new size: aSize.
	self solve

! !

!Board methodsFor: 'solve' stamp: 'NT 4/23/2025 20:22'!
solvePrinces
	self initialize: Prince new.
	self solve

! !

!Board methodsFor: 'solve' stamp: 'NT 4/23/2025 20:22'!
solvePrinces: aSize
	self initialize: Prince new size: aSize.
	self solve

! !

!Board methodsFor: 'solve' stamp: 'NT 4/23/2025 20:22'!
solveQueens
	self initialize: Queen new.
	self solve

! !

!Board methodsFor: 'solve' stamp: 'NT 4/23/2025 20:22'!
solveQueens: aSize
	self initialize: Queen new size: aSize.
	self solve

! !


!Board methodsFor: 'initialize-release' stamp: 'NR 3/3/2025 15:02'!
initialize: piece
	self initialize: piece size: 8.! !

!Board methodsFor: 'initialize-release' stamp: 'NT 4/24/2025 14:03'!
initialize: piece size: aSize
	((aSize isKindOf: Integer) and: [aSize > 0])
	ifTrue: [
		size := aSize.
		lastPiece := PieceTerminator new.
		(1 to: size) do: [:i | lastPiece := (piece class new setColumn:i boardSize: size neighbour: lastPiece)
	].
		]
	ifFalse: [
		self error: 'Size should be a positive integer.'
	].

	
	


! !


!Board methodsFor: 'as yet unclassified' stamp: 'NT 4/26/2025 21:05'!
initializeWithRestricted: restrictedSquares
	lastPiece := PieceTerminator new.
	(1 to: size) do: [:i | lastPiece := (Queen new
	setColumn:i neighbour: lastPiece restricted: restrictedSquares asSet)]! !

!Board methodsFor: 'as yet unclassified' stamp: 'NT 4/26/2025 21:07'!
restricted: restrictedSquares
	^ self new initializeWithRestricted: restrictedSquares! !


Object subclass: #ChessPiece
	instanceVariableNames: 'row column neighbour boardSize'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Chess-Q2'!

!ChessPiece methodsFor: 'as yet unclassified' stamp: 'NT 4/24/2025 12:27'!
advance
	row = boardSize
		ifTrue: [neighbour nextSolution
			ifFalse: [^false].
			row := 0].
	row := row + 1.
	^true! !

!ChessPiece methodsFor: 'as yet unclassified' stamp: 'NT 4/23/2025 20:29'!
canAttack:theRow x:theColumn
	self subclassResponsibility.! !

!ChessPiece methodsFor: 'as yet unclassified' stamp: 'NR 3/3/2025 13:49'!
firstSolution
	neighbour firstSolution.
	row := 1.
	^self moveToNextNonAttachedRow! !

!ChessPiece methodsFor: 'as yet unclassified' stamp: 'NR 3/3/2025 14:04'!
initialize
	column := 0.! !

!ChessPiece methodsFor: 'as yet unclassified' stamp: 'NR 3/3/2025 13:55'!
moveToNextNonAttachedRow
	[neighbour canAttack: row x: column]
		whileTrue: [self advance ifFalse: [^false]].
	^true! !

!ChessPiece methodsFor: 'as yet unclassified' stamp: 'NT 4/23/2025 20:24'!
nextSolution
	^self advance and: [self moveToNextNonAttachedRow]! !

!ChessPiece methodsFor: 'as yet unclassified' stamp: 'NT 4/23/2025 20:24'!
result
	^neighbour result addLast: row; yourself! !

!ChessPiece methodsFor: 'as yet unclassified' stamp: 'NT 4/24/2025 12:26'!
setColumn:aColumn boardSize: aSize neighbour:aQueen
	column := aColumn.
	boardSize := aSize.
	neighbour := aQueen.! !

!ChessPiece methodsFor: 'as yet unclassified' stamp: 'NT 4/23/2025 20:24'!
setRow: aRow column: aColumn
	row := aRow.
	column := aColumn! !


ChessPiece subclass: #Bishop
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Chess-Q2'!

!Bishop methodsFor: 'as yet unclassified' stamp: 'NT 4/23/2025 20:26'!
canAttack: theRow x: theColumn
	| rowDiff colDiff |
	rowDiff := (row - theRow) abs.
	colDiff := (column - theColumn) abs.

	(rowDiff = colDiff) ifTrue: [^ true].

	^ neighbour canAttack: theRow x: theColumn.
! !

!Bishop methodsFor: 'as yet unclassified' stamp: 'NT 4/23/2025 20:26'!
oneCanAttack: theRow x: theColumn
	| rowDiff colDiff |
	rowDiff := (row - theRow) abs.
	colDiff := (column - theColumn) abs.

	^(rowDiff = colDiff)

! !


Morph subclass: #GraphicBoard
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Chess-Q2'!

!GraphicBoard methodsFor: 'as yet unclassified' stamp: 'NT 4/26/2025 20:45'!
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

!GraphicBoard methodsFor: 'as yet unclassified' stamp: 'NT 4/26/2025 20:48'!
open: size
	| squareSize |
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

!GraphicBoard methodsFor: 'as yet unclassified' stamp: 'NT 4/26/2025 20:45'!
restrictedSquares
	| restrictedSquares |
	restrictedSquares := Set new.
	self submorphs do: [:aSquare |
	aSquare isRestricted ifTrue: [restrictedSquares add: aSquare coordinate]].
	^ restrictedSquares! !


ChessPiece subclass: #Knight
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Chess-Q2'!

!Knight methodsFor: 'as yet unclassified' stamp: 'NT 4/23/2025 20:26'!
canAttack: theRow x: theColumn
	| rowDiff colDiff |
	rowDiff := (row - theRow) abs.
	colDiff := (column - theColumn) abs.

	((rowDiff = 2 and: colDiff = 1) or: (rowDiff = 1 and: colDiff = 2))
		ifTrue: [^ true].

	^ neighbour canAttack: theRow x: theColumn.! !

!Knight methodsFor: 'as yet unclassified' stamp: 'NT 4/23/2025 20:27'!
oneCanAttack: theRow x: theColumn
	| rowDiff colDiff |
	rowDiff := (row - theRow) abs.
	colDiff := (column - theColumn) abs.

	^((rowDiff = 2 and: colDiff = 1) or: (rowDiff = 1 and: colDiff = 2))

! !


Object subclass: #PieceTerminator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Chess-Q2'!

!PieceTerminator methodsFor: 'as yet unclassified' stamp: 'NR 3/3/2025 14:18'!
canAttack: testRow x: testColumn
	^ false! !

!PieceTerminator methodsFor: 'as yet unclassified' stamp: 'NR 3/3/2025 14:18'!
firstSolution
	^ true! !

!PieceTerminator methodsFor: 'as yet unclassified' stamp: 'NR 3/3/2025 14:18'!
nextSolution
	^ false! !

!PieceTerminator methodsFor: 'as yet unclassified' stamp: 'NR 3/3/2025 14:19'!
result
	^ OrderedCollection new! !


ChessPiece subclass: #Prince
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Chess-Q2'!

!Prince methodsFor: 'as yet unclassified' stamp: 'NT 4/23/2025 20:27'!
canAttack: theRow x: theColumn
	((Bishop new setRow: row column: column) oneCanAttack: theRow x: theColumn) ifTrue: [^true].
	((Knight new setRow: row column: column) oneCanAttack: theRow x: theColumn) ifTrue: [^true].

	^ neighbour canAttack: theRow x: theColumn


! !


ChessPiece subclass: #Queen
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Chess-Q2'!

!Queen methodsFor: 'as yet unclassified' stamp: 'NT 4/24/2025 12:29'!
canAttack:theRow x:theColumn
	|diff|
	diff :=  column - theColumn.
	(theRow = row or:
	[row + diff = theRow] or:
	[row - diff = theRow] )
		ifTrue: [^true].

	^neighbour canAttack:theRow x:theColumn ! !


Morph subclass: #Square
	instanceVariableNames: 'restricted baseColor row column'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Chess-Q2'!

!Square methodsFor: 'as yet unclassified' stamp: 'NT 4/26/2025 20:42'!
baseColor: aColor
    baseColor := aColor.
    self color: baseColor.! !

!Square methodsFor: 'as yet unclassified' stamp: 'NT 4/26/2025 20:42'!
coordinate

    ^ Array with: row with: column! !

!Square methodsFor: 'as yet unclassified' stamp: 'NT 4/26/2025 20:43'!
initialize

    super initialize.

    restricted := false.! !

!Square methodsFor: 'as yet unclassified' stamp: 'NT 4/26/2025 20:44'!
isRestricted
	^ restricted! !

!Square methodsFor: 'as yet unclassified' stamp: 'NT 4/26/2025 20:44'!
mouseDown: event
	restricted := restricted not.
	self color: (restricted ifTrue: [Color red] ifFalse: [baseColor]).

    	! !

!Square methodsFor: 'as yet unclassified' stamp: 'NT 4/26/2025 20:43'!
setRow: aRow column: aColumn

row := aRow.

column := aColumn.! !
