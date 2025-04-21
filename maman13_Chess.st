Object subclass: #Board
	instanceVariableNames: 'lastQueen'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Chess'!

!Board methodsFor: 'solve' stamp: 'NT 4/7/2025 21:08'!
solve
	| solutionNumber |
	Transcript clear.
	solutionNumber := 1.

	lastQueen firstSolution
		ifTrue: [
			Transcript show: 'Solution ', solutionNumber printString, ': ', lastQueen result printString; cr.
			solutionNumber := solutionNumber + 1.
			[lastQueen nextSolution]
				whileTrue: [
					Transcript show: 'Solution ', solutionNumber printString, ': ', lastQueen result printString; cr.
					solutionNumber := solutionNumber + 1
				].
		]
		ifFalse: [Transcript show: 'No Solution.'; cr].! !


!Board methodsFor: 'initialize-release' stamp: 'NT 4/7/2025 20:46'!
initialize
	lastQueen := QueenTerminator new.
	(1 to: 8)
	do: [:i | lastQueen := Queen new
	setColumn: i neighbor: lastQueen]! !


Object subclass: #Queen
	instanceVariableNames: 'row column neighbor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Chess'!

!Queen methodsFor: 'as yet unclassified' stamp: 'NT 4/7/2025 20:54'!
advance
	row = 8
	ifTrue: [neighbor nextSolution
	ifFalse: [^ false].
	row := 0].
	row := row + 1.
	^ true! !

!Queen methodsFor: 'as yet unclassified' stamp: 'NT 4/7/2025 20:53'!
canAttack: testRow x: testColumn
	| columnDifference |
	columnDifference := testColumn - column.
	((row = testRow
	or: [row + columnDifference = testRow])
	or: [row - columnDifference = testRow])
	ifTrue: [^ true].
	^ neighbor canAttack: testRow x: testColumn! !

!Queen methodsFor: 'as yet unclassified' stamp: 'NT 4/7/2025 20:55'!
firstSolution
	neighbor firstSolution.
	row _ 1.
	^ self moveToNextNonAttackedRow! !

!Queen methodsFor: 'as yet unclassified' stamp: 'NT 4/7/2025 20:55'!
moveToNextNonAttackedRow
	[neighbor canAttack: row x: column]
	whileTrue: [self advance ifFalse: [^ false]].
	^ true! !

!Queen methodsFor: 'as yet unclassified' stamp: 'NT 4/7/2025 20:55'!
nextSolution
	^ self advance
	and: [self moveToNextNonAttackedRow]! !

!Queen methodsFor: 'as yet unclassified' stamp: 'NT 4/7/2025 20:56'!
result
	"add row to the list"
	^ neighbor result addLast: row; yourself! !

!Queen methodsFor: 'as yet unclassified' stamp: 'NT 4/7/2025 20:53'!
setColumn: aColumn neighbor: aQueen
	column := aColumn.
	neighbor := aQueen! !


Object subclass: #QueenTerminator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Chess'!

!QueenTerminator methodsFor: 'as yet unclassified' stamp: 'NT 4/7/2025 20:59'!
canAttack: testRow x: testColumn
	^ false! !

!QueenTerminator methodsFor: 'as yet unclassified' stamp: 'NT 4/7/2025 20:59'!
firstSolution
	^ true! !

!QueenTerminator methodsFor: 'as yet unclassified' stamp: 'NT 4/7/2025 20:59'!
nextSolution
	^ false! !

!QueenTerminator methodsFor: 'as yet unclassified' stamp: 'NT 4/7/2025 20:59'!
result
	^ OrderedCollection new! !
