!classDefinition: #CartTest category: #TusLibros!
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


!classDefinition: #CashierTest category: #TusLibros!
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


!classDefinition: #InnerFaceTest category: #TusLibros!
TestCase subclass: #InnerFaceTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
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

!InnerFaceTest methodsFor: 'tests' stamp: 'FA 11/18/2019 10:31:44'!
test07ListingPurchasesOfAClientWithoutAnyPurchaseReturnsAnEmptyDictionaryAndZeroAsTotalAmount

	| innerFace |
	
	innerFace := testObjectsFactory createInnerFace.
	
	self assert: (Dictionary newFromPairs: {'total_amount' . 0 }) equals: (innerFace listPurchasesOf: testObjectsFactory client1ID withPassword: testObjectsFactory password1).! !

!InnerFaceTest methodsFor: 'tests' stamp: 'FA 11/18/2019 10:34:18'!
test08CannotListPurchasesOfAClientWithInvalidCredentials

	| clientID innerFace password |
	innerFace := InnerFace new.
	
	clientID := 'an invalid ID'.
	password := 'an invalid password'.
	
	self 
		should: [ innerFace listPurchasesOf: clientID  withPassword:password. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = InnerFace invalidCredentialsErrorMessage. ]! !

!InnerFaceTest methodsFor: 'tests' stamp: 'FA 11/18/2019 11:02:40'!
test09ListingPurchasesOfAClientWithOnePurchaseReturnsADictionaryContainingQuantityForEveryBookInThePurchaseAndTotalAmountPaidForUser

	| innerFace cartID1 |
	
	innerFace := testObjectsFactory createInnerFace.
	
	cartID1 := innerFace createCartFor: testObjectsFactory client1ID withPassword: testObjectsFactory password1.
	
	innerFace add: 1 of: testObjectsFactory itemSellByTheStore to: cartID1.
	
	innerFace checkoutCart: cartID1 withCreditCard: testObjectsFactory notExpiredCreditCard.
	
	self assert: (Dictionary newFromPairs: {'validBook' . 1 . 'total_amount' . 10 }) equals: (innerFace listPurchasesOf: testObjectsFactory client1ID withPassword: testObjectsFactory password1).! !

!InnerFaceTest methodsFor: 'tests' stamp: 'FA 11/18/2019 11:16:27'!
test10CannotListCartWithAnInvalidCartID

	| innerFace |
	
	innerFace := testObjectsFactory createInnerFace.
	self 
		should: [ innerFace listCart: 'invalidCartID'.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = InnerFace nonExistentCartErrorMessage. ]
	! !

!InnerFaceTest methodsFor: 'tests' stamp: 'FA 11/18/2019 11:51:53'!
test11CannotAddBooksAfter30MinutesWithoutAnyActionOnTheCart

	| innerFace cartID1 |
	
	innerFace := testObjectsFactory createInnerFace.
	cartID1 := innerFace createCartFor: testObjectsFactory client1ID withPassword: testObjectsFactory password1.
	innerFace passTime: (Duration minutes:30).
	self 
		should: [ innerFace add: 1 of: testObjectsFactory itemSellByTheStore to: cartID1 .]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = InnerFace expiredCartErrorMessage. ]
	
	! !

!InnerFaceTest methodsFor: 'tests' stamp: 'FA 11/18/2019 12:09:10'!
test12CannotListCartAfter30MinutesWithoutAnyActionOnTheCart

	| innerFace cartID1 |
	
	innerFace := testObjectsFactory createInnerFace.
	cartID1 := innerFace createCartFor: testObjectsFactory client1ID withPassword: testObjectsFactory password1.
	innerFace passTime: (Duration minutes:30).
	self 
		should: [ innerFace listCart: cartID1.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = InnerFace expiredCartErrorMessage. ]
	
	! !

!InnerFaceTest methodsFor: 'tests' stamp: 'FA 11/18/2019 12:10:51'!
test13CannotCheckoutCartAfter30MinutesWithoutAnyActionOnTheCart

	| innerFace cartID1 |
	
	innerFace := testObjectsFactory createInnerFace.
	cartID1 := innerFace createCartFor: testObjectsFactory client1ID withPassword: testObjectsFactory password1.
	innerFace passTime: (Duration minutes:30).
	self 
		should: [ innerFace checkoutCart: cartID1 withCreditCard: testObjectsFactory notExpiredCreditCard .]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = InnerFace expiredCartErrorMessage. ]
	
	! !

!InnerFaceTest methodsFor: 'tests' stamp: 'FA 11/18/2019 12:15:48'!
test14AddToCartResetExpirationTimeOfCart

	| innerFace cartID1 |
	
	innerFace := testObjectsFactory createInnerFace.
	cartID1 := innerFace createCartFor: testObjectsFactory client1ID withPassword: testObjectsFactory password1.
	innerFace passTime: (Duration minutes:29).
	innerFace add: 1 of: testObjectsFactory itemSellByTheStore to: cartID1.
	innerFace passTime: (Duration minutes:29).
	innerFace add: 1 of: testObjectsFactory itemSellByTheStore to: cartID1.
	
	self assert: (Dictionary newFromPairs: {'validBook' . 2 }) equals: (innerFace listCart: cartID1).
	
	
	! !

!InnerFaceTest methodsFor: 'tests' stamp: 'FA 11/18/2019 12:20:25'!
test15ListCartResetExpirationTimeOfCart

	| innerFace cartID1 |
	
	innerFace := testObjectsFactory createInnerFace.
	cartID1 := innerFace createCartFor: testObjectsFactory client1ID withPassword: testObjectsFactory password1.
	innerFace passTime: (Duration minutes:29).
	innerFace listCart: cartID1.
	innerFace passTime: (Duration minutes:29).
	
	self assert: (Dictionary new) equals: (innerFace listCart: cartID1).
	
	
	! !

!InnerFaceTest methodsFor: 'tests' stamp: 'FA 11/18/2019 12:56:11'!
test16CheckoutAValidCartReturnASalePrice

	| innerFace cartID1 |
	
	innerFace := testObjectsFactory createInnerFace.
	cartID1 := innerFace createCartFor: testObjectsFactory client1ID withPassword: testObjectsFactory password1.
	innerFace add: 3 of: testObjectsFactory itemSellByTheStore to: cartID1.
	
	self assert: 30 equals: (innerFace checkoutCart: cartID1 withCreditCard: testObjectsFactory notExpiredCreditCard).
	
	
	! !

!InnerFaceTest methodsFor: 'tests' stamp: 'FA 11/18/2019 13:02:40'!
test17CannotCheckoutAnInvalidCart

	| innerFace |
	
	innerFace := testObjectsFactory createInnerFace.
	self 
		should: [ (innerFace checkoutCart: 'an invalid cart id' withCreditCard: testObjectsFactory notExpiredCreditCard).]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = InnerFace nonExistentCartErrorMessage . ]
		
	
	! !

!InnerFaceTest methodsFor: 'tests' stamp: 'FA 11/18/2019 14:45:23'!
test18CannotCheckoutAnAlreadyCheckoutedCart

	| innerFace cartID1 |
	
	innerFace := testObjectsFactory createInnerFace.
	cartID1 := innerFace createCartFor: testObjectsFactory client1ID withPassword: testObjectsFactory password1.
	innerFace add: 3 of: testObjectsFactory itemSellByTheStore to: cartID1.
	(innerFace checkoutCart: cartID1 withCreditCard: testObjectsFactory notExpiredCreditCard).
	self 
		should: [ (innerFace checkoutCart: cartID1 withCreditCard: testObjectsFactory notExpiredCreditCard).]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = InnerFace cartAlreadyCheckoutedErrorMessage . ]
		
	
	! !

!InnerFaceTest methodsFor: 'tests' stamp: 'FA 11/18/2019 14:56:50'!
test19CannotAddAnItemToAnAlreadyCheckoutedCart

	| innerFace cartID1 |
	
	innerFace := testObjectsFactory createInnerFace.
	cartID1 := innerFace createCartFor: testObjectsFactory client1ID withPassword: testObjectsFactory password1.
	innerFace add: 3 of: testObjectsFactory itemSellByTheStore to: cartID1.
	(innerFace checkoutCart: cartID1 withCreditCard: testObjectsFactory notExpiredCreditCard).
	self 
		should: [ innerFace add: 3 of: testObjectsFactory itemSellByTheStore to: cartID1.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = InnerFace cartAlreadyCheckoutedErrorMessage . ]
		
	
	! !

!InnerFaceTest methodsFor: 'tests' stamp: 'FA 11/18/2019 14:58:17'!
test20CannotListCartToAnAlreadyCheckoutedCart
	"Este test paso de una, pero lo pusimos para que vean que contemplamos el caso."
	| innerFace cartID1 |
	
	innerFace := testObjectsFactory createInnerFace.
	cartID1 := innerFace createCartFor: testObjectsFactory client1ID withPassword: testObjectsFactory password1.
	innerFace add: 3 of: testObjectsFactory itemSellByTheStore to: cartID1.
	(innerFace checkoutCart: cartID1 withCreditCard: testObjectsFactory notExpiredCreditCard).
	self 
		should: [ innerFace listCart: cartID1.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = InnerFace cartAlreadyCheckoutedErrorMessage . ]
		
	
	! !

!InnerFaceTest methodsFor: 'tests' stamp: 'FA 11/18/2019 15:04:07'!
test21ListingPurchasesOfAClientWithTwoPurchasesReturnsADictionaryContainingQuantityForEveryBookInThePurchasesAndTotalAmountPaidForUser

	| innerFace cartID1 cartID2 |
	
	innerFace := testObjectsFactory createInnerFace.
	
	cartID1 := innerFace createCartFor: testObjectsFactory client1ID withPassword: testObjectsFactory password1.
	
	innerFace add: 1 of: testObjectsFactory itemSellByTheStore to: cartID1.
	
	innerFace checkoutCart: cartID1 withCreditCard: testObjectsFactory notExpiredCreditCard.

	cartID2 := innerFace createCartFor: testObjectsFactory client1ID withPassword: testObjectsFactory password1.
	
	innerFace add: 2 of: testObjectsFactory itemSellByTheStore to: cartID2.
	
	innerFace add: 10 of: testObjectsFactory anotherItemSellByTheStore to: cartID2.
	
	innerFace checkoutCart: cartID2 withCreditCard: testObjectsFactory notExpiredCreditCard.
		
	self assert: (Dictionary newFromPairs: {'validBook' . 3 . 'anotherValidBook' . 10. 'total_amount' . 80 }) equals: (innerFace listPurchasesOf: testObjectsFactory client1ID withPassword: testObjectsFactory password1).! !


!InnerFaceTest methodsFor: 'setup' stamp: 'FA 11/18/2019 12:54:36'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #Cart category: #TusLibros!
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

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros!
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

!classDefinition: 'Cashier class' category: #TusLibros!
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


!classDefinition: #CreditCard category: #TusLibros!
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

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #InnerFace category: #TusLibros!
Object subclass: #InnerFace
	instanceVariableNames: 'usersToPassword cartIDsToCart lastCartID catalog checkout passTime cartIDsToLastModifyTime cartIDsToClientID merchantProcessor salesBook clientIDsToPurchasedCartIDs'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InnerFace methodsFor: 'actions' stamp: 'FA 11/18/2019 13:04:10'!
add: aQuantity of: anItem to: aCartID

	self assertCartIsValid: aCartID.
	
	(cartIDsToCart at: aCartID) add: aQuantity of: anItem.
	self updateLastModifyTime:aCartID.! !

!InnerFace methodsFor: 'actions' stamp: 'FA 11/18/2019 12:06:06'!
assertCartIDExist: aCartID

	^ cartIDsToCart at: aCartID ifAbsent: [ self error: self class nonExistentCartErrorMessage ]! !

!InnerFace methodsFor: 'actions' stamp: 'FA 11/18/2019 14:51:57'!
assertCartIsNotCheckouted: aCartID
	| clientID cartIDs |
	clientID := cartIDsToClientID at:aCartID.
	cartIDs := clientIDsToPurchasedCartIDs at:clientID ifAbsentPut:[OrderedCollection new.].
	(cartIDs includes: aCartID) ifTrue:[self error: self class cartAlreadyCheckoutedErrorMessage].! !

!InnerFace methodsFor: 'actions' stamp: 'FA 11/18/2019 14:46:19'!
assertCartIsValid: aCartID

	self assertCartIDExist: aCartID.
	self assertCartIsNotExpired:aCartID.
	self assertCartIsNotCheckouted:aCartID.! !

!InnerFace methodsFor: 'actions' stamp: 'FA 11/18/2019 14:28:54'!
checkoutCart: aCartID withCreditCard: aCreditCard 
	| cart cashier clientID |
	
	self assertCartIsValid: aCartID.
	
	cart := cartIDsToCart at:aCartID.
	clientID := cartIDsToClientID at:aCartID .
	cashier := Cashier toCheckout: cart charging:aCreditCard  throught:merchantProcessor on:self now  registeringOn: (self salesBook:clientID).
	
	self registerPurchaseCartID: aCartID from: clientID.
	
	^ cashier checkOut.! !

!InnerFace methodsFor: 'actions' stamp: 'FA 11/18/2019 14:30:20'!
createCartFor: aClientId withPassword: aPassword

	self assert: aClientId isValidWithPassword:aPassword.
	
	lastCartID := lastCartID + 1.
	
	cartIDsToCart at: lastCartID put: (Cart acceptingItemsOf: catalog).
	
	cartIDsToClientID at:lastCartID put:aClientId .
	
	self updateLastModifyTime: lastCartID.
	
	^ lastCartID.

	
	! !

!InnerFace methodsFor: 'actions' stamp: 'FA 11/18/2019 11:53:10'!
passTime: aDuration 
	passTime := passTime + aDuration.! !

!InnerFace methodsFor: 'actions' stamp: 'FA 11/18/2019 13:15:24'!
registerPurchaseCartID: aCartID from:aClientID 
	| purchasesCartIDs |
	purchasesCartIDs:= clientIDsToPurchasedCartIDs at:aClientID ifAbsentPut:[OrderedCollection new.].
	purchasesCartIDs add: aCartID .
	clientIDsToPurchasedCartIDs at:aClientID put:purchasesCartIDs.! !

!InnerFace methodsFor: 'actions' stamp: 'FA 11/18/2019 12:17:31'!
updateLastModifyTime: aCartID 
	cartIDsToLastModifyTime at:aCartID put:(self now).! !


!InnerFace methodsFor: 'initialization' stamp: 'FA 11/18/2019 13:14:15'!
initialize

	usersToPassword := Dictionary new.
	catalog := Dictionary new.
	cartIDsToCart := Dictionary new.
	lastCartID := 0.
	checkout:=false.
	passTime  := Duration zero.
	cartIDsToLastModifyTime := Dictionary new.
	cartIDsToClientID := Dictionary new.
	salesBook := Dictionary new.
	clientIDsToPurchasedCartIDs := Dictionary new.! !

!InnerFace methodsFor: 'initialization' stamp: 'FA 11/18/2019 12:46:00'!
initializeWithUsers: aUsersToPasswordDictionary andCatalog: aCatalog andSalesBook: aSalesBook andMerchantProcessor: aMerchantProcessor   

	self initialize.
	usersToPassword := aUsersToPasswordDictionary.
	catalog := aCatalog.
	salesBook := aSalesBook.
	merchantProcessor := aMerchantProcessor .! !


!InnerFace methodsFor: 'accessing' stamp: 'FA 11/18/2019 14:37:03'!
getPurchasesFromCartIDs: aListOfCartIDs
	| purchases total |
	total := 0.
	purchases := Dictionary new.
	aListOfCartIDs do: [
		:aCartID | | cart | 
		cart := cartIDsToCart at:aCartID. 
		total := total + cart total.
		(cart items) do: [
			:item | | amountOfItem |
			 amountOfItem:= purchases at:item ifAbsentPut:[0.].
			 purchases at:item put:(amountOfItem +1).
			].
		].
	purchases at:'total_amount' put:total.
	^purchases.! !

!InnerFace methodsFor: 'accessing' stamp: 'FA 11/18/2019 14:36:02'!
getPurchasesOf: aClientID
	
	| cartIDsList purchases |
	cartIDsList := clientIDsToPurchasedCartIDs at:aClientID ifAbsentPut:[OrderedCollection new.].
	purchases := self getPurchasesFromCartIDs:cartIDsList.
	^purchases.! !

!InnerFace methodsFor: 'accessing' stamp: 'FA 11/18/2019 13:04:29'!
listCart: aCartID 
	
	| cartSummary |
	cartSummary := Dictionary new.
	
	self assertCartIsValid: aCartID.
	
	(cartIDsToCart at: aCartID) items do: [ :anISBN |
		cartSummary at: anISBN put: (cartSummary at: anISBN ifAbsentPut: 0) + 1.
	].
	self updateLastModifyTime:aCartID.
	
	^cartSummary.! !

!InnerFace methodsFor: 'accessing' stamp: 'FA 11/18/2019 14:25:43'!
listPurchasesOf: aClientID withPassword: aClientPassword 

	self assert: aClientID isValidWithPassword:aClientPassword.
	^self getPurchasesOf:aClientID.

	! !

!InnerFace methodsFor: 'accessing' stamp: 'FA 11/18/2019 11:56:40'!
now
	^DateAndTime now + passTime .! !

!InnerFace methodsFor: 'accessing' stamp: 'FA 11/18/2019 12:41:35'!
salesBook: aClientID 
	^salesBook at:aClientID  ifAbsentPut:[OrderedCollection new].! !


!InnerFace methodsFor: 'assertions' stamp: 'FA 11/18/2019 10:38:35'!
assert: aClientId isValidWithPassword:aClientPassword

	| realPassword |
	realPassword := usersToPassword at: aClientId ifAbsent: [ self error: self class invalidCredentialsErrorMessage ].
	(realPassword = aClientPassword) ifFalse: [ self error: self class invalidCredentialsErrorMessage ].
	! !

!InnerFace methodsFor: 'assertions' stamp: 'FA 11/18/2019 12:02:07'!
assertCartIsNotExpired: aCartID

	| lastModifyTime |
	lastModifyTime := cartIDsToLastModifyTime at: aCartID.
	(self now - lastModifyTime) < (Duration minutes: 30) ifFalse: [self error: self class expiredCartErrorMessage].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InnerFace class' category: #TusLibros!
InnerFace class
	instanceVariableNames: ''!

!InnerFace class methodsFor: 'error descriptions' stamp: 'FA 11/18/2019 11:54:08'!
expiredCartErrorMessage
	
	^ 'Expired cart'! !

!InnerFace class methodsFor: 'error descriptions' stamp: 'LR 11/11/2019 18:01:50'!
invalidCredentialsErrorMessage
	
	^ 'Invalid credentials'! !

!InnerFace class methodsFor: 'error descriptions' stamp: 'LR 11/14/2019 17:29:43'!
nonExistentCartErrorMessage
	
	^ 'Non existent cart'! !


!InnerFace class methodsFor: 'instance creation' stamp: 'FA 11/18/2019 12:47:07'!
createWithUsers: aUsersToPasswordDictionary andCatalog: aCatalog andSalesBook: aSalesBook andMerchantProcessor: aMerchantProcessor

	^self new initializeWithUsers: aUsersToPasswordDictionary andCatalog: aCatalog andSalesBook: aSalesBook andMerchantProcessor: aMerchantProcessor.! !


!InnerFace class methodsFor: 'errors description' stamp: 'FA 11/18/2019 14:52:37'!
cartAlreadyCheckoutedErrorMessage
	^'Cart already checkouted'.! !


!classDefinition: #Sale category: #TusLibros!
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

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'FA 11/18/2019 15:05:21'!
anotherItemSellByTheStore
	
	^ 'anotherValidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'FA 11/18/2019 15:05:29'!
anotherItemSellByTheStorePrice
	
	^5! !

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

!StoreTestObjectsFactory methodsFor: 'innerface' stamp: 'FA 11/18/2019 12:53:55'!
createInnerFace
	
	^InnerFace createWithUsers: self defaultUsers andCatalog: self defaultCatalog andSalesBook: (Dictionary new) andMerchantProcessor:self.! !

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

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'FA 11/18/2019 15:06:25'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		at: self anotherItemSellByTheStore put: self anotherItemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'FA 11/18/2019 12:54:46'!
initialize

	today := DateAndTime now.
	debitBehavior := [ :anAmount :aCreditCard | ].! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'FA 11/18/2019 12:54:20'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !
