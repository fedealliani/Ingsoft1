!classDefinition: #CartTest category: #TusLibros stamp: 'LR 11/18/2019 10:13:14'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibros stamp: 'LR 11/18/2019 10:13:14'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #InnerFaceTest category: #TusLibros stamp: 'LR 11/18/2019 10:13:14'!
TestCase subclass: #InnerFaceTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InnerFaceTest methodsFor: 'tests' stamp: 'LR 11/11/2019 18:00:28'!
test01CannotCreateACartWithInvalidCredentials

	| clientID innerFace password |
	innerFace := InnerFace new.
	
	clientID := 'an invalid ID'.
	password := 'an invalid password'.
	
	self 
		should: [ innerFace createCartFor: clientID withPassword: password. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = InnerFace invalidCredentialsErrorMessage. ]! !

!InnerFaceTest methodsFor: 'tests' stamp: 'LR 11/11/2019 19:25:44'!
test02CreatingTwoCartsWithTwoValidUsersReturnsDifferentCartIDs

	| innerFace cartID1 cartID2 |
	
	innerFace := testObjectsFactory createInnerFace.
	
	cartID1 := innerFace createCartFor: testObjectsFactory client1ID withPassword: testObjectsFactory password1.
	cartID2 := innerFace createCartFor: testObjectsFactory client2ID withPassword: testObjectsFactory password2.

	self assert: (cartID1 ~= cartID2).! !

!InnerFaceTest methodsFor: 'tests' stamp: 'LR 11/11/2019 19:26:02'!
test03CreatingTwoCartsWithOneValidUsersReturnsDifferentCartIDs

	| innerFace cartID1 cartID2 |
	
	innerFace := testObjectsFactory createInnerFace.
	
	cartID1 := innerFace createCartFor: testObjectsFactory client1ID withPassword: testObjectsFactory password1.
	cartID2 := innerFace createCartFor: testObjectsFactory client1ID withPassword: testObjectsFactory password1.

	self assert: (cartID1 ~= cartID2).! !

!InnerFaceTest methodsFor: 'tests' stamp: 'LR 11/11/2019 19:26:09'!
test04ListingANewCartReturnsAnEmptyDictionary

	| innerFace cartID1 |
	
	innerFace := testObjectsFactory createInnerFace.
	
	cartID1 := innerFace createCartFor: testObjectsFactory client1ID withPassword: testObjectsFactory password1.
	
	self assert: Dictionary new equals: (innerFace listCart: cartID1).! !

!InnerFaceTest methodsFor: 'tests' stamp: 'LR 11/11/2019 19:30:04'!
test05ListingACartWithOneBookAddedReturnsADictionaryWithTheISBNOfThatBookAndAnAmmountOfOne

	| innerFace cartID1 |
	
	innerFace := testObjectsFactory createInnerFace.
	
	cartID1 := innerFace createCartFor: testObjectsFactory client1ID withPassword: testObjectsFactory password1.
	
	innerFace add: 1 of: testObjectsFactory itemSellByTheStore to: cartID1.
	
	self assert: (Dictionary newFromPairs: {'validBook' . 1 }) equals: (innerFace listCart: cartID1).! !

!InnerFaceTest methodsFor: 'tests' stamp: 'LR 11/14/2019 17:29:19'!
test06CannotAddBookToANonExistentCart

	| innerFace |
	
	innerFace := testObjectsFactory createInnerFace.
	
	self 
		should: [ innerFace add: 1 of: testObjectsFactory itemSellByTheStore to: '123123'. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = InnerFace nonExistentCartErrorMessage. ]! !

!InnerFaceTest methodsFor: 'tests' stamp: 'LR 11/14/2019 17:35:28'!
test07ListingPurchasesOfAClientWithoutAnyPurchaseReturnsAnEmptyDictionaryAndZeroAsTotalAmount

	| innerFace |
	
	innerFace := testObjectsFactory createInnerFace.
	
	self 
		should: [ innerFace add: 1 of: testObjectsFactory itemSellByTheStore to: '123123'. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = InnerFace nonExistentCartErrorMessage. ]! !


!InnerFaceTest methodsFor: 'setup' stamp: 'LR 11/11/2019 19:24:41'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #Cart category: #TusLibros stamp: 'LR 11/18/2019 10:13:14'!
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


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

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


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'accessing' stamp: 'LR 11/11/2019 18:59:49'!
items

	^ items copy.! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros stamp: 'LR 11/18/2019 10:13:14'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros stamp: 'LR 11/18/2019 10:13:14'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:07'!
createSale

	^ Sale of: total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros stamp: 'LR 11/18/2019 10:13:14'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: #TusLibros stamp: 'LR 11/18/2019 10:13:14'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros stamp: 'LR 11/18/2019 10:13:14'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #InnerFace category: #TusLibros stamp: 'LR 11/18/2019 10:13:14'!
Object subclass: #InnerFace
	instanceVariableNames: 'usersToPassword cartIDsToCart lastCartID catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InnerFace methodsFor: 'actions' stamp: 'LR 11/14/2019 17:30:57'!
add: aQuantity of: anItem to: aCartID

	cartIDsToCart at: aCartID ifAbsent: [ self error: self class nonExistentCartErrorMessage ].
	(cartIDsToCart at: aCartID) add: aQuantity of: anItem.! !

!InnerFace methodsFor: 'actions' stamp: 'LR 11/11/2019 19:14:41'!
createCartFor: aClientId withPassword: aPassword

	| realPassword |
	realPassword := usersToPassword at: aClientId ifAbsent: [ self error: self class invalidCredentialsErrorMessage ].
	(realPassword = aPassword) ifFalse: [ self error: self class invalidCredentialsErrorMessage ].
	
	lastCartID := lastCartID + 1.
	
	cartIDsToCart at: lastCartID put: (Cart acceptingItemsOf: catalog).
	
	^ lastCartID.

	
	! !


!InnerFace methodsFor: 'initialization' stamp: 'LR 11/11/2019 19:14:56'!
initialize

	usersToPassword := Dictionary new.
	catalog := Dictionary new.
	cartIDsToCart := Dictionary new.
	lastCartID := 0.! !

!InnerFace methodsFor: 'initialization' stamp: 'LR 11/11/2019 19:29:36'!
initializeWithUsers: aUsersToPasswordDictionary andCatalog: aCatalog 

	self initialize.
	usersToPassword := aUsersToPasswordDictionary.
	catalog := aCatalog.! !


!InnerFace methodsFor: 'accessing' stamp: 'LR 11/11/2019 19:11:24'!
listCart: aCartID 
	
	| cartSummary |
	cartSummary := Dictionary new.
	
	(cartIDsToCart at: aCartID) items do: [ :anISBN |
		cartSummary at: anISBN put: (cartSummary at: anISBN ifAbsentPut: 0) + 1.
	].
	
	^cartSummary.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InnerFace class' category: #TusLibros stamp: 'LR 11/18/2019 10:13:14'!
InnerFace class
	instanceVariableNames: ''!

!InnerFace class methodsFor: 'error descriptions' stamp: 'LR 11/11/2019 18:01:50'!
invalidCredentialsErrorMessage
	
	^ 'Invalid credentials'! !

!InnerFace class methodsFor: 'error descriptions' stamp: 'LR 11/14/2019 17:29:43'!
nonExistentCartErrorMessage
	
	^ 'Non existent cart'! !


!InnerFace class methodsFor: 'instance creation' stamp: 'LR 11/11/2019 19:17:03'!
createWithUsers: aUsersToPasswordDictionary andCatalog: aCatalog 

	^self new initializeWithUsers: aUsersToPasswordDictionary andCatalog: aCatalog.! !


!classDefinition: #Sale category: #TusLibros stamp: 'LR 11/18/2019 10:13:14'!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros stamp: 'LR 11/18/2019 10:13:14'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros stamp: 'LR 11/18/2019 10:13:14'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'innerface' stamp: 'LR 11/11/2019 19:22:08'!
client1ID
	
	^ 'valid client ID 1'! !

!StoreTestObjectsFactory methodsFor: 'innerface' stamp: 'LR 11/11/2019 19:22:12'!
client2ID
	
	^ 'valid client ID 2'! !

!StoreTestObjectsFactory methodsFor: 'innerface' stamp: 'LR 11/11/2019 19:28:02'!
createInnerFace
	
	^InnerFace createWithUsers: self defaultUsers andCatalog: self defaultCatalog.! !

!StoreTestObjectsFactory methodsFor: 'innerface' stamp: 'LR 11/11/2019 19:28:32'!
defaultUsers
	
	^ Dictionary new
		at: self client1ID put: self password1;
		at: self client2ID put: self password2;
		yourself! !

!StoreTestObjectsFactory methodsFor: 'innerface' stamp: 'LR 11/11/2019 19:22:39'!
password1
	
	^ 'valid client password 1'! !

!StoreTestObjectsFactory methodsFor: 'innerface' stamp: 'LR 11/11/2019 19:22:41'!
password2
	
	^ 'valid client password 2'! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
