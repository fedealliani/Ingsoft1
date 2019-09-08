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

!CustomerBookTest methodsFor: 'testing' stamp: 'FA 9/8/2019 15:04:02'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self
		check: [ customerBook removeCustomerNamed: 'Paul McCartney'. ]
		raisesErrorOfType: NotFound
		andTest: [ self checkCustomerBook: customerBook onlyHasTheCustomerNamed: johnLennon. ].
	! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FA 9/8/2019 15:03:34'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self checkCustomerBook: customerBook hasAmountOfActiveCustomers:0.
	self checkCustomerBook: customerBook hasAmountOfSuspendedCustomers:1.  
	self checkCustomerBook: customerBook hasAmountOfTotalCustomers:1.
	self checkCustomerBook:customerBook  hasTheCustomerNamed:paulMcCartney. 	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FA 9/8/2019 15:01:54'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self checkCustomerBook: customerBook hasAmountOfActiveCustomers:0.
	self checkCustomerBook: customerBook hasAmountOfSuspendedCustomers:0.  
	self checkCustomerBook: customerBook hasAmountOfTotalCustomers:0.
	self checkCustomerBook: customerBook doesNotHasTheCustomerNamed:paulMcCartney.


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FA 9/8/2019 15:04:06'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self
		check: [ customerBook suspendCustomerNamed: 'Paul McCartney'. ]
		raisesErrorOfType: CantSuspend
		andTest: [ self checkCustomerBook: customerBook onlyHasTheCustomerNamed: johnLennon. ].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FA 9/8/2019 15:04:08'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	self
		check: [ customerBook suspendCustomerNamed: johnLennon. ]
		raisesErrorOfType: CantSuspend 
		andTest: [ self checkCustomerBook: customerBook onlyHasTheCustomerNamed: johnLennon. ].
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

!CustomerBookTest methodsFor: 'helpers' stamp: 'FA 9/8/2019 15:01:29'!
checkCustomerBook: customerBook doesNotHasTheCustomerNamed: customerName

	self assert: ((customerBook includes: customerName) not).! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'FA 9/8/2019 14:51:16'!
checkCustomerBook: customerBook hasAmountOfActiveCustomers: quantity

	self assert: customerBook numberOfActiveCustomers = quantity.! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'FA 9/8/2019 14:51:30'!
checkCustomerBook: customerBook hasAmountOfSuspendedCustomers: quantity

	self assert: customerBook numberOfSuspendedCustomers = quantity.! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'FA 9/8/2019 14:51:57'!
checkCustomerBook: customerBook hasAmountOfTotalCustomers: quantity

	self assert: customerBook numberOfCustomers = quantity.! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'FA 9/8/2019 15:03:15'!
checkCustomerBook: customerBook hasTheCustomerNamed: customerName

	self assert: (customerBook includes: customerName).! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'FA 9/8/2019 15:03:47'!
checkCustomerBook: customerBook onlyHasTheCustomerNamed: customerName

	self checkCustomerBook: customerBook hasAmountOfTotalCustomers:1. 
	self checkCustomerBook:customerBook  hasTheCustomerNamed:customerName.! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'LR 9/2/2019 20:53:52'!
getCurrentExecutionTime.

	^ Time millisecondClockValue * millisecond.! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'FA 9/8/2019 13:59:05'!
includes: customerName

	^(active includes: customerName) or: [ suspended includes: customerName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 4/3/2019 10:14:26'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'errors' stamp: 'FA 9/8/2019 14:34:18'!
raiseErrorWithClassMessage: classMessage

	self error: (self class perform: classMessage).
	! !

!CustomerBook methodsFor: 'errors' stamp: 'FA 9/8/2019 14:34:27'!
signalCustomerAlreadyExists 

	self raiseErrorWithClassMessage: #customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'errors' stamp: 'FA 9/8/2019 14:34:32'!
signalCustomerNameCannotBeEmpty 

	self raiseErrorWithClassMessage: #customerCanNotBeEmptyErrorMessage ! !


!CustomerBook methodsFor: 'customer management' stamp: 'FA 9/8/2019 14:06:02'!
addCustomerNamed: customerName

	customerName ifEmpty: [ self signalCustomerNameCannotBeEmpty ].
	(self includes: customerName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: customerName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'FA 9/8/2019 14:15:56'!
removeCustomerNamed: customerName

	active remove: customerName ifAbsent: [
		suspended remove: customerName ifAbsent: [
			NotFound signal.
		].
	].

! !

!CustomerBook methodsFor: 'customer management' stamp: 'FA 9/8/2019 14:36:33'!
suspendCustomerNamed: customerName 
	
	(active includes: customerName) ifFalse: [^CantSuspend signal].
	
	active remove: customerName.
	
	suspended add: customerName
! !


!CustomerBook methodsFor: 'accessing' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'accessing' stamp: 'LR 9/2/2019 19:01:22'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers ! !

!CustomerBook methodsFor: 'accessing' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

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
