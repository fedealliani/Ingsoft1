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

!TestTerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'LR 10/14/2019 22:45:55'!
test25XPlayerWinsTheGameWhenThereAreThreeXStonesInFirstColumn

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 0@0.
	terniLapilliGame putOAt: 1@0.
	
	terniLapilliGame putXAt: 0@1.
	terniLapilliGame putOAt: 1@1.
	
	terniLapilliGame putXAt: 0@2.
	
	self assert: terniLapilliGame hasPlayerXWon.! !

!TestTerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'LR 10/14/2019 22:51:57'!
test26OPlayerWinsTheGameWhenThereAreThreeOStonesInFirstColumn

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 1@0.
	terniLapilliGame putOAt: 0@0.
	
	terniLapilliGame putXAt: 1@1.
	terniLapilliGame putOAt: 0@1.
	
	terniLapilliGame putXAt: 2@2.
	terniLapilliGame putOAt: 0@2.
	
	self assert: terniLapilliGame hasPlayerOWon.! !

!TestTerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'LR 10/14/2019 22:53:32'!
test27XPlayerWinsTheGameWhenThereAreThreeXStonesInSecondColumn

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 1@0.
	terniLapilliGame putOAt: 0@0.
	
	terniLapilliGame putXAt: 1@1.
	terniLapilliGame putOAt: 0@1.
	
	terniLapilliGame putXAt: 1@2.
	
	self assert: terniLapilliGame hasPlayerXWon.! !

!TestTerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'LR 10/14/2019 22:55:42'!
test28OPlayerWinsTheGameWhenThereAreThreeOStonesInSecondColumn

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 0@0.
	terniLapilliGame putOAt: 1@0.
	
	terniLapilliGame putXAt: 0@1.
	terniLapilliGame putOAt: 1@1.
	
	terniLapilliGame putXAt: 2@2.
	terniLapilliGame putOAt: 1@2.
	
	self assert: terniLapilliGame hasPlayerOWon.! !

!TestTerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'LR 10/14/2019 22:56:31'!
test29XPlayerWinsTheGameWhenThereAreThreeXStonesInThirdColumn

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 2@0.
	terniLapilliGame putOAt: 0@0.
	
	terniLapilliGame putXAt: 2@1.
	terniLapilliGame putOAt: 0@1.
	
	terniLapilliGame putXAt: 2@2.
	
	self assert: terniLapilliGame hasPlayerXWon.! !

!TestTerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'LR 10/14/2019 22:56:52'!
test30OPlayerWinsTheGameWhenThereAreThreeOStonesInThirdColumn

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 0@0.
	terniLapilliGame putOAt: 2@0.
	
	terniLapilliGame putXAt: 0@1.
	terniLapilliGame putOAt: 2@1.
	
	terniLapilliGame putXAt: 1@2.
	terniLapilliGame putOAt: 2@2.
	
	self assert: terniLapilliGame hasPlayerOWon.! !

!TestTerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'LR 10/14/2019 23:09:34'!
test31XPlayerWinsTheGameWhenThereAreThreeXStonesInAnyRow

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 0@0.
	terniLapilliGame putOAt: 0@1.
	
	terniLapilliGame putXAt: 1@0.
	terniLapilliGame putOAt: 1@1.
	
	terniLapilliGame putXAt: 2@0.
	
	self assert: terniLapilliGame hasPlayerXWon.! !

!TestTerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'LR 10/14/2019 23:11:04'!
test32OPlayerWinsTheGameWhenThereAreThreeOStonesInAnyRow

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 0@2.
	terniLapilliGame putOAt: 0@0.
	
	terniLapilliGame putXAt: 0@1.
	terniLapilliGame putOAt: 1@0.
	
	terniLapilliGame putXAt: 1@2.
	terniLapilliGame putOAt: 2@0.
	
	
	self assert: terniLapilliGame hasPlayerOWon.! !

!TestTerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'LR 10/14/2019 23:15:48'!
test33XPlayerWinsTheGameWhenThereAreThreeXStonesInDiagonalOne

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 0@0.
	terniLapilliGame putOAt: 0@1.
	
	terniLapilliGame putXAt: 1@1.
	terniLapilliGame putOAt: 0@2.
	
	terniLapilliGame putXAt: 2@2.
	
	self assert: terniLapilliGame hasPlayerXWon.! !

!TestTerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'LR 10/14/2019 23:22:18'!
test34OPlayerWinsTheGameWhenThereAreThreeOStonesInDiagonalOne

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 2@1.
	terniLapilliGame putOAt: 0@0.
	
	terniLapilliGame putXAt: 1@0.
	terniLapilliGame putOAt: 1@1.
	
	terniLapilliGame putXAt: 2@0.
	terniLapilliGame putOAt: 2@2.
	
	self assert: terniLapilliGame hasPlayerOWon.! !

!TestTerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'LR 10/14/2019 23:23:29'!
test35XPlayerWinsTheGameWhenThereAreThreeXStonesInDiagonalTwo

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 2@0.
	terniLapilliGame putOAt: 0@1.
	
	terniLapilliGame putXAt: 1@1.
	terniLapilliGame putOAt: 1@2.
	
	terniLapilliGame putXAt: 0@2.
	
	self assert: terniLapilliGame hasPlayerXWon.! !

!TestTerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'LR 10/14/2019 23:25:14'!
test36OPlayerWinsTheGameWhenThereAreThreeOStonesInDiagonalTwo

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 0@1.
	terniLapilliGame putOAt: 2@0.
	
	terniLapilliGame putXAt: 1@2.
	terniLapilliGame putOAt: 1@1.
	
	terniLapilliGame putXAt: 2@1.
	terniLapilliGame putOAt: 0@2.
	
	self assert: terniLapilliGame hasPlayerOWon.! !


!classDefinition: #TerniLapilliBoardSlot category: #'22-TerniLapilli'!
Object subclass: #TerniLapilliBoardSlot
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '22-TerniLapilli'!

!TerniLapilliBoardSlot methodsFor: 'accessing' stamp: 'LR 10/14/2019 22:25:52'!
hasOStone

	self subclassResponsibility.! !

!TerniLapilliBoardSlot methodsFor: 'accessing' stamp: 'LR 10/14/2019 22:25:54'!
hasXStone

	self subclassResponsibility.! !

!TerniLapilliBoardSlot methodsFor: 'accessing' stamp: 'LR 10/14/2019 22:33:49'!
isEmpty

	^self hasOStone not and: [ self hasXStone not ]! !


!classDefinition: #TerniLapilliBoardSlotWithOStone category: #'22-TerniLapilli'!
TerniLapilliBoardSlot subclass: #TerniLapilliBoardSlotWithOStone
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '22-TerniLapilli'!

!TerniLapilliBoardSlotWithOStone methodsFor: 'accessing' stamp: 'LR 10/14/2019 22:25:05'!
hasOStone

	^true! !

!TerniLapilliBoardSlotWithOStone methodsFor: 'accessing' stamp: 'LR 10/14/2019 22:25:01'!
hasXStone

	^false! !


!classDefinition: #TerniLapilliBoardSlotWithXStone category: #'22-TerniLapilli'!
TerniLapilliBoardSlot subclass: #TerniLapilliBoardSlotWithXStone
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '22-TerniLapilli'!

!TerniLapilliBoardSlotWithXStone methodsFor: 'accessing' stamp: 'LR 10/14/2019 22:25:25'!
hasOStone

	^false! !

!TerniLapilliBoardSlotWithXStone methodsFor: 'accessing' stamp: 'LR 10/14/2019 22:25:29'!
hasXStone

	^true! !


!classDefinition: #TerniLapilliBoardSlotWithoutStone category: #'22-TerniLapilli'!
TerniLapilliBoardSlot subclass: #TerniLapilliBoardSlotWithoutStone
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '22-TerniLapilli'!

!TerniLapilliBoardSlotWithoutStone methodsFor: 'accessing' stamp: 'LR 10/14/2019 22:26:08'!
hasOStone

	^false! !

!TerniLapilliBoardSlotWithoutStone methodsFor: 'accessing' stamp: 'LR 10/14/2019 22:26:10'!
hasXStone

	^false! !


!classDefinition: #TerniLapilliGame category: #'22-TerniLapilli'!
Object subclass: #TerniLapilliGame
	instanceVariableNames: 'isXTurn board'
	classVariableNames: ''
	poolDictionaries: ''
	category: '22-TerniLapilli'!

!TerniLapilliGame methodsFor: 'accessing' stamp: 'LR 10/14/2019 23:04:02'!
allStonesAreOAtColumn: aColumnIndex
	
	^(board at: (aColumnIndex@0)) hasOStone
		and: [
			(board at: (aColumnIndex@1)) hasOStone
			and: [
				(board at: (aColumnIndex@2)) hasOStone
			]
		]! !

!TerniLapilliGame methodsFor: 'accessing' stamp: 'LR 10/14/2019 23:22:54'!
allStonesAreOAtDiagonalOne

	^(board at: (0@0)) hasOStone
		and: [
			(board at: (1@1)) hasOStone
			and: [
				(board at: (2@2)) hasOStone
			]
		]! !

!TerniLapilliGame methodsFor: 'accessing' stamp: 'LR 10/14/2019 23:25:54'!
allStonesAreOAtDiagonalTwo

	^(board at: (0@2)) hasOStone
		and: [
			(board at: (1@1)) hasOStone
			and: [
				(board at: (2@0)) hasOStone
			]
		]! !

!TerniLapilliGame methodsFor: 'accessing' stamp: 'LR 10/14/2019 23:11:53'!
allStonesAreOAtRow: aRowIndex
	
	^(board at: (0@aRowIndex)) hasOStone
		and: [
			(board at: (1@aRowIndex)) hasOStone
			and: [
				(board at: (2@aRowIndex)) hasOStone
			]
		]! !

!TerniLapilliGame methodsFor: 'accessing' stamp: 'LR 10/14/2019 23:03:21'!
allStonesAreXAtColumn: aColumnIndex
	
	^(board at: (aColumnIndex@0)) hasXStone
		and: [
			(board at: (aColumnIndex@1)) hasXStone
			and: [
				(board at: (aColumnIndex@2)) hasXStone
			]
		]! !

!TerniLapilliGame methodsFor: 'accessing' stamp: 'LR 10/14/2019 23:21:00'!
allStonesAreXAtDiagonalOne

	^(board at: (0@0)) hasXStone
		and: [
			(board at: (1@1)) hasXStone
			and: [
				(board at: (2@2)) hasXStone
			]
		]! !

!TerniLapilliGame methodsFor: 'accessing' stamp: 'LR 10/14/2019 23:24:21'!
allStonesAreXAtDiagonalTwo

	^(board at: (0@2)) hasXStone
		and: [
			(board at: (1@1)) hasXStone
			and: [
				(board at: (2@0)) hasXStone
			]
		]! !

!TerniLapilliGame methodsFor: 'accessing' stamp: 'LR 10/14/2019 23:09:14'!
allStonesAreXAtRow: aRowIndex
	
	^(board at: (0@aRowIndex)) hasXStone
		and: [
			(board at: (1@aRowIndex)) hasXStone
			and: [
				(board at: (2@aRowIndex)) hasXStone
			]
		]! !

!TerniLapilliGame methodsFor: 'accessing' stamp: 'LR 10/14/2019 23:25:40'!
hasPlayerOWon
	^((self allStonesAreOAtColumn: 0)
	or: [
		(self allStonesAreOAtColumn: 1)
		or: [
			(self allStonesAreOAtColumn: 2)
			or: [
				(self allStonesAreOAtRow: 0)
				or: [
					(self allStonesAreOAtRow: 1)
					or: [
						(self allStonesAreOAtRow: 2)
						or: [
							(self allStonesAreOAtDiagonalOne)
							or: [
								(self allStonesAreOAtDiagonalTwo)
							]
						]
					]
				]
			]
		]
	])! !

!TerniLapilliGame methodsFor: 'accessing' stamp: 'LR 10/14/2019 23:24:10'!
hasPlayerXWon
	^((self allStonesAreXAtColumn: 0)
	or: [
		(self allStonesAreXAtColumn: 1)
		or: [
			(self allStonesAreXAtColumn: 2)
			or: [
				(self allStonesAreXAtRow: 0)
				or: [
					(self allStonesAreXAtRow: 1)
					or: [
						(self allStonesAreXAtRow: 2)
						or: [
							(self allStonesAreXAtDiagonalOne)
							or: [
								(self allStonesAreXAtDiagonalTwo)
							]
						]
					]
				]
			]
		]
	])! !

!TerniLapilliGame methodsFor: 'accessing' stamp: 'LR 10/14/2019 22:34:33'!
isOAt: aPosition 
	
	^(board at: aPosition) hasOStone.! !

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

!TerniLapilliGame methodsFor: 'accessing' stamp: 'LR 10/14/2019 22:34:22'!
isXAt: aPosition 
	
	^(board at: aPosition) hasXStone.! !


!TerniLapilliGame methodsFor: 'initialization' stamp: 'LR 10/14/2019 22:36:21'!
initialize

	isXTurn := true.
	board := Dictionary newFromPairs: {
		0@0 . TerniLapilliBoardSlotWithoutStone new. 0@1 . TerniLapilliBoardSlotWithoutStone new . 0@2 . TerniLapilliBoardSlotWithoutStone new.
		1@0 . TerniLapilliBoardSlotWithoutStone new . 1@1 . TerniLapilliBoardSlotWithoutStone new . 1@2 . TerniLapilliBoardSlotWithoutStone new.
		2@0 . TerniLapilliBoardSlotWithoutStone new . 2@1 . TerniLapilliBoardSlotWithoutStone new . 2@2 . TerniLapilliBoardSlotWithoutStone new.
	}.! !


!TerniLapilliGame methodsFor: 'actions' stamp: 'LR 10/14/2019 20:40:02'!
moveOAt: aPosition to: anotherPosition 
	
	self isPlayingO ifTrue: [ self error: self class playerOCannotMoveStoneBecauseItsThreeStonesAreNotPlacedErrorDescription ].
	self error: self class playerOCannotMoveStoneWhenItIsNotItsTurnErrorDescription.! !

!TerniLapilliGame methodsFor: 'actions' stamp: 'LR 10/10/2019 18:48:02'!
moveXAt: aPosition to: anotherPosition 
	
	self isPlayingX ifTrue: [ self error: self class playerXCannotMoveStoneBecauseItsThreeStonesAreNotPlacedErrorDescription ].
	self error: self class playerXCannotMoveStoneWhenItIsNotItsTurnErrorDescription.! !

!TerniLapilliGame methodsFor: 'actions' stamp: 'LR 10/14/2019 22:35:57'!
putOAt: aPoint 
	
	self isPlayingO ifFalse: [ self error: self class playerOCannotPutStoneWhenItIsNotItsTurnErrorDescription ].

	(board at: aPoint) isEmpty ifFalse: [
		self error: self class playerOCannotPutStoneBecausePositionIsAlreadyUsedErrorDescription
	].

	board at: aPoint put: TerniLapilliBoardSlotWithOStone new.
	
	isXTurn := true.! !

!TerniLapilliGame methodsFor: 'actions' stamp: 'LR 10/14/2019 22:36:09'!
putXAt: aPoint 
	
	self isPlayingX ifFalse: [ self error: self class playerXCannotPutStoneWhenItIsNotItsTurnErrorDescription ].

	(board at: aPoint) isEmpty ifFalse: [
		self error: self class playerXCannotPutStoneBecausePositionIsAlreadyUsedErrorDescription
	].

	board at: aPoint put: TerniLapilliBoardSlotWithXStone new.
	
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
