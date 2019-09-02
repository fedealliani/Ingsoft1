!classDefinition: #I category: #'Numeros de Peano'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #'Numeros de Peano'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'as yet unclassified' stamp: 'LR 9/1/2019 22:25:48'!
* unNumeroDePeano

	^ unNumeroDePeano.! !

!I class methodsFor: 'as yet unclassified' stamp: 'LR 8/26/2019 18:52:46'!
+ unNumeroDePeano

	^ unNumeroDePeano next.! !

!I class methodsFor: 'as yet unclassified' stamp: 'LR 9/1/2019 23:28:18'!
- unNumeroDePeano
	^ (unNumeroDePeano = self)
	ifTrue: [
		^ nil.
	]
	ifFalse: [ self error: self descripcionDeErrorDeNumerosNegativosNoSoportados. ].

! !

!I class methodsFor: 'as yet unclassified' stamp: 'LR 9/1/2019 23:22:51'!
/ unNumeroDePeano
	^ (unNumeroDePeano = self)
	ifTrue: [
		^ self.
	]
	ifFalse: [ self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor ].

! !

!I class methodsFor: 'as yet unclassified' stamp: 'LR 9/1/2019 23:22:58'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^ 'El resultado no es natural'.! !

!I class methodsFor: 'as yet unclassified' stamp: 'LR 9/1/2019 23:13:22'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^ 'Numeros negativos no soportados'.! !

!I class methodsFor: 'as yet unclassified' stamp: 'LR 8/26/2019 18:25:57'!
next
	^II.! !

!I class methodsFor: 'as yet unclassified' stamp: 'LR 9/1/2019 22:47:27'!
previous
	^nil.! !


!classDefinition: #II category: #'Numeros de Peano'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #'Numeros de Peano'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'as yet unclassified' stamp: 'LR 9/1/2019 22:48:55'!
* unNumeroDePeano

	^ unNumeroDePeano * (self previous) + unNumeroDePeano.! !

!II class methodsFor: 'as yet unclassified' stamp: 'LR 8/26/2019 18:54:01'!
+ unNumeroDePeano

	^ self previous + unNumeroDePeano next.! !

!II class methodsFor: 'as yet unclassified' stamp: 'LR 9/1/2019 23:04:51'!
- unNumeroDePeano
	(unNumeroDePeano = I)
	ifTrue: [
		^ self previous.
	]
	ifFalse: [
		^ self previous - unNumeroDePeano previous.
	]! !

!II class methodsFor: 'as yet unclassified' stamp: 'LR 9/1/2019 23:50:30'!
/ unNumeroDePeano
	| resta |
	(unNumeroDePeano = self)
	ifTrue: [
		^ I.
	]
	ifFalse: [
		resta := ([self - unNumeroDePeano] on: Error do: [ self error: I descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor.]).
		^ I + (resta / unNumeroDePeano).
	]! !

!II class methodsFor: 'as yet unclassified' stamp: 'LR 9/1/2019 23:23:18'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^ I descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor.! !

!II class methodsFor: 'as yet unclassified' stamp: 'LR 9/1/2019 23:52:04'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !

!II class methodsFor: 'as yet unclassified' stamp: 'LR 8/26/2019 18:56:49'!
next
	next ifNil: [
		next := self cloneNamed: self name, 'I'.
		next previous: self.
	].
	^ next.! !

!II class methodsFor: 'as yet unclassified' stamp: 'LR 8/26/2019 18:57:34'!
previous
	^previous.! !

!II class methodsFor: 'as yet unclassified' stamp: 'LR 8/26/2019 19:07:15'!
previous: unNumeroDePeano
	previous := unNumeroDePeano.! !

!II class methodsFor: 'as yet unclassified' stamp: 'LR 8/26/2019 18:42:23'!
removeAllNext
	next ifNotNil: [
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]

! !


!classDefinition: #III category: #'Numeros de Peano'!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: #'Numeros de Peano'!
III class
	instanceVariableNames: 'next previous'!

!III class methodsFor: 'as yet unclassified' stamp: 'LR 9/1/2019 23:50:39'!
* unNumeroDePeano

	^ unNumeroDePeano * (self previous) + unNumeroDePeano.! !

!III class methodsFor: 'as yet unclassified' stamp: 'LR 9/1/2019 23:50:39'!
+ unNumeroDePeano

	^ self previous + unNumeroDePeano next.! !

!III class methodsFor: 'as yet unclassified' stamp: 'LR 9/1/2019 23:50:39'!
- unNumeroDePeano
	(unNumeroDePeano = I)
	ifTrue: [
		^ self previous.
	]
	ifFalse: [
		^ self previous - unNumeroDePeano previous.
	]! !

!III class methodsFor: 'as yet unclassified' stamp: 'LR 9/1/2019 23:50:39'!
/ unNumeroDePeano
	| resta |
	(unNumeroDePeano = self)
	ifTrue: [
		^ I.
	]
	ifFalse: [
		resta := ([self - unNumeroDePeano] on: Error do: [ self error: I descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor.]).
		^ I + (resta / unNumeroDePeano).
	]! !

!III class methodsFor: 'as yet unclassified' stamp: 'LR 9/1/2019 23:50:39'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^ I descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor.! !

!III class methodsFor: 'as yet unclassified' stamp: 'LR 9/1/2019 23:52:04'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !

!III class methodsFor: 'as yet unclassified' stamp: 'LR 9/1/2019 23:50:39'!
next
	next ifNil: [
		next := self cloneNamed: self name, 'I'.
		next previous: self.
	].
	^ next.! !

!III class methodsFor: 'as yet unclassified' stamp: 'LR 9/1/2019 23:50:39'!
previous
	^previous.! !

!III class methodsFor: 'as yet unclassified' stamp: 'LR 9/1/2019 23:50:39'!
previous: unNumeroDePeano
	previous := unNumeroDePeano.! !

!III class methodsFor: 'as yet unclassified' stamp: 'LR 9/1/2019 23:50:39'!
removeAllNext
	next ifNotNil: [
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]

! !


!classDefinition: #IIII category: #'Numeros de Peano'!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: #'Numeros de Peano'!
IIII class
	instanceVariableNames: 'next previous'!

!IIII class methodsFor: 'as yet unclassified' stamp: 'LR 9/1/2019 23:50:39'!
* unNumeroDePeano

	^ unNumeroDePeano * (self previous) + unNumeroDePeano.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'LR 9/1/2019 23:50:40'!
+ unNumeroDePeano

	^ self previous + unNumeroDePeano next.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'LR 9/1/2019 23:50:40'!
- unNumeroDePeano
	(unNumeroDePeano = I)
	ifTrue: [
		^ self previous.
	]
	ifFalse: [
		^ self previous - unNumeroDePeano previous.
	]! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'LR 9/1/2019 23:50:40'!
/ unNumeroDePeano
	| resta |
	(unNumeroDePeano = self)
	ifTrue: [
		^ I.
	]
	ifFalse: [
		resta := ([self - unNumeroDePeano] on: Error do: [ self error: I descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor.]).
		^ I + (resta / unNumeroDePeano).
	]! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'LR 9/1/2019 23:50:40'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^ I descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'LR 9/1/2019 23:52:04'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := III.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'LR 9/1/2019 23:50:40'!
next
	next ifNil: [
		next := self cloneNamed: self name, 'I'.
		next previous: self.
	].
	^ next.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'LR 9/1/2019 23:50:40'!
previous
	^previous.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'LR 9/1/2019 23:50:40'!
previous: unNumeroDePeano
	previous := unNumeroDePeano.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'LR 9/1/2019 23:50:40'!
removeAllNext
	next ifNotNil: [
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]

! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!