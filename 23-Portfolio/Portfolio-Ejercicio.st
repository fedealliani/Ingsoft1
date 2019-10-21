!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'LR 10/21/2019 13:58:01'!
test01PortfolioHasZeroAsBalanceWhenCreated

	| portfolio |
	
	portfolio := Portfolio new.
		
	self assert: 0 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'LR 10/21/2019 13:58:26'!
test02PortfolioWithOneAccountWithPositiveBalanceHasTheSameBalanceAsThatAccount

	| portfolio account  |
	
	portfolio := Portfolio new.
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	portfolio add: account.
	
	self assert: 100 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'LR 10/21/2019 14:01:57'!
test03PortfolioWithOneAccountWithNegativeBalanceHasTheSameBalanceAsThatAccount

	| portfolio account  |
	
	portfolio := Portfolio new.
	
	account := ReceptiveAccount new.
	Withdraw register: 100 on: account.
	
	portfolio add: account.
	
	self assert: -100 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'LR 10/21/2019 14:02:01'!
test04PortfolioWithTwoAccountsWithBothPositiveBalanceHasTheSumOfBalancesOfThoseAccountAsBalance

	| portfolio account1 account2  |
	
	portfolio := Portfolio new.
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Deposit register: 100 on: account1.
	Deposit register: 200 on: account2.
	
	portfolio add: account1.
	portfolio add: account2.
	
	self assert: 300 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'LR 10/21/2019 14:02:05'!
test05PortfolioWithTwoAccountsWithBothNegativeBalanceHasTheSumOfBalancesOfThoseAccountAsBalance

	| portfolio account1 account2  |
	
	portfolio := Portfolio new.
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Withdraw register: 100 on: account1.
	Withdraw register: 200 on: account2.
	
	portfolio add: account1.
	portfolio add: account2.
	
	self assert: -300 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'LR 10/21/2019 14:02:10'!
test06PortfolioWithTwoAccountsWithOneOfThemWithPositiveBalanceAndTheOtherOneWithNegativeBalanceHasTheSumOfBalancesOfThoseAccountAsBalance

	| portfolio account1 account2  |
	
	portfolio := Portfolio new.
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Deposit register: 100 on: account1.
	Withdraw register: 200 on: account2.
	
	portfolio add: account1.
	portfolio add: account2.
	
	self assert: -100 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'LR 10/21/2019 14:02:14'!
test07PortfolioWithTwoAccountsWithOneOfThemWithPositiveBalanceAndTheOtherOneWithExactBalanceAsTheFirstOneButNegativeBalanceHasZeroAsBalance

	| portfolio account1 account2  |
	
	portfolio := Portfolio new.
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Deposit register: 100 on: account1.
	Withdraw register: 100 on: account2.
	
	portfolio add: account1.
	portfolio add: account2.
	
	self assert: 0 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'LR 10/21/2019 14:02:18'!
test08PortfolioWithAnEmptyPortfolioInsideHasZeroAsBalance

	| mainPortfolio childPortfolio  |
	
	mainPortfolio := Portfolio new.
	childPortfolio := Portfolio new.
	
	mainPortfolio add: childPortfolio.
	
	self assert: 0 equals: mainPortfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'LR 10/21/2019 14:02:22'!
test09PortfolioWithAPortfolioInsideThatHasAnAccountInsideHasThatAccountBalanceAsBalance

	| mainPortfolio childPortfolio account1 |
	
	mainPortfolio := Portfolio new.
	childPortfolio := Portfolio new.
	
	account1 := ReceptiveAccount new.
	
	Deposit register: 100 on: account1.
	
	childPortfolio add: account1.
	
	mainPortfolio add: childPortfolio.
	
	self assert: 100 equals: mainPortfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'LR 10/21/2019 14:02:25'!
test10TransactionsOfAnEmptyPortfolioIsAnEmptyCollection

	| portfolio |
	
	portfolio := Portfolio new.
	
	self assert: 0 equals: portfolio numberOfTransactions.
! !

!PortfolioTest methodsFor: 'tests' stamp: 'LR 10/21/2019 14:02:28'!
test11TransactionsOfAPortfolioWithSomeAccountsInsideAreTheUnionOfTransactionOfThoseAccounts

	| portfolio account1 account2 account3 transactions |
	
	transactions := OrderedCollection new.
	
	portfolio := Portfolio new.
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	
	transactions add: (Deposit register: 50 on: account1).
	transactions add: (Deposit register: 100 on: account2).
	transactions add: (Deposit register: 200 on: account3).
	transactions add: (Withdraw register: 25 on: account1).
	transactions add: (Withdraw register: 10 on: account3).
	
	portfolio add: account1.
	portfolio add: account2.
	portfolio add: account3.
		
	self assert: transactions size equals: portfolio numberOfTransactions.
	self assert: (portfolio transactions includesAllOf: transactions).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'LR 10/21/2019 14:02:31'!
test12TransactionsOfAPortfolioWithAnEmptyPortfolioInsideIsAnEmptyCollection

	| mainPortfolio childPortfolio |
	
	mainPortfolio := Portfolio new.
	childPortfolio := Portfolio new.
	
	mainPortfolio add: childPortfolio.
		
	self assert: 0 equals: mainPortfolio numberOfTransactions.
! !

!PortfolioTest methodsFor: 'tests' stamp: 'LR 10/21/2019 14:02:37'!
test13TransactionsOfAPortfolioWithBothAccountsAndPortfoliosInsideIsTheUnionOfAllTheTransactionsOfThoseAccountsAndPortfolios

	| mainPortfolio portfolio2 portfolio3 portfolio4 account1 account2 account3 account4 account5 transactions |
	
	transactions := OrderedCollection new.

	mainPortfolio := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	portfolio4 := Portfolio new.
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	account4 := ReceptiveAccount new.
	account5 := ReceptiveAccount new.
	
	transactions add: (Deposit register: 10 on: account1).
	transactions add: (Deposit register: 20 on: account1).
	transactions add: (Deposit register: 30 on: account1).
	
	transactions add: (Withdraw register: 100 on: account2).
	transactions add: (Withdraw register: 42 on: account2).
	transactions add: (Deposit register: 500 on: account2).
	
	transactions add: (Deposit register: 120 on: account3).
	transactions add: (Withdraw register: 1984 on: account3).
	transactions add: (Withdraw register: 2020 on: account3).
	
	transactions add: (Deposit register: 1000001 on: account5).
	
	portfolio3 add: account3.
	portfolio3 add: account4.
	
	portfolio2 add: account2.
	portfolio2 add: portfolio3.
	
	mainPortfolio add: account1.
	mainPortfolio add: portfolio2.
	mainPortfolio add: portfolio4.
	mainPortfolio add: account5.
	
	self assert: transactions size equals: mainPortfolio numberOfTransactions.
! !

!PortfolioTest methodsFor: 'tests' stamp: 'LR 10/21/2019 14:02:44'!
test14PortfolioWithAnAccountWithTransactionsHasThoseTransactionsRegistered

	| portfolio account deposit withdraw |
	
	portfolio := Portfolio new.
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 200 on: account.
	withdraw := Withdraw register: 80 on: account.
	
	portfolio add: account.

	self assert: (portfolio hasRegistered: deposit).
	self assert: (portfolio hasRegistered: withdraw).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'LR 10/21/2019 14:02:47'!
test15PortfolioWithAPortfolioWithTransactionsHasThoseTransactionsRegistered

	| mainPortfolio childPortfolio account deposit withdraw |
	
	mainPortfolio := Portfolio new.
	childPortfolio := Portfolio new.
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 200 on: account.
	withdraw := Withdraw register: 120 on: account.
	
	childPortfolio add: account.
	mainPortfolio add: childPortfolio.

	self assert: (mainPortfolio hasRegistered: deposit).
	self assert: (mainPortfolio hasRegistered: withdraw).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'LR 10/21/2019 14:02:50'!
test16CannotAddAnAccountToAPortfolioThatAlreadyHasThatAccount

	| portfolio account |
	
	portfolio := Portfolio new.
	
	account := ReceptiveAccount new.
	
	portfolio add: account.
	
	self
		should: [
			portfolio add: account.
		]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: Portfolio duplicatedFinancialRecordErrorDescription equals: error messageText.
			self assert: 1 equals: portfolio numberOfAccounts.
			self assert: (portfolio accounts includes: account).
		]
		! !

!PortfolioTest methodsFor: 'tests' stamp: 'LR 10/21/2019 14:02:54'!
test17CannotAddAPortfolioToAPortfolioThatAlreadyHasThatPortfolio

	| portfolio1 portfolio2 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	
	portfolio1 add: portfolio2.
	
	self
		should: [
			portfolio1 add: portfolio2.
		]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: Portfolio duplicatedFinancialRecordErrorDescription equals: error messageText.
		]
		! !

!PortfolioTest methodsFor: 'tests' stamp: 'LR 10/21/2019 14:02:56'!
test18CannotAddAnAccountToAPortfolioThatHasAPortfolioWithThatAccount

	| mainPortfolio childPortfolio account |
	
	mainPortfolio := Portfolio new.
	childPortfolio := Portfolio new.
	
	account := ReceptiveAccount new.
	
	childPortfolio add: account.
	mainPortfolio add: childPortfolio.
	
	self
		should: [
			mainPortfolio add: account.
		]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: Portfolio duplicatedFinancialRecordErrorDescription equals: error messageText.
			self assert: 1 equals: mainPortfolio numberOfAccounts.
			self assert: (mainPortfolio accounts includes: account).
		]
		! !

!PortfolioTest methodsFor: 'tests' stamp: 'LR 10/21/2019 14:03:00'!
test19CannotAddAPortfolioToItself

	| portfolio |
	
	portfolio := Portfolio new.
	
	self
		should: [
			portfolio add: portfolio.
		]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: Portfolio cannotAddPortfolioToItselfErrorDescription equals: error messageText.
		]
		! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LR 10/20/2019 22:32:36'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 numberOfTransactions.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'LR 10/17/2019 19:29:24'!
updateBalance: aBalance 

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'LR 10/17/2019 19:28:38'!
updateBalance: aBalance

	^ aBalance + self value! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'LR 10/17/2019 19:29:06'!
updateBalance: aBalance

	^ aBalance - self value! !

!Withdraw methodsFor: 'value' stamp: 'LR 10/17/2019 18:43:10'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #FinancialRecord category: #'Portfolio-Ejercicio'!
Object subclass: #FinancialRecord
	instanceVariableNames: 'parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!FinancialRecord methodsFor: 'testing' stamp: 'LR 10/21/2019 00:49:30'!
hasFinancialRecord: anAccount 

	self subclassResponsibility! !

!FinancialRecord methodsFor: 'testing' stamp: 'LR 10/20/2019 21:15:53'!
hasRegistered: aTransaction 

	self subclassResponsibility! !


!FinancialRecord methodsFor: 'accessing' stamp: 'LR 10/20/2019 21:10:12'!
balance

	self subclassResponsibility! !

!FinancialRecord methodsFor: 'accessing' stamp: 'LR 10/20/2019 22:32:16'!
numberOfTransactions

	^self transactions size! !

!FinancialRecord methodsFor: 'accessing' stamp: 'LR 10/20/2019 21:10:51'!
transactions

	self subclassResponsibility! !


!FinancialRecord methodsFor: 'initialization' stamp: 'LR 10/21/2019 15:09:34'!
initialize

	parents := OrderedCollection new.! !


!FinancialRecord methodsFor: 'actions' stamp: 'LR 10/21/2019 15:09:21'!
addParent: aFinancialRecord

	parents add: aFinancialRecord.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FinancialRecord class' category: #'Portfolio-Ejercicio'!
FinancialRecord class
	instanceVariableNames: ''!

!FinancialRecord class methodsFor: 'error descriptions' stamp: 'LR 10/21/2019 15:01:39'!
cannotAddPortfolioToItselfErrorDescription
	
	^ 'Cannot add portfolio to itself'! !

!FinancialRecord class methodsFor: 'error descriptions' stamp: 'LR 10/21/2019 15:36:28'!
commonFinancialRecordsErrorDescription
	
	^ 'Cannot add this financial record because there is a financial record on it that already belongs to this financial record'! !

!FinancialRecord class methodsFor: 'error descriptions' stamp: 'LR 10/21/2019 15:01:46'!
cyclicFinancialRecordErrorDescription
	
	^ 'Cannot add this financial record because it introduces a cycle'! !

!FinancialRecord class methodsFor: 'error descriptions' stamp: 'LR 10/21/2019 00:56:20'!
duplicatedFinancialRecordErrorDescription

	^ 'Cannot add this financial record because it already belongs to the financial record.'! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
FinancialRecord subclass: #Portfolio
	instanceVariableNames: 'financialRecords'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'actions' stamp: 'LR 10/21/2019 15:32:52'!
add: aFinancialRecord
	
	self assertFinancialRecordNotAdded: aFinancialRecord.
	self assertFinancialRecordIsNotThisPortfolio: aFinancialRecord.
	self assertFinancialRecordDoesNotHasThisPortfolio: aFinancialRecord.
	self assertThisPorfolioDoesNotBelongsToATreeOfFinancialRecordsThatContains: aFinancialRecord.

	financialRecords add: aFinancialRecord.
	aFinancialRecord addParent: self.! !


!Portfolio methodsFor: 'initialization' stamp: 'LR 10/21/2019 15:25:43'!
initialize
	
	super initialize.
	financialRecords := OrderedCollection new.! !


!Portfolio methodsFor: 'testing' stamp: 'LR 10/21/2019 00:54:36'!
hasFinancialRecord: aFinancialRecord
	
	^ financialRecords anySatisfy: [ :anotherFinancialRecord | anotherFinancialRecord = aFinancialRecord or: [ anotherFinancialRecord hasFinancialRecord: aFinancialRecord ] ].! !

!Portfolio methodsFor: 'testing' stamp: 'LR 10/20/2019 21:05:00'!
hasRegistered: aTransaction 
	
	^ financialRecords anySatisfy: [ :aFinancialRecord | aFinancialRecord hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'LR 10/21/2019 15:27:19'!
parentsHasFinancialRecords: aFinancialRecord

	^parents anySatisfy: [ :portfolio | (portfolio hasFinancialRecord: aFinancialRecord) or: [ portfolio parentsHasFinancialRecords: aFinancialRecord ] ]! !


!Portfolio methodsFor: 'accessing' stamp: 'LR 10/21/2019 00:37:38'!
accounts

	^ financialRecords inject: (OrderedCollection new) into: [ :accounts :aFinancialRecord | accounts addAll: aFinancialRecord accounts; yourself ].
	! !

!Portfolio methodsFor: 'accessing' stamp: 'LR 10/20/2019 21:04:49'!
balance

	^ financialRecords sum: [ :aFinancialRecord | aFinancialRecord balance ] ifEmpty: [ 0 ]! !

!Portfolio methodsFor: 'accessing' stamp: 'LR 10/21/2019 00:36:03'!
numberOfAccounts
	
	^ self accounts size! !

!Portfolio methodsFor: 'accessing' stamp: 'LR 10/20/2019 22:23:54'!
transactions

	^ financialRecords inject: (OrderedCollection new) into: [ :transactions :aFinancialRecord | transactions addAll: aFinancialRecord transactions; yourself ].
	! !


!Portfolio methodsFor: 'as yet unclassified' stamp: 'LR 10/21/2019 14:58:17'!
assertFinancialRecordDoesNotHasThisPortfolio: aFinancialRecord
	
	(aFinancialRecord hasFinancialRecord: self) ifTrue: [ self error:  self class cyclicFinancialRecordErrorDescription ]! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'LR 10/21/2019 15:02:22'!
assertFinancialRecordIsNotThisPortfolio: aFinancialRecord
	
	(aFinancialRecord = self) ifTrue: [ self error:  self class cannotAddPortfolioToItselfErrorDescription ]! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'LR 10/21/2019 15:31:51'!
assertFinancialRecordNotAdded: aFinancialRecord
	
	(self hasFinancialRecord: aFinancialRecord) ifTrue: [ self error:  self class duplicatedFinancialRecordErrorDescription ]! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'LR 10/21/2019 15:36:28'!
assertThisPorfolioDoesNotBelongsToATreeOfFinancialRecordsThatContains: aFinancialRecord
	
	(self parentsHasFinancialRecords: aFinancialRecord) ifTrue: [ self error:  self class commonFinancialRecordsErrorDescription ]! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
FinancialRecord subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'LR 10/21/2019 15:10:01'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'actions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !


!ReceptiveAccount methodsFor: 'accessing' stamp: 'LR 10/21/2019 00:44:32'!
accounts 

	^ OrderedCollection with: self! !

!ReceptiveAccount methodsFor: 'accessing' stamp: 'LR 10/20/2019 21:01:18'!
balance

	^ transactions inject: 0 into: [ :balance :aTransaction | aTransaction updateBalance: balance ].
	! !

!ReceptiveAccount methodsFor: 'accessing' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'LR 10/21/2019 00:55:25'!
hasFinancialRecord: aFinancialRecord

	^ self = aFinancialRecord
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !
