!classDefinition: #TusLibrosServerController category: #'TusLibros-Server' stamp: 'FA 12/5/2019 01:25:27'!
Object subclass: #TusLibrosServerController
	instanceVariableNames: 'webServer port systemFacade'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Server'!

!TusLibrosServerController methodsFor: 'initialization' stamp: 'FA 12/4/2019 21:30:19'!
catalog
	
	^ Dictionary new
		at: '978-0439708180' put: (self createDictionaryWith:8.74  and:'title 1');
		at: '978-1338299151' put: (self createDictionaryWith:6.99  and:'title 2');
		at: '978-0439136365' put: (self createDictionaryWith:5.76  and:'title 3');
		at: '978-0439139601' put: (self createDictionaryWith:7.79  and:'title 4');
		at: '978-0439358071' put:(self createDictionaryWith:7.79  and:'title 5');
		at: '978-0439785969' put: (self createDictionaryWith:7.79  and:'title 6');
		at: '978-0545139700' put: (self createDictionaryWith:10.49  and:'title 7');
		yourself ! !

!TusLibrosServerController methodsFor: 'initialization' stamp: 'FA 12/4/2019 20:14:40'!
clock
	^ DateAndTime.! !

!TusLibrosServerController methodsFor: 'initialization' stamp: 'FA 12/4/2019 22:00:41'!
createDictionaryWith:aPrice and:aTitle
	
	^ Dictionary newFromPairs:{
		'price'.aPrice.
		'title'.aTitle.
	}! !

!TusLibrosServerController methodsFor: 'initialization' stamp: 'LR 12/1/2019 21:20:24'!
debit: anAmount from: aCreditCard
! !

!TusLibrosServerController methodsFor: 'initialization' stamp: 'FA 12/5/2019 00:36:32'!
initializeWith: aPortNumber

	[
		port:= aPortNumber.
	
		webServer := WebServer new listenOn: aPortNumber.
		
		systemFacade := TusLibrosSystemFacade
			authenticatingWith: self usersAndPasswords
			acceptingItemsOf: self catalog
			registeringOn: self salesBook
			debitingThrought: self merchantProcessor
			measuringTimeWith: self clock.
			
		webServer addService: '/createCart' action:[:request | |substringsAsJson clientID password substrings |
		
		[ | cartID |
		clientID := (request fields at:'clientId').
		password := (request fields at:'password').
		cartID:=systemFacade createCartFor:clientID  authenticatedWith: password.
		substringsAsJson:= WebUtils jsonEncode: (
			Dictionary newFromPairs: {
				'code'. 		0.
				'msg'.	cartID asNumber.
			}
		).
		request send200Response: (substringsAsJson) 
				 contentType: 'application/json; charset=utf-8' do: [:resp | 
					resp headerAt: 'Access-Control-Allow-Origin' put: '*'.]
		 ] 
		on: Error 
		do: [ :anError |
			
			anError messageText = systemFacade invalidUserAndOrPasswordErrorDescription ifTrue:[
				substringsAsJson:= WebUtils jsonEncode: (
					Dictionary newFromPairs: {
						'code'. 		1.
						'msg'.	anError messageText.
					}
				).
				request send200Response:(substringsAsJson) contentType: 'application/json; charset=utf-8' do: [:resp | 
					resp headerAt: 'Access-Control-Allow-Origin' put: '*'.].
				^self.
				].
			request send200Response: (anError messageText) contentType: 'application/json; charset=utf-8' do: [:resp | 
					resp headerAt: 'Access-Control-Allow-Origin' put: '*'.] 
				]
			].
	
			
			webServer addService: '/catalog' action:[:request | |substringsAsJson clientID password substrings |
		
		[ | result |
		result := OrderedCollection new.
		(self catalog keys) do:[:key| result add:(
				Dictionary newFromPairs:{
					'isbn'.key.
					'title'.(self catalog at:key)at:'title'.
					'price'.(self catalog at:key)at:'price'.
				}
				)
		].
		
		substringsAsJson:= WebUtils jsonEncode: (result asArray).
		request send200Response: (substringsAsJson) 
				 contentType: 'application/json; charset=utf-8' do: [:resp | 
					resp headerAt: 'Access-Control-Allow-Origin' put: '*'.]
		 ] 
		on: Error 
		do: [ :anError |
				substringsAsJson:= WebUtils jsonEncode: (
					Dictionary newFromPairs: {
						'code'. 		1.
						'msg'.	anError messageText.
					}
				).
				request send200Response:(substringsAsJson) contentType: 'application/json; charset=utf-8' do: [:resp | 
				resp headerAt: 'Access-Control-Allow-Origin' put: '*'.].
				]
			].
			
			
			
			webServer addService: '/addToCart' action:[:request | |substringsAsJson clientID password substrings |
		
		[ |  bookIsbn bookQuantity cartId |
		cartId := (request fields at:'cartId') asInteger .
		bookIsbn := (request fields at:'bookIsbn').
		bookQuantity := (request fields at:'bookQuantity') asNumber.
		systemFacade add:bookQuantity  of:bookIsbn  toCartIdentifiedAs:cartId.
		substringsAsJson:= WebUtils jsonEncode: (
			Dictionary newFromPairs: {
				'code'. 		0.
				'msg'.	'OK'.
			}
		).
		request send200Response: (substringsAsJson) 
				 contentType: 'application/json; charset=utf-8' do: [:resp | 
					resp headerAt: 'Access-Control-Allow-Origin' put: '*'.]
		 ] 
		on: Error 
		do: [ :anError |

				substringsAsJson:= WebUtils jsonEncode: (
					Dictionary newFromPairs: {
						'code'. 		1.
						'msg'.	anError messageText.
					}
				).
				request send200Response:(substringsAsJson) contentType: 'application/json; charset=utf-8' do: [:resp | 
					resp headerAt: 'Access-Control-Allow-Origin' put: '*'.].
				
			
				]
			].
	
	
				webServer addService: '/listCart' action:[:request | |substringsAsJson clientID password substrings |
		
		[ |  booksInCart result cartId |
		cartId := (request fields at:'cartId') asInteger .
		booksInCart :=(systemFacade listCartIdentifiedAs: cartId) asArray.
		result:=Dictionary new.
		booksInCart do:[:isbn|
			result at:isbn put:((result at:isbn ifAbsentPut:0)+1).
			].
		substringsAsJson:= WebUtils jsonEncode: (
			Dictionary newFromPairs: {
				'code'. 		0.
				'msg'.	result.
			}
		).
		request send200Response: (substringsAsJson) 
				 contentType: 'application/json; charset=utf-8' do: [:resp | 
					resp headerAt: 'Access-Control-Allow-Origin' put: '*'.]
		 ] 
		on: Error 
		do: [ :anError |

				substringsAsJson:= WebUtils jsonEncode: (
					Dictionary newFromPairs: {
						'code'. 		1.
						'msg'.	anError messageText.
					}
				).
				request send200Response:(substringsAsJson) contentType: 'application/json; charset=utf-8' do: [:resp | 
					resp headerAt: 'Access-Control-Allow-Origin' put: '*'.].
				
			
				]
			].
		
		
		webServer addService: '/checkoutCart' action:[:request | |substringsAsJson clientID password substrings |
		
		[ |  ccn cced cco  cartId testObjectsFactory |
			testObjectsFactory:=StoreTestObjectsFactory new. 
		cartId := (request fields at:'cartId') asInteger .
		
		systemFacade checkOutCartIdentifiedAs: cartId
		 withCreditCardNumbered: testObjectsFactory notExpiredCreditCardNumber
		 ownedBy: testObjectsFactory notExpiredCreditCardOwner 
		 expiringOn: testObjectsFactory notExpiredMonthOfYear.
		substringsAsJson:= WebUtils jsonEncode: (
			Dictionary newFromPairs: {
				'code'. 		0.
				'msg'.	0.
			}
		).
		request send200Response: (substringsAsJson) 
				 contentType: 'application/json; charset=utf-8' do: [:resp | 
					resp headerAt: 'Access-Control-Allow-Origin' put: '*'.]
		 ] 
		on: Error 
		do: [ :anError |

				substringsAsJson:= WebUtils jsonEncode: (
					Dictionary newFromPairs: {
						'code'. 		1.
						'msg'.	anError messageText.
					}
				).
				request send200Response:(substringsAsJson) contentType: 'application/json; charset=utf-8' do: [:resp | 
					resp headerAt: 'Access-Control-Allow-Origin' put: '*'.].
				
			
				]
			].
		
	] on: Error do: [ :anError |
		self stopListening.
		self destroy.
		
		anError pass.
	].
	
	! !

!TusLibrosServerController methodsFor: 'initialization' stamp: 'LR 12/1/2019 21:20:19'!
merchantProcessor
	
	^ self! !

!TusLibrosServerController methodsFor: 'initialization' stamp: 'LR 12/1/2019 21:14:09'!
salesBook
	
	^ OrderedCollection new! !

!TusLibrosServerController methodsFor: 'initialization' stamp: 'LR 12/1/2019 21:14:56'!
usersAndPasswords

	^ Dictionary new
		at: 'user1' put: 'password1';
		yourself! !


!TusLibrosServerController methodsFor: 'accesing' stamp: 'LR 12/1/2019 20:37:51'!
port
	"Use a random port to minimise chances of concurrently running test suites clashing."
	"^ port
		ifNil: [port := (10000 to: 50000) atRandom]"
	
	^port ifNil: [port:=8080].! !


!TusLibrosServerController methodsFor: 'enabling services' stamp: 'LR 12/1/2019 20:38:02'!
destroy
	
	webServer ifNotNil:[webServer destroy].! !

!TusLibrosServerController methodsFor: 'enabling services' stamp: 'LR 12/1/2019 20:38:17'!
startListening
	
	webServer startListener.

	^ 'Listening on port: ', self port asString.! !

!TusLibrosServerController methodsFor: 'enabling services' stamp: 'LR 12/1/2019 20:38:29'!
stopListening
	
	webServer stopListener.
	
	^'Stopped listening from port: ', self port asString.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosServerController class' category: #'TusLibros-Server' stamp: 'FA 12/5/2019 01:25:27'!
TusLibrosServerController class
	instanceVariableNames: ''!

!TusLibrosServerController class methodsFor: 'instance creation' stamp: 'LR 12/1/2019 20:34:04'!
listeningOn: aPortNumber

	^self new initializeWith: aPortNumber.! !
