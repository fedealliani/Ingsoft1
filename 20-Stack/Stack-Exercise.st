!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:31'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/8/2012 08:20'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:33'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'First'.
	secondPushedObject := 'Second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:35'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:36'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:36'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: #'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'stack finder'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'setup' stamp: 'FA 9/18/2019 21:01:45'!
setUp

	finder := SentenceFinderByPrefix new.
	stack := OOStack new.
	! !


!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'FA 9/18/2019 22:44:53'!
areEqual:aStack with:otherStack
	(stack size = aStack size) ifFalse: [^false].
	1 to: aStack size do: [:index | 
		(aStack pop = otherStack  pop) ifFalse: [^false].
		].
	^true.! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'FA 9/18/2019 21:02:01'!
test01OnFindEmptyPrefixRaiseError

	self
		should: [ finder find: '' in:stack  ]
		raise: Error
		withExceptionDo: [ :anError | 
			self assert: anError messageText = (SentenceFinderByPrefix  prefixEmptyErrorDescription) ]
		! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'FA 9/18/2019 21:02:05'!
test02OnFindPrefixWithSpacesRaiseError

	self
		should: [ finder find: 'hola don pepito' in:stack  ]
		raise: Error
		withExceptionDo: [ :anError | 
			self assert: anError messageText = (SentenceFinderByPrefix  prefixContainsSpaceErrorDescription ) ]
	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'FA 9/18/2019 21:04:06'!
test03OnFindValidPrefixInEmptyStackReturnEmptyCollection

	self assert:( (finder find: 'pepito' in: stack) size = 0)
	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'FA 9/18/2019 22:32:07'!
test04OnFindValidPrefixAndStackContainsStringWithThisPrefixReturnNonEmptyCollection
	| result frase1 frase2 |
	frase1 := 'pepito es una gran persona'.
	frase2 := 'pepito tiene 20 años'.
	stack push:frase1.
	stack push: 'carlitos es una mala persona'.
	stack push: 'hola don pepito'.
	stack push: frase2.
	result := finder find: 'pepito' in: stack.
	self assert: result size = 2.
	self assert: (result at:1) = frase2.
	self assert: (result at:2) = frase1.! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'FA 9/18/2019 22:44:23'!
test05OnFindStackNotChange
	| stackCopy frase1 frase2 |
	frase1 := 'pepito es una gran persona'.
	frase2 := 'pepito tiene 20 años'.
	stack push:frase1.
	stack push: frase2.
	stackCopy := stack veryDeepCopy .
	finder find: 'pepito' in: stack.
	self assert: (self areEqual:stack  with:stackCopy ).
	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'FA 9/18/2019 22:47:51'!
test06OnFindValidPrefixAndStackNotContainsStringWithThisPrefixReturnEmptyCollection
	| result |
	stack push:'pepito es una gran persona'.
	stack push: 'carlitos es una mala persona'.
	stack push: 'hola don pepito'.
	stack push: 'pepito tiene 20 años'.
	result := finder find: 'jorgito' in: stack.
	self assert: result size = 0.! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'FA 9/18/2019 22:59:32'!
test07OnFindFilterNonStringObjectsInStack
	| result |
	stack push:'pepito es una gran persona'.
	stack push: stack.
	result := finder find: 'jorgito' in: stack.
	self assert: result size = 0.! !


!classDefinition: #NameOfSubclass category: #'Stack-Exercise'!
Object subclass: #NameOfSubclass
	instanceVariableNames: 'array'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'collection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'testing' stamp: 'FA 9/18/2019 19:50:17'!
isEmpty

	^ self size = 0.! !


!OOStack methodsFor: 'initialization' stamp: 'FA 9/18/2019 19:58:56'!
initialize

	collection := OrderedCollection with:(EmptyStackSlot  new) .
! !


!OOStack methodsFor: 'adding' stamp: 'FA 9/18/2019 19:52:32'!
push: anObject

	collection addFirst: (FilledStackSlot with: anObject) .! !


!OOStack methodsFor: 'removing' stamp: 'FA 9/18/2019 19:56:11'!
pop
      self top.
	^ collection removeFirst content.! !


!OOStack methodsFor: 'accessing' stamp: 'FA 9/18/2019 19:53:06'!
size

	^ collection size - 1.! !

!OOStack methodsFor: 'accessing' stamp: 'FA 9/18/2019 19:53:24'!
top

	^ collection first content.

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'FA 9/18/2019 23:00:38'!
find: aPrefix in: aStack
	| stackTemporal resultado |
	"Asumimos que aPrefix es un string y aStack es un stack. "
	aPrefix ifEmpty: [self error: self class prefixEmptyErrorDescription ].
	((aPrefix  findString:' ') > 0) ifTrue: [self error: self class prefixContainsSpaceErrorDescription].
	resultado := OrderedCollection new.
	stackTemporal := aStack veryDeepCopy.
	1 to: aStack size do: [:index | 
		| tope |
		tope:= stackTemporal pop.
		((tope isKindOf:String) and: [tope beginsWith: aPrefix]) ifTrue: [ resultado add: tope.]
		].
	^resultado.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: #'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'FA 9/18/2019 20:35:14'!
prefixContainsSpaceErrorDescription
	^ 'El prefijo no puede contener espacios vacios'.! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'FA 9/18/2019 20:25:40'!
prefixEmptyErrorDescription
	^ 'El prefijo no puede ser vacio'.! !


!classDefinition: #StackSlot category: #'Stack-Exercise'!
Object subclass: #StackSlot
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #EmptyStackSlot category: #'Stack-Exercise'!
StackSlot subclass: #EmptyStackSlot
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!EmptyStackSlot methodsFor: 'as yet unclassified' stamp: 'FA 9/18/2019 19:46:39'!
content
	self error: OOStack stackEmptyErrorDescription .! !


!classDefinition: #FilledStackSlot category: #'Stack-Exercise'!
StackSlot subclass: #FilledStackSlot
	instanceVariableNames: 'content'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!FilledStackSlot methodsFor: 'as yet unclassified' stamp: 'FA 9/18/2019 19:47:10'!
content
	^content.! !

!FilledStackSlot methodsFor: 'as yet unclassified' stamp: 'FA 9/18/2019 19:47:36'!
initializeWith: aValue
	content := aValue .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FilledStackSlot class' category: #'Stack-Exercise'!
FilledStackSlot class
	instanceVariableNames: ''!

!FilledStackSlot class methodsFor: 'as yet unclassified' stamp: 'FA 9/18/2019 19:52:03'!
with: aValue
	^ self new initializeWith:aValue.! !
