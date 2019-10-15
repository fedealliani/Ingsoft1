!classDefinition: #TestTerniLapilliGame category: #'22-TerniLapilli'!
TestCase subclass: #TestTerniLapilliGame
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '22-TerniLapilli'!

!TestTerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'LR 10/10/2019 17:22:21'!
test01FirstMovementCorrespondsToX

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	self assert: true equals: terniLapilliGame isPlayingX.! !

!TestTerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'LR 10/10/2019 17:22:39'!
test02FirstMovementDoesNotCorrespondsToO

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	self assert: false equals: terniLapilliGame isPlayingO.! !

!TestTerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'LR 10/10/2019 17:24:14'!
test03GameIsNotOverWhenItStarts

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	self assert: false equals: terniLapilliGame isOver.! !

!TestTerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'LR 10/10/2019 17:28:02'!
test04GameIsTiedWhenItStarts

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	self assert: true equals: terniLapilliGame isTied.! !

!TestTerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'LR 10/10/2019 17:29:53'!
test05XPlayerIsNotWinnerWhenGameStarts

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	self assert: false equals: terniLapilliGame hasPlayerXWon.! !

!TestTerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'LR 10/10/2019 17:30:19'!
test06OPlayerIsNotWinnerWhenGameStarts

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	self assert: false equals: terniLapilliGame hasPlayerOWon.! !

!TestTerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'LR 10/10/2019 17:45:45'!
test07OPlayerCannotPutStoneWhenGameStarts

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	self should: [
		terniLapilliGame putOAt: 1@1.
	] raise: Error - MessageNotUnderstood withMessageText: TerniLapilliGame playerOCannotPutStoneWhenItIsNotItsTurnErrorDescription.
	! !

!TestTerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'LR 10/10/2019 18:30:24'!
test08WhenGameStartsAndXPutStoneNowItIsOsTurn

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 1@1.
	
	self assert: true equals: terniLapilliGame isPlayingO.! !

!TestTerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'LR 10/10/2019 18:30:38'!
test09WhenGameStartsAndXPutStoneNowItIsNotXsTurn

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 1@1.
	
	self assert: false equals: terniLapilliGame isPlayingX.! !

!TestTerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'LR 10/10/2019 18:36:30'!
test10WhenGameStartsXCannotMove

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	self should: [
		terniLapilliGame moveXAt: 0@0 to: 2@2.
	] raise: Error - MessageNotUnderstood withMessageText: TerniLapilliGame playerXCannotMoveStoneBecauseItsThreeStonesAreNotPlacedErrorDescription.
	! !

!TestTerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'LR 10/10/2019 18:37:54'!
test11WhenGameStartsOCannotMove

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	self should: [
		terniLapilliGame moveOAt: 0@0 to: 2@2.
	] raise: Error - MessageNotUnderstood withMessageText: TerniLapilliGame playerOCannotMoveStoneWhenItIsNotItsTurnErrorDescription .
	! !

!TestTerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'LR 10/10/2019 18:41:55'!
test12WhenGameStartsAndXPutStoneThenOCannotMove

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 1@1.
	
	self should: [
		terniLapilliGame moveOAt: 0@0 to: 2@2.
	] raise: Error - MessageNotUnderstood withMessageText: TerniLapilliGame playerOCannotMoveStoneBecauseItsThreeStonesAreNotPlacedErrorDescription.
	! !

!TestTerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'LR 10/10/2019 18:46:43'!
test13WhenGameStartsAndXPutStoneThenXCannotMove

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 1@1.
	
	self should: [
		terniLapilliGame moveXAt: 0@0 to: 2@2.
	] raise: Error - MessageNotUnderstood withMessageText: TerniLapilliGame playerXCannotMoveStoneWhenItIsNotItsTurnErrorDescription 
	! !

!TestTerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'LR 10/10/2019 18:53:18'!
test14OPlayerCannotPutStoneInAPositionAlreadyUsed

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 1@1.
	
	self should: [
		terniLapilliGame putOAt: 1@1.
	] raise: Error - MessageNotUnderstood withMessageText: TerniLapilliGame playerOCannotPutStoneBecausePositionIsAlreadyUsedErrorDescription 
	! !

!TestTerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'LR 10/14/2019 20:22:34'!
test15ThereIsAnXStoneInTheSamePlaceWhereXPlayerDidPutAStone

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 2@2.
	
	self assert: true equals: (terniLapilliGame isXAt: 2@2).! !

!TestTerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'LR 10/14/2019 20:23:37'!
test16ThereIsAnOStoneInTheSamePlaceWhereOPlayerDidPutAStone

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 2@2.
	terniLapilliGame putOAt: 1@2.
	
	self assert: true equals: (terniLapilliGame isOAt: 1@2).! !

!TestTerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'LR 10/14/2019 20:32:23'!
test17ThereIsNotAnXStoneInAPlaceWhereOPlayerDidPutAStone

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 2@2.
	terniLapilliGame putOAt: 2@1.
	
	self deny: (terniLapilliGame isXAt: 2@1).! !

!TestTerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'LR 10/14/2019 20:32:54'!
test18ThereIsNotAnXStoneInAPlaceWhereThereIsNotAnyStone

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	self deny: (terniLapilliGame isXAt: 1@2).! !

!TestTerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'LR 10/14/2019 20:35:01'!
test19ThereIsNotAnOStoneInAPlaceWhereXPlayerDidPutAStone

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 2@2.
	
	self deny: (terniLapilliGame isOAt: 2@2).! !

!TestTerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'LR 10/14/2019 20:36:49'!
test20ThereIsNotAnOStoneInAPlaceWhereThereIsNotAnyStone

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	self deny: (terniLapilliGame isOAt: 0@0).! !

!TestTerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'LR 10/14/2019 21:05:28'!
test21WhenOPlayerPutAStoneTheNextTurnCorrespondsToXPlayer

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 0@0.
	terniLapilliGame putOAt: 1@1.
	
	self assert: terniLapilliGame isPlayingX.! !

!TestTerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'LR 10/14/2019 21:09:59'!
test22XPlayerCannotPutStoneInAPositionWhereThereIsAnXStone

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 1@1.
	terniLapilliGame putOAt: 0@1.
	
	self should: [
		terniLapilliGame putXAt: 1@1.
	] raise: Error - MessageNotUnderstood withMessageText: TerniLapilliGame playerXCannotPutStoneBecausePositionIsAlreadyUsedErrorDescription
	! !

!TestTerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'LR 10/14/2019 21:12:43'!
test23XPlayerCannotPutStoneInAPositionWhereThereIsAnOStone

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 1@1.
	terniLapilliGame putOAt: 0@1.
	
	self should: [
		terniLapilliGame putXAt: 0@1.
	] raise: Error - MessageNotUnderstood withMessageText: TerniLapilliGame playerXCannotPutStoneBecausePositionIsAlreadyUsedErrorDescription
	! !

!TestTerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'LR 10/14/2019 21:16:40'!
test24XPlayerCannotPutStoneWhenItIsNotItsTurn

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 1@1.
	
	self should: [
		terniLapilliGame putXAt: 0@1.
	] raise: Error - MessageNotUnderstood withMessageText: TerniLapilliGame playerXCannotPutStoneWhenItIsNotItsTurnErrorDescription.
	! !


!classDefinition: #TerniLapilliGame category: #'22-TerniLapilli'!
Object subclass: #TerniLapilliGame
	instanceVariableNames: 'isXTurn xStones oStones'
	classVariableNames: ''
	poolDictionaries: ''
	category: '22-TerniLapilli'!

!TerniLapilliGame methodsFor: 'accessing' stamp: 'LR 10/10/2019 17:30:28'!
hasPlayerOWon

	^ false! !

!TerniLapilliGame methodsFor: 'accessing' stamp: 'LR 10/10/2019 17:30:08'!
hasPlayerXWon
	
	^ false! !

!TerniLapilliGame methodsFor: 'accessing' stamp: 'LR 10/14/2019 21:01:48'!
isOAt: aPosition 
	
	^(oStones at: aPosition ifAbsent: [ ^false ]).! !

!TerniLapilliGame methodsFor: 'accessing' stamp: 'LR 10/10/2019 17:23:56'!
isOver
	
	^ false.! !

!TerniLapilliGame methodsFor: 'accessing' stamp: 'LR 10/14/2019 21:07:03'!
isPlayingO
	
	^ self isPlayingX not! !

!TerniLapilliGame methodsFor: 'accessing' stamp: 'LR 10/10/2019 18:25:37'!
isPlayingX
	
	^ isXTurn.! !

!TerniLapilliGame methodsFor: 'accessing' stamp: 'LR 10/10/2019 17:28:12'!
isTied
	
	^ true! !

!TerniLapilliGame methodsFor: 'accessing' stamp: 'LR 10/14/2019 21:01:40'!
isXAt: aPosition 
	
	^(xStones at: aPosition ifAbsent: [ ^false ]).! !


!TerniLapilliGame methodsFor: 'initialization' stamp: 'LR 10/14/2019 21:23:05'!
initialize

	isXTurn := true.
	xStones := Dictionary new.
	oStones := Dictionary new.! !


!TerniLapilliGame methodsFor: 'actions' stamp: 'LR 10/14/2019 20:40:02'!
moveOAt: aPosition to: anotherPosition 
	
	self isPlayingO ifTrue: [ self error: self class playerOCannotMoveStoneBecauseItsThreeStonesAreNotPlacedErrorDescription ].
	self error: self class playerOCannotMoveStoneWhenItIsNotItsTurnErrorDescription.! !

!TerniLapilliGame methodsFor: 'actions' stamp: 'LR 10/10/2019 18:48:02'!
moveXAt: aPosition to: anotherPosition 
	
	self isPlayingX ifTrue: [ self error: self class playerXCannotMoveStoneBecauseItsThreeStonesAreNotPlacedErrorDescription ].
	self error: self class playerXCannotMoveStoneWhenItIsNotItsTurnErrorDescription.! !

!TerniLapilliGame methodsFor: 'actions' stamp: 'LR 10/14/2019 21:14:57'!
putOAt: aPoint 
	
	self isPlayingO ifFalse: [ self error: self class playerOCannotPutStoneWhenItIsNotItsTurnErrorDescription ].

	oStones at: aPoint
		ifPresent: [ :value | self error: self class playerOCannotPutStoneBecausePositionIsAlreadyUsedErrorDescription ]
		ifAbsent: [
			xStones at: aPoint
				ifPresent: [ :value | self error: self class playerOCannotPutStoneBecausePositionIsAlreadyUsedErrorDescription ]
				ifAbsent: [ oStones at: aPoint put: true ]. 
		].
	
	isXTurn := true.! !

!TerniLapilliGame methodsFor: 'actions' stamp: 'LR 10/14/2019 21:17:46'!
putXAt: aPoint 

	self isPlayingX ifFalse: [ self error: self class playerXCannotPutStoneWhenItIsNotItsTurnErrorDescription ].

	xStones at: aPoint
		ifPresent: [ :value | self error: self class playerXCannotPutStoneBecausePositionIsAlreadyUsedErrorDescription ]
		ifAbsent: [
			oStones at: aPoint
				ifPresent: [ :value | self error: self class playerXCannotPutStoneBecausePositionIsAlreadyUsedErrorDescription ]
				ifAbsent: [ xStones at: aPoint put: true ]. 
		].
				
	isXTurn := false.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliGame class' category: #'22-TerniLapilli'!
TerniLapilliGame class
	instanceVariableNames: ''!

!TerniLapilliGame class methodsFor: 'error descriptions' stamp: 'LR 10/10/2019 18:42:24'!
playerOCannotMoveStoneBecauseItsThreeStonesAreNotPlacedErrorDescription

	^ 'Player O cannot move the stone because its three stones are not placed yet.'! !

!TerniLapilliGame class methodsFor: 'error descriptions' stamp: 'LR 10/10/2019 18:38:45'!
playerOCannotMoveStoneWhenItIsNotItsTurnErrorDescription
	
	^ 'Player O cannot move the stone because it is not its turn'! !

!TerniLapilliGame class methodsFor: 'error descriptions' stamp: 'LR 10/10/2019 18:54:36'!
playerOCannotPutStoneBecausePositionIsAlreadyUsedErrorDescription
	
	^ 'Player O cannot put a stone here because there is another stone in this position'! !

!TerniLapilliGame class methodsFor: 'error descriptions' stamp: 'LR 10/10/2019 17:45:27'!
playerOCannotPutStoneWhenItIsNotItsTurnErrorDescription

	^ 'Player O cannot put a stone because it is not its turn.'! !

!TerniLapilliGame class methodsFor: 'error descriptions' stamp: 'LR 10/10/2019 18:36:07'!
playerXCannotMoveStoneBecauseItsThreeStonesAreNotPlacedErrorDescription

	^ 'Player X cannot move the stone because its three stones are not placed yet.'! !

!TerniLapilliGame class methodsFor: 'error descriptions' stamp: 'LR 10/10/2019 18:47:13'!
playerXCannotMoveStoneWhenItIsNotItsTurnErrorDescription
	
	^ 'Player X cannot move the stone because it is not its turn'! !

!TerniLapilliGame class methodsFor: 'error descriptions' stamp: 'LR 10/14/2019 21:10:46'!
playerXCannotPutStoneBecausePositionIsAlreadyUsedErrorDescription
	
	^ 'Player X cannot put a stone here because there is another stone in this position'! !

!TerniLapilliGame class methodsFor: 'error descriptions' stamp: 'LR 10/14/2019 21:17:10'!
playerXCannotPutStoneWhenItIsNotItsTurnErrorDescription
	
	^ 'Player X cannot put a stone because it is not its turn.'! !
