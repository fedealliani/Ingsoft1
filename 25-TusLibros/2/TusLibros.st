!classDefinition: #CartTest category: #TusLibros stamp: 'FA 11/6/2019 23:29:12'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'FA 11/6/2019 22:35:13'!
defaultCatalog
	
	^  Dictionary newFromPairs: {self itemSellByTheStore . 25*peso}.! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: #TusLibros stamp: 'FA 11/6/2019 23:29:12'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'support' stamp: 'FA 11/6/2019 20:30:37'!
anotherItemSellByTheStore
	
	^ 'validBook2'! !

!CashierTest methodsFor: 'support' stamp: 'FA 11/4/2019 20:01:01'!
createCart
	
	^ self createEmptyCart add:self itemSellByTheStore.! !

!CashierTest methodsFor: 'support' stamp: 'FA 11/4/2019 19:59:22'!
createEmptyCart
	
	^ Cart acceptingItemsOf: self defaultCatalog.! !

!CashierTest methodsFor: 'support' stamp: 'FA 11/4/2019 20:04:49'!
createExpiredCreditCard
	
	^ CreditCard of: 'Pepe' withNumber:'1234567812345678'  expiring:(GregorianMonthOfYear yearNumber: 1 monthNumber:1) .! !

!CashierTest methodsFor: 'support' stamp: 'FA 11/4/2019 20:02:58'!
createValidCreditCard
	
	^ CreditCard of: 'Pepe' withNumber:'1234567812345678'  expiring:GregorianMonthOfYear current .! !

!CashierTest methodsFor: 'support' stamp: 'FA 11/6/2019 21:24:32'!
defaultCatalog
	
	^ Dictionary newFromPairs: {self itemSellByTheStore . 25*peso . self anotherItemSellByTheStore . 17.5*peso}.! !

!CashierTest methodsFor: 'support' stamp: 'FA 11/4/2019 19:58:23'!
itemSellByTheStore
	
	^ 'validBook'! !


!CashierTest methodsFor: 'tests' stamp: 'FA 11/6/2019 22:46:53'!
test01CashierCannotCheckoutAnEmptyCart
	|cashier salesBook| 
	
	cashier := Cashier createWithCatalog:self defaultCatalog .
	salesBook := OrderedCollection  new.
	self 
		should: [ cashier checkout: (self createEmptyCart)  registeringOn: salesBook withCreditCard: self createValidCreditCard ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cannotCheckoutAnEmptyCartErrorMessage.
			self assert: salesBook isEmpty.
			 ]


	! !

!CashierTest methodsFor: 'tests' stamp: 'FA 11/6/2019 22:47:02'!
test02CashierCannotCheckoutWithAnExpiredCreditCard
	|cashier salesBook| 
	
	cashier := Cashier createWithCatalog:self defaultCatalog .
	salesBook := OrderedCollection  new.
	
	self 
		should: [ cashier checkout: self createCart registeringOn: salesBook withCreditCard:(self createExpiredCreditCard)]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cannotCheckoutWithAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty.
			 ]


	! !

!CashierTest methodsFor: 'tests' stamp: 'FA 11/6/2019 22:47:05'!
test03AfterCheckoutSalesBookContainsThisPurchase
	|cashier salesBook purchase| 
	
	cashier := Cashier createWithCatalog:self defaultCatalog .
	salesBook := OrderedCollection  new.
	purchase := cashier checkout: self createCart registeringOn: salesBook withCreditCard:(self createValidCreditCard).
	self assert: salesBook includes: purchase.
	self assert: 1 equals: salesBook size .


	! !

!CashierTest methodsFor: 'tests' stamp: 'FA 11/6/2019 22:47:07'!
test04AfterCheckoutACartWithOneProductTheTicketAmountIsEqualToThePriceOfThatProductAccordingToCatalogue
	|cashier salesBook purchase cart| 
	
	cashier := Cashier createWithCatalog:self defaultCatalog .
	salesBook := OrderedCollection  new.
	cart := self createCart.
	purchase := cashier checkout: cart registeringOn: salesBook withCreditCard:(self createValidCreditCard).
	
	self assert:25*peso equals: (purchase amount).


	! !

!CashierTest methodsFor: 'tests' stamp: 'FA 11/6/2019 21:10:08'!
test05TheCalculatedPriceByCashierForACartWithOneProductIsEqualToThePriceOfThatProductAccordingToCatalogue
	|cashier cart| 
	
	cashier := Cashier createWithCatalog:self defaultCatalog .
	cart := self createCart.
	self assert: 25*peso equals:  (cashier priceOf: cart).


	! !

!CashierTest methodsFor: 'tests' stamp: 'FA 11/6/2019 22:43:51'!
test06TheCalculatedPriceByCashierForACartWithTwoProductIsEqualToThePriceOfTheSumOfThoseProductsAccordingToCatalogue
	|cashier cart| 
	
	cashier := Cashier createWithCatalog:self defaultCatalog .
	cart := self createCart.
	cart add:1 of:self anotherItemSellByTheStore.
	self assert: 42.5*peso equals:  (cashier priceOf: cart).


	! !

!CashierTest methodsFor: 'tests' stamp: 'FA 11/6/2019 22:47:14'!
test07AfterCheckoutACartWithTwoProductsTheTicketAmountIsEqualToThePriceOfTheSumOfThoseProductsAccordingToCatalogue
	|cashier salesBook purchase cart| 
	
	cashier := Cashier createWithCatalog:self defaultCatalog .
	salesBook := OrderedCollection  new.
	cart := self createCart.
	cart add:1 of:self anotherItemSellByTheStore.
	
	purchase := cashier checkout: cart registeringOn: salesBook withCreditCard:(self createValidCreditCard).
	
	self assert:42.5*peso equals: (purchase amount).


	! !


!classDefinition: #CreditCardTest category: #TusLibros stamp: 'FA 11/6/2019 23:29:12'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'testing' stamp: 'FA 11/6/2019 23:00:27'!
test01CannotCreateACreditCardThatDoesNotHave16DigitInItsNumber
	
	self 
		should: [ CreditCard of: 'Pepito' withNumber:'12345678123456789'  expiring: (GregorianMonthOfYear current) ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = CreditCard cannotCreateACreditCardThatDoesNotHave16DigitInItsNumberErrorDescription.
			 ]

! !

!CreditCardTest methodsFor: 'testing' stamp: 'FA 11/6/2019 23:21:03'!
test02ACreditCardWithAnExpiredDateBeforeCurrentDateIsExpired
	
	| creditCard |
	creditCard := CreditCard of: 'Pepito' withNumber:'1234567812345678'  expiring: (GregorianMonthOfYear yearNumber: 1900 monthNumber:1 ) .
	self assert: creditCard isExpired.

! !

!CreditCardTest methodsFor: 'testing' stamp: 'FA 11/6/2019 23:23:22'!
test03CannotCreateACreditCardThatHaveAnEmptyName
	
	self 
		should: [ CreditCard of: '' withNumber:'1234567812345678'  expiring: (GregorianMonthOfYear current) ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = CreditCard cannotCreateACreditCardThatHaveAnEmptyNameErrorDescription.
			 ]

! !


!classDefinition: #Cart category: #TusLibros stamp: 'FA 11/6/2019 23:29:12'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'FA 11/6/2019 22:38:12'!
assertIsValidItem: anItem

	catalog at: anItem ifAbsent:[ self error: self invalidItemErrorMessage ].! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'FA 11/6/2019 22:36:21'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'nil' stamp: 'FA 11/6/2019 21:16:51'!
items
	^items.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros stamp: 'FA 11/6/2019 23:29:12'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros stamp: 'FA 11/6/2019 23:29:12'!
Object subclass: #Cashier
	instanceVariableNames: 'catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'actions' stamp: 'FA 11/6/2019 23:27:11'!
checkout: aCart registeringOn: aSalesBook withCreditCard: aCreditCard  
	| ticket priceOfCart |
	aCreditCard isExpired ifTrue:[self error: self class cannotCheckoutWithAnExpiredCreditCardErrorMessage .].
	aCart isEmpty ifTrue:[ self error: self class cannotCheckoutAnEmptyCartErrorMessage.].
	priceOfCart := self priceOf: aCart.
	(MerchantProcessor new) debit:priceOfCart withCard:aCreditCard.
	ticket := Ticket for:priceOfCart withCart:aCart paidWith:aCreditCard.
	aSalesBook add: ticket .
	^ticket.
	
	! !

!Cashier methodsFor: 'actions' stamp: 'FA 11/6/2019 22:38:54'!
priceOf: aCart 
	^(aCart items) inject:0*peso  into:[:totalPrice :item | totalPrice + (catalog at:item)].! !


!Cashier methodsFor: 'initialization' stamp: 'FA 11/6/2019 21:07:27'!
initializeCreateWithCatalog: aCatalog 
	catalog := aCatalog.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros stamp: 'FA 11/6/2019 23:29:12'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error descriptions' stamp: 'FA 11/4/2019 19:23:06'!
cannotCheckoutAnEmptyCartErrorMessage
	^ 'Cannot checkout an empty cart'! !

!Cashier class methodsFor: 'error descriptions' stamp: 'FA 11/4/2019 19:44:06'!
cannotCheckoutWithAnExpiredCreditCardErrorMessage
	^'Cannot checkout with an expired credit card'! !


!Cashier class methodsFor: 'instance creation' stamp: 'FA 11/6/2019 21:07:07'!
createWithCatalog: aCatalog 
	^self new initializeCreateWithCatalog: aCatalog ! !


!classDefinition: #CreditCard category: #TusLibros stamp: 'FA 11/6/2019 23:29:12'!
Object subclass: #CreditCard
	instanceVariableNames: 'ownerName creditCardNumber gregorianMonthOfYear'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'FA 11/6/2019 23:24:10'!
initializeFor: anOwnerName withNumber: aCreditCardNumber expiring: aGregorianMonthOfYear
	aCreditCardNumber size = 16 ifFalse: [self error: self class cannotCreateACreditCardThatDoesNotHave16DigitInItsNumberErrorDescription.].
	anOwnerName isEmpty ifTrue: [self error: self class cannotCreateACreditCardThatHaveAnEmptyNameErrorDescription.].
	ownerName := anOwnerName.
	creditCardNumber := aCreditCardNumber.
	gregorianMonthOfYear := aGregorianMonthOfYear.! !


!CreditCard methodsFor: 'testing' stamp: 'FA 11/4/2019 19:52:08'!
isExpired
	^(GregorianMonthOfYear current distanceTo: gregorianMonthOfYear) negative.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros stamp: 'FA 11/6/2019 23:29:12'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'FA 11/4/2019 19:39:49'!
of: anOwnerName withNumber: aCreditCardNumber expiring: aGregorianMonthOfYear 
	
	^self new initializeFor: anOwnerName withNumber: aCreditCardNumber expiring: aGregorianMonthOfYear ! !


!CreditCard class methodsFor: 'error description' stamp: 'FA 11/6/2019 23:17:09'!
cannotCreateACreditCardThatDoesNotHave16DigitInItsNumberErrorDescription
	^'Cannot create a credit card that does not have16 digit in its number error description'.! !

!CreditCard class methodsFor: 'error description' stamp: 'FA 11/6/2019 23:25:04'!
cannotCreateACreditCardThatHaveAnEmptyNameErrorDescription
	^ 'cannot create a credit card that have an empty name'.! !


!classDefinition: #MerchantProcessor category: #TusLibros stamp: 'FA 11/6/2019 23:29:12'!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessor methodsFor: 'action' stamp: 'FA 11/6/2019 23:28:32'!
debit: aPrice withCard:aCreditCard! !


!classDefinition: #Ticket category: #TusLibros stamp: 'FA 11/6/2019 23:29:12'!
Object subclass: #Ticket
	instanceVariableNames: 'amount cart creditCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Ticket methodsFor: 'initialization' stamp: 'FA 11/6/2019 20:45:51'!
initializeFor: anAmount withCart: aCart paidWith: aCreditCard 
	amount := anAmount.
	cart := aCart.
	creditCard := aCreditCard.! !


!Ticket methodsFor: 'accessing' stamp: 'FA 11/6/2019 20:46:32'!
amount
	^ amount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Ticket class' category: #TusLibros stamp: 'FA 11/6/2019 23:29:12'!
Ticket class
	instanceVariableNames: ''!

!Ticket class methodsFor: 'instance creation' stamp: 'FA 11/6/2019 20:46:03'!
for: anAmount withCart: aCart paidWith: aCreditCard 
	
	^self new initializeFor: anAmount withCart: aCart paidWith: aCreditCard ! !
