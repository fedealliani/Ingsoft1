!classDefinition: #PortfolioTest category: #'24-PortfolioTreePrinter'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '24-PortfolioTreePrinter'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:17:51'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:15'!
test08PortfolioTransasctionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: #'24-PortfolioTreePrinter'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '24-PortfolioTreePrinter'!

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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #SummaryReportTest category: #'24-PortfolioTreePrinter'!
TestCase subclass: #SummaryReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '24-PortfolioTreePrinter'!

!SummaryReportTest methodsFor: 'tests' stamp: 'LR 10/28/2019 14:29:50'!
test01SummaryReportOfEmptyAccountIsJustTheAccountBalance

	| account report |
	
	account := ReceptiveAccount new.
	report := SummaryReport for: account.
	
	
	self assert: ('Balance = 0', Character cr asString) equals: report print.! !

!SummaryReportTest methodsFor: 'tests' stamp: 'LR 10/28/2019 14:54:41'!
test02SummaryReportOfAccountWithADepositHasThatDeposit

	| account report |
	
	account := ReceptiveAccount new.
	report := SummaryReport for: account.
	
	Deposit register: 500 on: account.
	
	self assert: (
		'Depósito por 500.',
		Character cr asString,
		'Balance = 500',
		Character cr asString
	) equals: report print.! !

!SummaryReportTest methodsFor: 'tests' stamp: 'LR 10/28/2019 14:55:22'!
test03SummaryReportOfAccountWithAWithdrawHasThatWithdraw

	| account report |
	
	account := ReceptiveAccount new.
	report := SummaryReport for: account.
	
	Withdraw register: 500 on: account.
	
	self assert: (
		'Extracción por 500.',
		Character cr asString,
		'Balance = -500',
		Character cr asString
	) equals: report print.! !

!SummaryReportTest methodsFor: 'tests' stamp: 'LR 10/28/2019 14:57:02'!
test04SummaryReportOfAccountWithAnIncomingTransferHasThatIncomingTransfer

	| account1 account2 report |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	report := SummaryReport for: account2.
	
	Transfer newFrom: account1 to: account2 forValue: 500.
	
	self assert: (
		'Entrada por transferencia de 500.',
		Character cr asString,
		'Balance = 500',
		Character cr asString
	) equals: report print.! !

!SummaryReportTest methodsFor: 'tests' stamp: 'LR 10/28/2019 14:57:25'!
test05SummaryReportOfAccountWithAnOutgoingTransferHasThatOutgoingTransfer

	| account1 account2 report |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	report := SummaryReport for: account1.
	
	Transfer newFrom: account1 to: account2 forValue: 500.
	
	self assert: (
		'Salida por transferencia de 500.',
		Character cr asString,
		'Balance = -500',
		Character cr asString
	) equals: report print.! !

!SummaryReportTest methodsFor: 'tests' stamp: 'LR 10/28/2019 15:00:01'!
test06SummaryReportOfAccountWithMultipleTransactionsHasAllThoseTransactionsInOrder

	| account1 account2 report |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	report := SummaryReport for: account1.
	
	Transfer newFrom: account1 to: account2 forValue: 500.
	Transfer newFrom: account2 to: account1 forValue: 250.
	Withdraw register: 100 on: account1.
	Deposit register: 1000 on: account1.
	
	self assert: (
		'Salida por transferencia de 500.',
		Character cr asString,
		'Entrada por transferencia de 250.',
		Character cr asString,
		'Extracción por 100.',
		Character cr asString,
		'Depósito por 1000.',
		Character cr asString,
		'Balance = 650',
		Character cr asString
	) equals: report print.! !



!classDefinition: #TransferNetReportTest category: #'24-PortfolioTreePrinter'!
TestCase subclass: #TransferNetReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '24-PortfolioTreePrinter'!

!TransferNetReportTest methodsFor: 'tests' stamp: 'LR 10/28/2019 16:16:51'!
test01TransferNetReportOfAccountWithoutTransfersIsZero

	| account report |
	
	account := ReceptiveAccount new.
	report := TransferNetReport for: account.
	
	self assert: ('Neto de transferencias = 0', Character cr asString) equals: report print.! !

!TransferNetReportTest methodsFor: 'tests' stamp: 'LR 10/28/2019 16:19:36'!
test02TransferNetReportOfAccountWithAnIncomingTransferIsTheValueOfThatIncomingTransfer

	| account1 account2 report |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	report := TransferNetReport for: account2.
	
	Transfer newFrom: account1 to: account2 forValue: 500.
	
	self assert: ('Neto de transferencias = 500', Character cr asString) equals: report print.! !

!TransferNetReportTest methodsFor: 'tests' stamp: 'LR 10/28/2019 16:42:21'!
test03TransferNetReportOfAccountWithAnOutgoingTransferIsTheNegatedValueOfThatOutgoingTransfer

	| account1 account2 report |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	report := TransferNetReport for: account1.
	
	Transfer newFrom: account1 to: account2 forValue: 500.
	
	self assert: ('Neto de transferencias = -500', Character cr asString) equals: report print.! !


!classDefinition: #TransferTest category: #'24-PortfolioTreePrinter'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '24-PortfolioTreePrinter'!

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LR 10/28/2019 13:18:07'!
test01ValidTransferMakesSenderAccountToDecreaseBalanceAndReceiverAccountIncreasesSameBalance

	| account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Deposit register: 1000 on: account1.
	
	Transfer newFrom: account1 to: account2 forValue: 200.
	
	self assert: 200 equals: account2 balance.
	self assert: 800 equals: account1 balance.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LR 10/28/2019 13:45:05'!
test02CannotTransferAZeroValue

	| account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	self
		should: [ Transfer newFrom: account1 to: account2 forValue: 0 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :error |
			self assert: Transfer cannotTransferAZeroValueErrorDescription equals: error messageText.
			self assert: 0 equals: account1 balance.
			self assert: 0 equals: account2 balance.
			self assert: 0 equals: account1 transactionsCount.
			self assert: 0 equals: account2 transactionsCount.
		].! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LR 10/28/2019 13:45:14'!
test03CannotTransferANegativeValue

	| account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	self
		should: [ Transfer newFrom: account1 to: account2 forValue: -100 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :error |
			self assert: Transfer cannotTransferANegativeValueErrorDescription equals: error messageText.
			self assert: 0 equals: account1 balance.
			self assert: 0 equals: account2 balance.
			self assert: 0 equals: account1 transactionsCount.
			self assert: 0 equals: account2 transactionsCount.
		].! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LR 10/28/2019 13:45:26'!
test04CannotTransferBetweenSameAccount

	| account |
	
	account := ReceptiveAccount new.
	
	self
		should: [ Transfer newFrom: account to: account forValue: 100 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :error |
			self assert: Transfer cannotTransferBetweenSameAccountErrorDescription equals: error messageText.
			self assert: 0 equals: account balance.
			self assert: 0 equals: account transactionsCount.
		].! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LR 10/28/2019 13:50:24'!
test05GettingOutgoingTransferOfTheIncomingTransferEqualsOutgoingTransferOfTheWholeTransfer

	| account1 account2 transfer |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	transfer := Transfer newFrom: account1 to: account2 forValue: 100.
	
	self assert: transfer outgoingTransfer equals: transfer incomingTransfer outgoingTransfer.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LR 10/28/2019 13:50:09'!
test06GettingIncomingTransferOfTheOutgoingTransferEqualsOutgoingTransferOfTheWholeTransfer

	| account1 account2 transfer |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	transfer := Transfer newFrom: account1 to: account2 forValue: 100.
	
	self assert: transfer incomingTransfer equals: transfer outgoingTransfer incomingTransfer.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LR 10/28/2019 13:51:56'!
test07OutgoingTransferGetsRegisteredInSenderAccount

	| account1 account2 transfer |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	transfer := Transfer newFrom: account1 to: account2 forValue: 100.
	
	self assert: (account1 hasRegistered: transfer outgoingTransfer).! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LR 10/28/2019 13:52:15'!
test08IncomingTransferGetsRegisteredInReceiverAccount

	| account1 account2 transfer |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	transfer := Transfer newFrom: account1 to: account2 forValue: 100.
	
	self assert: (account2 hasRegistered: transfer incomingTransfer).! !


!classDefinition: #Account category: #'24-PortfolioTreePrinter'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '24-PortfolioTreePrinter'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'reporting' stamp: 'LR 10/28/2019 16:27:55'!
write: anAccountReport on: aWriteStream 
	
	self transactions do: [ :aTransaction | aTransaction write: anAccountReport on: aWriteStream ].! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'LR 10/28/2019 13:42:17'!
transactionsCount

	^self transactions size! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'24-PortfolioTreePrinter'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: '24-PortfolioTreePrinter'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'24-PortfolioTreePrinter'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: #'24-PortfolioTreePrinter'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: '24-PortfolioTreePrinter'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !



!classDefinition: #AccountReport category: #'24-PortfolioTreePrinter'!
Object subclass: #AccountReport
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: '24-PortfolioTreePrinter'!

!AccountReport methodsFor: 'initialization' stamp: 'LR 10/28/2019 13:54:26'!
initializeFor: anAccount

	account := anAccount! !


!AccountReport methodsFor: 'printing' stamp: 'LR 10/28/2019 15:59:11'!
print

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountReport class' category: #'24-PortfolioTreePrinter'!
AccountReport class
	instanceVariableNames: ''!

!AccountReport class methodsFor: 'instance creation' stamp: 'LR 10/28/2019 13:55:13'!
for: anAccount

	^ self new initializeFor: anAccount! !


!classDefinition: #SummaryReport category: #'24-PortfolioTreePrinter'!
AccountReport subclass: #SummaryReport
	instanceVariableNames: 'buffer'
	classVariableNames: ''
	poolDictionaries: ''
	category: '24-PortfolioTreePrinter'!

!SummaryReport methodsFor: 'reporting' stamp: 'LR 10/28/2019 16:50:04'!
evaluateDeposit: aDeposit on: aBuffer
	
	aBuffer add: ('Depósito por ', aDeposit value asString, '.').! !

!SummaryReport methodsFor: 'reporting' stamp: 'LR 10/28/2019 16:49:34'!
evaluateIncomingTransfer: anIncomingTransfer on: aBuffer
	
	aBuffer add: ('Entrada por transferencia de ', anIncomingTransfer value asString, '.').! !

!SummaryReport methodsFor: 'reporting' stamp: 'LR 10/28/2019 16:49:43'!
evaluateOutgoingTransfer: anOutgoingTransfer on: aBuffer	
	
	aBuffer add: ('Salida por transferencia de ', anOutgoingTransfer value asString, '.').! !

!SummaryReport methodsFor: 'reporting' stamp: 'LR 10/28/2019 16:49:17'!
evaluateWithdraw: aWithdraw on: aBuffer
	
	aBuffer add: ('Extracción por ', aWithdraw value asString, '.').! !

!SummaryReport methodsFor: 'reporting' stamp: 'LR 10/28/2019 16:53:04'!
print
	
	^ String streamContents: [ :stream |
		account write: self on: buffer.
		
		buffer do: [ :aLine |
			stream
				nextPutAll: aLine;
				cr.
		].
	
		stream
			nextPutAll: ('Balance = ', account balance asString);
			cr.
	]
	! !


!SummaryReport methodsFor: 'initialization' stamp: 'LR 10/28/2019 16:45:13'!
initialize

	buffer := OrderedCollection new.! !


!classDefinition: #TransferNetReport category: #'24-PortfolioTreePrinter'!
AccountReport subclass: #TransferNetReport
	instanceVariableNames: 'buffer'
	classVariableNames: ''
	poolDictionaries: ''
	category: '24-PortfolioTreePrinter'!

!TransferNetReport methodsFor: 'printing' stamp: 'LR 10/28/2019 16:43:15'!
print
	
	^ String streamContents: [ :stream |
		| transferNetBalance |
		
		account write: self on: buffer.
		transferNetBalance := buffer sum: [ :aValue | aValue ] ifEmpty: [ 0 ].
		
		stream
			nextPutAll: ('Neto de transferencias = ', transferNetBalance asString);
			cr.
	]
	! !


!TransferNetReport methodsFor: 'reporting' stamp: 'LR 10/28/2019 16:33:15'!
evaluateDeposit: aDeposit on: aBuffer

	! !

!TransferNetReport methodsFor: 'reporting' stamp: 'LR 10/28/2019 16:32:13'!
evaluateIncomingTransfer: anIncomingTransfer on: aBuffer
	
	aBuffer add: anIncomingTransfer value.! !

!TransferNetReport methodsFor: 'reporting' stamp: 'LR 10/28/2019 16:33:38'!
evaluateOutgoingTransfer: anOutgoingTransfer on: aBuffer
	
	aBuffer add: anOutgoingTransfer value negated.! !

!TransferNetReport methodsFor: 'reporting' stamp: 'LR 10/28/2019 16:33:22'!
evaluateWithdraw: aWithdraw on: aBuffer

	! !


!TransferNetReport methodsFor: 'initialization' stamp: 'LR 10/28/2019 16:34:19'!
initialize

	buffer := OrderedCollection new.! !


!classDefinition: #AccountTransaction category: #'24-PortfolioTreePrinter'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '24-PortfolioTreePrinter'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'reporting' stamp: 'LR 10/28/2019 16:23:27'!
write: anAccountReport on: aWriteStream

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'24-PortfolioTreePrinter'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'LR 10/27/2019 20:56:54'!
for: aValue

	^ self new initializeFor: aValue! !

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'24-PortfolioTreePrinter'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: '24-PortfolioTreePrinter'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'reporting' stamp: 'LR 10/28/2019 16:41:41'!
write: anAccountReport on: aBuffer

	^ anAccountReport evaluateDeposit: self on: aBuffer.! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'24-PortfolioTreePrinter'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #IncomingTransfer category: #'24-PortfolioTreePrinter'!
AccountTransaction subclass: #IncomingTransfer
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: '24-PortfolioTreePrinter'!

!IncomingTransfer methodsFor: 'balance' stamp: 'LR 10/27/2019 19:44:11'!
affectBalance: aBalance

	^ aBalance + transfer value! !


!IncomingTransfer methodsFor: 'value' stamp: 'LR 10/21/2019 21:00:14'!
value

	^ transfer value! !


!IncomingTransfer methodsFor: 'accesing' stamp: 'LR 10/27/2019 20:28:06'!
outgoingTransfer

	^ transfer outgoingTransfer! !


!IncomingTransfer methodsFor: 'reporting' stamp: 'LR 10/28/2019 16:41:35'!
write: anAccountReport on: aBuffer

	^ anAccountReport evaluateIncomingTransfer: self on: aBuffer.! !


!IncomingTransfer methodsFor: 'initialization' stamp: 'LR 10/27/2019 20:26:05'!
initializeFor: aTransfer

	transfer := aTransfer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IncomingTransfer class' category: #'24-PortfolioTreePrinter'!
IncomingTransfer class
	instanceVariableNames: ''!

!IncomingTransfer class methodsFor: 'instance creation' stamp: 'LR 10/21/2019 21:12:23'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #OutgoingTransfer category: #'24-PortfolioTreePrinter'!
AccountTransaction subclass: #OutgoingTransfer
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: '24-PortfolioTreePrinter'!

!OutgoingTransfer methodsFor: 'value' stamp: 'LR 10/27/2019 20:26:57'!
value

	^ transfer value! !


!OutgoingTransfer methodsFor: 'balance' stamp: 'LR 10/27/2019 20:27:07'!
affectBalance: aBalance

	^ aBalance - transfer value! !


!OutgoingTransfer methodsFor: 'accessing' stamp: 'LR 10/21/2019 21:23:42'!
incomingTransfer

	^ transfer incomingTransfer! !


!OutgoingTransfer methodsFor: 'reporting' stamp: 'LR 10/28/2019 16:41:29'!
write: anAccountReport on: aBuffer

	^ anAccountReport evaluateOutgoingTransfer: self on: aBuffer.! !


!OutgoingTransfer methodsFor: 'initialization' stamp: 'LR 10/27/2019 20:28:38'!
initializeFor: aTransfer

	transfer := aTransfer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OutgoingTransfer class' category: #'24-PortfolioTreePrinter'!
OutgoingTransfer class
	instanceVariableNames: ''!

!OutgoingTransfer class methodsFor: 'instance creation' stamp: 'LR 10/21/2019 21:12:26'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'24-PortfolioTreePrinter'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: '24-PortfolioTreePrinter'!

!Withdraw methodsFor: 'initialization' stamp: 'LR 10/21/2019 21:14:42'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'reporting' stamp: 'LR 10/28/2019 16:41:22'!
write: anAccountReport on: aBuffer

	^ anAccountReport evaluateWithdraw: self on: aBuffer.! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'24-PortfolioTreePrinter'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Transfer category: #'24-PortfolioTreePrinter'!
Object subclass: #Transfer
	instanceVariableNames: 'value outgoingTransfer incomingTransfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: '24-PortfolioTreePrinter'!

!Transfer methodsFor: 'initialization' stamp: 'LR 10/28/2019 13:25:06'!
initializeFrom: aSenderAccount to: aReceiverAccount forValue: aValue 
	
	value := aValue.
	
	incomingTransfer := IncomingTransfer for: self.
	outgoingTransfer := OutgoingTransfer for: self.
	
	aSenderAccount register: outgoingTransfer.
	aReceiverAccount register: incomingTransfer.! !


!Transfer methodsFor: 'accessing' stamp: 'LR 10/27/2019 22:28:45'!
incomingTransfer

	^ incomingTransfer! !

!Transfer methodsFor: 'accessing' stamp: 'LR 10/27/2019 22:28:38'!
outgoingTransfer

	^ outgoingTransfer! !


!Transfer methodsFor: 'value' stamp: 'LR 10/27/2019 22:27:07'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: #'24-PortfolioTreePrinter'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'LR 10/28/2019 13:44:22'!
newFrom: aSenderAccount to: aReceiverAccount forValue: aValue
	
	aValue isZero ifTrue: [ self error: self cannotTransferAZeroValueErrorDescription ].
	aValue negative ifTrue: [ self error: self cannotTransferANegativeValueErrorDescription ].
	(aSenderAccount = aReceiverAccount) ifTrue: [ self error: self cannotTransferBetweenSameAccountErrorDescription ].
	
	^ self new initializeFrom: aSenderAccount to: aReceiverAccount forValue: aValue! !


!Transfer class methodsFor: 'error descriptions' stamp: 'LR 10/28/2019 13:36:12'!
cannotTransferANegativeValueErrorDescription
	
	^ 'Cannot make a transference with a negative value'! !

!Transfer class methodsFor: 'error descriptions' stamp: 'LR 10/28/2019 13:34:20'!
cannotTransferAZeroValueErrorDescription
	
	^ 'Cannot make a transference with value 0'! !

!Transfer class methodsFor: 'error descriptions' stamp: 'LR 10/28/2019 13:38:39'!
cannotTransferBetweenSameAccountErrorDescription
	
	^ 'Cannot make a transference between the same account'! !
