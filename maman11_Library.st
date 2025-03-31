Object subclass: #Book
	instanceVariableNames: 'title author year pages'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Library'!

!Book methodsFor: 'accessing' stamp: 'NT 3/27/2025 17:10'!
author
	^author! !

!Book methodsFor: 'accessing' stamp: 'NT 3/27/2025 16:57'!
author: anAuthor
	author := anAuthor! !

!Book methodsFor: 'accessing' stamp: 'NT 3/27/2025 17:10'!
pages
	^pages! !

!Book methodsFor: 'accessing' stamp: 'NT 3/27/2025 16:58'!
pages: pagesCount
	pages := pagesCount! !

!Book methodsFor: 'accessing' stamp: 'NT 3/27/2025 17:09'!
title
	^title! !

!Book methodsFor: 'accessing' stamp: 'NT 3/27/2025 16:55'!
title: aTitle
	title := aTitle! !

!Book methodsFor: 'accessing' stamp: 'NT 3/27/2025 17:10'!
year
	^year! !

!Book methodsFor: 'accessing' stamp: 'NT 3/27/2025 16:58'!
year: aYear
	year := aYear! !


!Book methodsFor: 'initialize-release' stamp: 'NT 3/28/2025 15:51'!
initializeTitle: aTitle author: anAuthor year: aYear pages: pageCount
    title := aTitle.
    author := anAuthor.
    year := aYear.
    pages := pageCount.! !


!Book methodsFor: 'comparing' stamp: 'NT 3/28/2025 16:22'!
= aBook
    ^ (title = aBook title) and: [author = aBook author]
! !


!Book methodsFor: 'printing' stamp: 'NT 3/29/2025 20:04'!
print 
    ^ (self class name , ' title "', self title, '" by ', self author, ' from ', year printString, ' has ', pages printString, ' pages.').! !


Book subclass: #Biography
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Library'!


Object subclass: #BookLibrary
	instanceVariableNames: 'libraryBooks availableBooks members'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Library'!

!BookLibrary methodsFor: 'accessing' stamp: 'NT 3/29/2025 20:24'!
availableBooks
    ^availableBooks! !

!BookLibrary methodsFor: 'accessing' stamp: 'NT 3/29/2025 20:24'!
libraryBooks
    ^libraryBooks! !

!BookLibrary methodsFor: 'accessing' stamp: 'NT 3/29/2025 20:24'!
members
    ^members! !


!BookLibrary methodsFor: 'book-management' stamp: 'NT 3/28/2025 19:07'!
addBook: aBook
    libraryBooks add: aBook.
    availableBooks add: aBook.! !

!BookLibrary methodsFor: 'book-management' stamp: 'NT 3/28/2025 17:47'!
checkTotalBooks
    ^ libraryBooks size! !


!BookLibrary methodsFor: 'printing' stamp: 'NT 3/29/2025 20:16'!
print
    Transcript show: 'Library Books:'; cr.
    libraryBooks do: [:book |
        Transcript show: book title; show: ' by '; show: book author; cr.
    ].

    Transcript show: 'Available Books:'; cr.
    availableBooks do: [:book |
        Transcript show: book title; show: ' by '; show: book author; cr.
    ].

    Transcript show: 'Members:'; cr.
    members do: [:member |
        Transcript show: member name; show: ', id: '; show: member id; cr.
    ].
    Transcript cr.! !


!BookLibrary methodsFor: 'member-management' stamp: 'NT 3/29/2025 16:43'!
addMember: aMember
    members add: aMember.! !

!BookLibrary methodsFor: 'member-management' stamp: 'NT 3/29/2025 20:47'!
borrowBooks: booksToBorrow byMember: aMember

(self members includes: aMember)
	ifFalse: [
		^ self error: 'Is not a member of the library.'.
	].

(booksToBorrow class inheritsFrom: Collection)
        ifFalse: [
	^ self error: 'borrowBooks must be a collection of books.'.
	].

booksToBorrow do: [:aBook |
	(availableBooks includes: aBook) ifFalse: [
	^ self error: 'Book is not available.'.
		]
	].

(booksToBorrow size > 1)
	ifTrue: [
		| addedBooks |
		addedBooks := OrderedCollection new.
		booksToBorrow do: [:aBook |
		(aMember books includes: aBook) ifFalse: [
		aMember  books add: aBook.
		addedBooks add: aBook.
		]
	].

	(aMember hasGenreDiversity) ifFalse: [
	aMember books removeAll: addedBooks.
	^ self error: 'books must contain at least 2 books from 2 different genres.'
       ].
       
	(addedBooks size < booksToBorrow size) ifTrue: [
	^ self error: 'booksToBorrow contains duplicates.'
      ]
      ]
      ifFalse: [
      ^ self error: 'booksToBorrow must contain at least two books.'
       ].
    
booksToBorrow do: [:aBook |
	availableBooks remove: aBook.                        
       ].

    
    
! !

!BookLibrary methodsFor: 'member-management' stamp: 'NT 3/29/2025 21:12'!
returnBooks: booksToReturn byMember: aMember 

 (booksToReturn class inheritsFrom: Collection)
        ifFalse: [
	  (aMember books includes: booksToReturn)
	   ifFalse:[
			^ self error: 'Book does not belong to member.'.
	   ].
		availableBooks add: booksToReturn.
		aMember books remove: booksToReturn ifAbsent: [].
	]

	ifTrue: [
		booksToReturn do: [:aBook |
			availableBooks add: aBook.
			aMember books remove: aBook ifAbsent: [].     
                    ].
			  
		].! !


!BookLibrary methodsFor: 'initialize-release' stamp: 'NT 3/28/2025 17:41'!
initialize
    libraryBooks := OrderedCollection new.
    availableBooks := OrderedCollection new.
    members := OrderedCollection new.! !


Object subclass: #LibraryMember
	instanceVariableNames: 'name id books'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Library'!

!LibraryMember methodsFor: 'accessing' stamp: 'NT 3/28/2025 17:23'!
books
	^books! !

!LibraryMember methodsFor: 'accessing' stamp: 'NT 3/28/2025 17:22'!
id
	^id! !

!LibraryMember methodsFor: 'accessing' stamp: 'NT 3/28/2025 17:22'!
name
	^name! !


!LibraryMember methodsFor: 'book-management' stamp: 'NT 3/29/2025 17:48'!
borrowBooks: booksToBorrow fromLibrary: aLibrary

aLibrary borrowBooks: booksToBorrow byMember: self.
! !

!LibraryMember methodsFor: 'book-management' stamp: 'NT 3/28/2025 21:35'!
hasGenreDiversity
    | bookClassNames uniqueBookClassNames |
    bookClassNames := books collect: [:book | book class name ].
    uniqueBookClassNames := bookClassNames asSet.
    ^ bookClassNames size >= 2 and: [uniqueBookClassNames size >= 2].! !

!LibraryMember methodsFor: 'book-management' stamp: 'NT 3/29/2025 17:35'!
returnBooks: booksToReturn toLibrary: aLibrary

aLibrary returnBooks: booksToReturn byMember: self.


! !


!LibraryMember methodsFor: 'printing' stamp: 'NT 3/29/2025 20:10'!
print
	^ (self class name , ' name: ', self name, ', id: ', self id)

! !


!LibraryMember methodsFor: 'initialize-release' stamp: 'NT 3/28/2025 17:21'!
initializeName: aName id: anId
    name := aName.
    id := anId.
    books := OrderedCollection new.! !


Book subclass: #Novel
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Library'!


Book subclass: #Science
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Library'!
