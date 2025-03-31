TestCase subclass: #BookLibraryTest
	instanceVariableNames: 'library book1 book2 member'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'LibraryTest'!

!BookLibraryTest methodsFor: 'testing' stamp: 'NT 3/30/2025 18:50'!
setUp
    book1 := Biography new.
    book1 initializeTitle: 'Einstein' author: 'Walter Isaacson' year: 2007 pages: 716. 
    book2 := Novel new.
    book2 initializeTitle: 'Pride and Prejudice' author: 'Jane Austen' year: 1813 pages: 432.
    
    member := LibraryMember new.
    member initializeName: 'Alice' id: 12345.

    library := BookLibrary new.
! !

!BookLibraryTest methodsFor: 'testing' stamp: 'NT 3/30/2025 19:01'!
testAdd
    library addBook: book1.
    library addBook: book2.
    self assert: (library libraryBooks includes: book1) description: 'Error in adding book1 to library'.
    self assert: (library libraryBooks includes: book2) description: 'Error in adding book2 to library'.

    library addMember: member.
    self assert: (library members includes: member) description: 'Error in registering member'.

    library borrowBooks: {book1. book2.} byMember: member.
    self deny: (library availableBooks includes: book1) description: 'Error in borrowing book by member'.
    self assert: (member books includes: book1) description: 'Error in borrowing book by member'.

    library returnBooks: book1 byMember: member.
    self assert: (library availableBooks includes: book1) description: 'Error in returning book'.
	
    self assert: (library checkTotalBooks = 2) description: 'Error in book count'.

! !


TestCase subclass: #BookTest
	instanceVariableNames: 'book'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'LibraryTest'!

!BookTest methodsFor: 'testing' stamp: 'NT 3/30/2025 18:09'!
setUp
book := Book new.
book initializeTitle: 'The Hobbit' author: 'J.R.R. Tolkien' year: 1937 pages: 300.! !

!BookTest methodsFor: 'testing' stamp: 'NT 3/30/2025 18:21'!
testAdd
    self assert: (book title = 'The Hobbit') description: 'Error in Book''s title initialization!!'.
    self assert: (book author = 'J.R.R. Tolkien') description: 'Error in Book''s author initialization!!'.
    self assert: (book year = 1937) description: 'Error in Book''s year initialization!!'.
    self assert: (book pages = 300) description: 'Error in Book''s pages initialization!!'.
! !


TestCase subclass: #LibraryMemberTest
	instanceVariableNames: 'library member book1 book2'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'LibraryTest'!

!LibraryMemberTest methodsFor: 'testing' stamp: 'NT 3/30/2025 18:33'!
setUp
    book1 := Biography new.
    book1 initializeTitle: 'Einstein' author: 'Walter Isaacson' year: 2007 pages: 716. 
    book2 := Novel new.
    book2 initializeTitle: 'Pride and Prejudice' author: 'Jane Austen' year: 1813 pages: 432.
    
    member := LibraryMember new.
    member initializeName: 'Alice' id: 12345.

    library := BookLibrary new.
    library addBook: book1.
    library addBook: book2.
    library addMember: member.

! !

!LibraryMemberTest methodsFor: 'testing' stamp: 'NT 3/30/2025 18:32'!
testAdd
member borrowBooks: {book1. book2.} fromLibrary: library.
self assert: (member books includes: book1) description: 'Error in borrowing book1'.
self assert: (member books includes: book2) description: 'Error in borrowing book2'.

member returnBooks: {book1. book2.} toLibrary: library.
self deny: (member books includes: book1) description: 'Error in returning book1'.
self deny: (member books includes: book2) description: 'Error in returning book2'.
! !
