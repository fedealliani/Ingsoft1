!classDefinition: #CartTest category: #'25-TusLibros' stamp: 'LR 10/29/2019 20:38:42'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '25-TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'LR 10/29/2019 19:30:57'!
test01ANewCartDoesNotHaveAnyItem

	| cart |
	cart := Cart new.
	
	self assert: cart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'LR 10/29/2019 19:36:02'!
test02AddingAnItemToACartMakesTheCartToBeNonEmpty

	| cart |
	cart := Cart new.
	
	cart add: 'Item'.
	
	self deny: cart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'LR 10/29/2019 19:39:17'!
test03AddingAnItemToACartMakesTheCartToContainsThatItem

	| cart item |
	cart := Cart new.
	item := 'Item'.
	
	cart add: item.
	
	self assert: (cart contains: item).! !

!CartTest methodsFor: 'tests' stamp: 'LR 10/29/2019 19:41:53'!
test04AnItemIsNotIncludedInAnEmptyCart

	| cart item |
	cart := Cart new.
	item := 'Item'.
	
	
	self deny: (cart contains: item).! !

!CartTest methodsFor: 'tests' stamp: 'LR 10/29/2019 19:47:33'!
test05AnEmptyCartHasZeroItems

	| cart |
	cart := Cart new.
	
	self assert: 0 equals: cart numberOfItems.! !

!CartTest methodsFor: 'tests' stamp: 'LR 10/29/2019 19:51:07'!
test06AddingOneItemToCartMakesTheCartToHaveOneItem

	| cart item |
	cart := Cart new.
	item := 'Item'.
	
	cart add: item.
	
	self assert: 1 equals: cart numberOfItems.! !

!CartTest methodsFor: 'tests' stamp: 'LR 10/29/2019 19:53:05'!
test07AddingTwoItemsToCartMakesTheCartToHaveTwoItem

	| cart item1 item2 |
	cart := Cart new.
	item1 := 'Item 1'.
	item2 := 'Item 2'.
	
	cart add: item1.
	cart add: item2.
	
	self assert: 2 equals: cart numberOfItems.! !

!CartTest methodsFor: 'tests' stamp: 'LR 10/29/2019 20:09:05'!
test08AddingAndRemovingAnItemFromACartMakesTheCartToBeEmpty

	| cart item |
	cart := Cart new.
	item := 'Item 1'.
	
	cart add: item.
	cart remove: 1 times: item.
	
	self assert: cart isEmpty.
	self assert: 0 equals: cart numberOfItems.
	self deny: (cart contains: item).! !

!CartTest methodsFor: 'tests' stamp: 'LR 10/29/2019 20:19:08'!
test09CannotRemoveAnItemThatIsNotInTheCart

	| cart item |
	cart := Cart new.
	item := 'Item 1'.

	self
		should: [ cart remove: 1 times: item. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :error |
			self assert: Cart cannotRemoveAnItemThatIsNotInTheCartErrorDescription equals: error messageText.
			
			self assert: cart isEmpty.
			self assert: 0 equals: cart numberOfItems.
			self deny: (cart contains: item).
		].! !

!CartTest methodsFor: 'tests' stamp: 'LR 10/29/2019 20:30:09'!
test10CannotRemoveAnItemMoreTimesThanItIsInTheCart

	| cart item |
	cart := Cart new.
	item := 'Item 1'.
	
	cart add: item.
	cart add: item.
	cart add: item.
	
	self
		should: [ cart remove: 5 times: item. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :error |
			self assert: Cart cannotRemoveAnItemMoreTimesThanItIsInTheCartErrorDescription equals: error messageText.
			
			self deny: cart isEmpty.
			self assert: 3 equals: cart numberOfItems.
			self assert: (cart contains: item).
		].! !


!classDefinition: #Cart category: #'25-TusLibros' stamp: 'LR 10/29/2019 20:38:42'!
Object subclass: #Cart
	instanceVariableNames: 'items'
	classVariableNames: ''
	poolDictionaries: ''
	category: '25-TusLibros'!

!Cart methodsFor: 'accessing' stamp: 'LR 10/29/2019 19:54:30'!
contains: anItem
	
	^ items includes: anItem! !

!Cart methodsFor: 'accessing' stamp: 'LR 10/29/2019 19:54:41'!
isEmpty
	
	^ items isEmpty! !

!Cart methodsFor: 'accessing' stamp: 'LR 10/29/2019 19:54:53'!
numberOfItems
	
	^ items size! !


!Cart methodsFor: 'initialization' stamp: 'LR 10/29/2019 19:53:54'!
initialize

	items := OrderedCollection new.! !


!Cart methodsFor: 'actions' stamp: 'LR 10/29/2019 19:54:16'!
add: anItem
	
	items add: anItem.! !

!Cart methodsFor: 'actions' stamp: 'LR 10/29/2019 20:36:34'!
remove: anAmmountOfItems times: anItem 
	
	(items includes: anItem) ifFalse: [ self error: self class cannotRemoveAnItemThatIsNotInTheCartErrorDescription ].
	((items occurrencesOf: anItem) < anAmmountOfItems) ifTrue: [ self error: self class cannotRemoveAnItemMoreTimesThanItIsInTheCartErrorDescription ].
	
	anAmmountOfItems timesRepeat: [ items remove: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'25-TusLibros' stamp: 'LR 10/29/2019 20:38:42'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'error descriptions' stamp: 'LR 10/29/2019 20:31:06'!
cannotRemoveAnItemMoreTimesThanItIsInTheCartErrorDescription
	
	^ 'Cannot remove an item more times than it is in the cart'! !

!Cart class methodsFor: 'error descriptions' stamp: 'LR 10/29/2019 20:19:55'!
cannotRemoveAnItemThatIsNotInTheCartErrorDescription
	
	^ 'Cannot remove an item that is not in the cart'! !
