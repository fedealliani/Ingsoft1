!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'LR 9/2/2019 20:52:27'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self check: [customerBook addCustomerNamed: 'John Lennon'.] takesLessThan: 50 * millisecond.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LR 9/2/2019 20:53:06'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	
	self check: [customerBook removeCustomerNamed: paulMcCartney.] takesLessThan: 100 * millisecond.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LR 9/2/2019 21:44:48'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.
	
	self
		check: [ customerBook addCustomerNamed: ''. ]
		raisesErrorOfType: Error
		andTest: [
			:anError |
				self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
				self assert: customerBook isEmpty
		].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LR 9/2/2019 21:47:18'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self
		check: [ customerBook removeCustomerNamed: 'Paul McCartney'. ]
		raisesErrorOfType: NotFound
		andTest: [ self checkCustomerBook: customerBook onlyHasTheClient: johnLennon. ].
	! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NR 4/3/2019 10:50:25'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: 1 equals: customerBook numberOfSuspendedCustomers.
	self assert: 1 equals: customerBook numberOfCustomers.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NR 4/3/2019 10:50:28'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: 0 equals: customerBook numberOfSuspendedCustomers.
	self assert: 0 equals: customerBook numberOfCustomers.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LR 9/2/2019 21:47:27'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self
		check: [ customerBook suspendCustomerNamed: 'Paul McCartney'. ]
		raisesErrorOfType: CantSuspend
		andTest: [ self checkCustomerBook: customerBook onlyHasTheClient: johnLennon. ].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LR 9/2/2019 21:47:33'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	self
		check: [ customerBook suspendCustomerNamed: johnLennon. ]
		raisesErrorOfType: CantSuspend 
		andTest: [ self checkCustomerBook: customerBook onlyHasTheClient: johnLennon. ].
! !


!CustomerBookTest methodsFor: 'helpers' stamp: 'LR 9/2/2019 21:43:14'!
check: aFailingBlock raisesErrorOfType: errorType andTest: assertingBlock

	[ aFailingBlock value. self fail ]
		on: errorType 
		do: assertingBlock.
! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'LR 9/2/2019 20:54:18'!
check: collaborationSequence takesLessThan: maxTime

	| millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := self getCurrentExecutionTime.
	collaborationSequence value.
	millisecondsAfterRunning := self getCurrentExecutionTime.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < maxTime
	
! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'LR 9/2/2019 21:22:23'!
checkCustomerBook: customerBook onlyHasTheClient: clientName

	self assert: customerBook numberOfCustomers = 1.
	self assert: (customerBook includesCustomerNamed: clientName).! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'LR 9/2/2019 20:53:52'!
getCurrentExecutionTime.

	^ Time millisecondClockValue * millisecond.! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 4/3/2019 10:14:26'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'LR 9/2/2019 18:58:53'!
addCustomerNamed: aName

	aName ifEmpty: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'LR 9/2/2019 19:01:22'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'LR 9/2/2019 19:38:02'!
removeCustomerNamed: clientName

	^active remove: clientName ifAbsent: [
		^suspended remove: clientName ifAbsent: [
			^ NotFound signal.
		].
	].

! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'LR 9/2/2019 19:43:08'!
suspendCustomerNamed: clientName 
	
	(active includes: clientName) ifFalse: [^CantSuspend signal].
	
	active remove: clientName.
	
	suspended add: clientName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/2/2019 14:41:10'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists.'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/2/2019 14:41:16'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty.'! !
