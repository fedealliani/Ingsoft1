!classDefinition: #TestTerniLapilliGame category: #'22-TerniLapilli'!
TestCase subclass: #TestTerniLapilliGame
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '22-TerniLapilli'!

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/16/2019 21:56:26'!
test01FirstMovementCorrespondsToPlayerX

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	self assert: terniLapilliGame isPlayingX.! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/16/2019 21:56:32'!
test02FirstMovementDoesNotCorrespondsToPlayerO

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	self deny: terniLapilliGame isPlayingO.! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/16/2019 21:03:49'!
test03GameIsNotOverWhenItStarts

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	self deny: terniLapilliGame isOver.! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/16/2019 21:03:54'!
test04GameIsTiedWhenItStarts

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	self assert: terniLapilliGame isTied.! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/16/2019 21:56:45'!
test05PlayerXIsNotWinnerWhenGameStarts

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	self deny: terniLapilliGame hasPlayerXWon.! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/16/2019 21:57:12'!
test06PlayerOIsNotWinnerWhenGameStarts

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	self deny: terniLapilliGame hasPlayerOWon.! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/17/2019 01:07:49'!
test07PlayerOCannotPutStoneWhenGameStarts

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	self
		should: [
			terniLapilliGame putOAt: 1@1.
		]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: TerniLapilliGame playerCannotPutStoneWhenItIsNotItsTurnErrorDescription equals: error messageText.
			self deny: (terniLapilliGame isOAt: 1@1).
		]! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/16/2019 21:57:44'!
test08WhenGameStartsAndPlayerXPutStoneNowItIsPlayerOsTurn

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 1@1.
	
	self assert: terniLapilliGame isPlayingO.! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/16/2019 21:57:39'!
test09WhenGameStartsAndPlayerXPutStoneNowItIsNotPlayerXsTurn

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 1@1.
	
	self deny: terniLapilliGame isPlayingX.! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/17/2019 01:06:47'!
test10WhenGameStartsPlayerXCannotMove

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	self
		should: [
			terniLapilliGame moveXAt: 0@0 to: 1@1.
		]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: TerniLapilliGame playerCannotMoveStoneBecauseItsThreeStonesAreNotPlacedErrorDescription equals: error messageText.
			self deny: (terniLapilliGame isXAt: 1@1).
			self deny: (terniLapilliGame isXAt: 0@0).
		]! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/17/2019 01:07:51'!
test11WhenGameStartsPlayerOCannotMove

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	self
		should: [
			terniLapilliGame moveOAt: 0@0 to: 1@1.
		]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: TerniLapilliGame playerCannotMoveStoneWhenItIsNotItsTurnErrorDescription equals: error messageText.
			self deny: (terniLapilliGame isOAt: 1@1).
			self deny: (terniLapilliGame isOAt: 0@0).
		]! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/17/2019 01:07:54'!
test12WhenGameStartsAndPlayerXPutStoneThenPlayerOCannotMove

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 1@1.
	
	self
		should: [
			terniLapilliGame moveOAt: 0@0 to: 0@1.
		]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: TerniLapilliGame playerCannotMoveStoneBecauseItsThreeStonesAreNotPlacedErrorDescription equals: error messageText.
			self deny: (terniLapilliGame isOAt: 0@1).
			self deny: (terniLapilliGame isOAt: 0@0).
		]! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/17/2019 01:07:12'!
test13WhenGameStartsAndPlayerXPutStoneThenPlayerXCannotMove

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 1@1.
	
	self
		should: [
			terniLapilliGame moveXAt: 0@0 to: 0@1.
		]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: TerniLapilliGame playerCannotMoveStoneWhenItIsNotItsTurnErrorDescription equals: error messageText.
			self deny: (terniLapilliGame isXAt: 0@1).
			self deny: (terniLapilliGame isXAt: 0@0).
		]! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/17/2019 01:07:58'!
test14PlayerOCannotPutStoneInAPositionAlreadyUsed

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 1@1.
	
	self
		should: [
			terniLapilliGame putOAt: 1@1.
		]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: TerniLapilliGame playerCannotPutStoneBecausePositionIsAlreadyUsedErrorDescription equals: error messageText.
			self deny: (terniLapilliGame isOAt: 1@1).
			self assert: (terniLapilliGame isXAt: 1@1).
		]! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/16/2019 22:00:23'!
test15ThereIsAnXStoneInTheSamePlaceWherePlayerXDidPutAStone

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 2@2.
	
	self assert: (terniLapilliGame isXAt: 2@2).! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/16/2019 22:00:27'!
test16ThereIsAnOStoneInTheSamePlaceWherePlayerODidPutAStone

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 2@2.
	terniLapilliGame putOAt: 1@2.
	
	self assert: (terniLapilliGame isOAt: 1@2).! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/16/2019 22:00:42'!
test17ThereIsNotAnXStoneInAPlaceWherePlayerODidPutAStone

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 2@2.
	terniLapilliGame putOAt: 2@1.
	
	self deny: (terniLapilliGame isXAt: 2@1).! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/14/2019 20:32:54'!
test18ThereIsNotAnXStoneInAPlaceWhereThereIsNotAnyStone

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	self deny: (terniLapilliGame isXAt: 1@2).! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/16/2019 22:00:56'!
test19ThereIsNotAnOStoneInAPlaceWherePlayerXDidPutAStone

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 2@2.
	
	self deny: (terniLapilliGame isOAt: 2@2).! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/14/2019 20:36:49'!
test20ThereIsNotAnOStoneInAPlaceWhereThereIsNotAnyStone

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	self deny: (terniLapilliGame isOAt: 0@0).! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/16/2019 22:01:11'!
test21WhenPlayerOPutAStoneTheNextTurnCorrespondsToPlayerX

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 0@0.
	terniLapilliGame putOAt: 1@1.
	
	self assert: terniLapilliGame isPlayingX.! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/17/2019 01:07:28'!
test22PlayerXCannotPutStoneInAPositionWhereThereIsAnXStone

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 1@1.
	terniLapilliGame putOAt: 0@1.
	
	self
		should: [
			terniLapilliGame putXAt: 1@1.
		]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: TerniLapilliGame playerCannotPutStoneBecausePositionIsAlreadyUsedErrorDescription equals: error messageText.
		]
	! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/17/2019 01:07:28'!
test23PlayerXCannotPutStoneInAPositionWhereThereIsAnOStone

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 1@1.
	terniLapilliGame putOAt: 0@1.
	
	self
		should: [
			terniLapilliGame putXAt: 0@1.
		]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: TerniLapilliGame playerCannotPutStoneBecausePositionIsAlreadyUsedErrorDescription equals: error messageText.
			self deny: (terniLapilliGame isXAt: 0@1).
			self assert: (terniLapilliGame isOAt: 0@1).
		]! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/17/2019 01:05:56'!
test24PlayerXCannotPutStoneWhenItIsNotItsTurn

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 1@1.
	
	self
		should: [
			terniLapilliGame putXAt: 0@1.
		]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: TerniLapilliGame playerCannotPutStoneWhenItIsNotItsTurnErrorDescription equals: error messageText.
			self deny: (terniLapilliGame isXAt: 0@1).
		]! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/16/2019 22:01:43'!
test25PlayerXWinsTheGameWhenThereAreThreeXStonesInFirstColumn

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 0@0.
	terniLapilliGame putOAt: 1@0.
	
	terniLapilliGame putXAt: 0@1.
	terniLapilliGame putOAt: 1@1.
	
	terniLapilliGame putXAt: 0@2.
	
	self assert: terniLapilliGame hasPlayerXWon.! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/16/2019 22:01:58'!
test26PlayerOWinsTheGameWhenThereAreThreeOStonesInFirstColumn

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 1@0.
	terniLapilliGame putOAt: 0@0.
	
	terniLapilliGame putXAt: 1@1.
	terniLapilliGame putOAt: 0@1.
	
	terniLapilliGame putXAt: 2@2.
	terniLapilliGame putOAt: 0@2.
	
	self assert: terniLapilliGame hasPlayerOWon.! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/16/2019 22:02:02'!
test27PlayerXWinsTheGameWhenThereAreThreeXStonesInSecondColumn

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 1@0.
	terniLapilliGame putOAt: 0@0.
	
	terniLapilliGame putXAt: 1@1.
	terniLapilliGame putOAt: 0@1.
	
	terniLapilliGame putXAt: 1@2.
	
	self assert: terniLapilliGame hasPlayerXWon.! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/16/2019 22:02:06'!
test28PlayerOWinsTheGameWhenThereAreThreeOStonesInSecondColumn

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 0@0.
	terniLapilliGame putOAt: 1@0.
	
	terniLapilliGame putXAt: 0@1.
	terniLapilliGame putOAt: 1@1.
	
	terniLapilliGame putXAt: 2@2.
	terniLapilliGame putOAt: 1@2.
	
	self assert: terniLapilliGame hasPlayerOWon.! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/16/2019 22:02:11'!
test29PlayerXWinsTheGameWhenThereAreThreeXStonesInThirdColumn

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 2@0.
	terniLapilliGame putOAt: 0@0.
	
	terniLapilliGame putXAt: 2@1.
	terniLapilliGame putOAt: 0@1.
	
	terniLapilliGame putXAt: 2@2.
	
	self assert: terniLapilliGame hasPlayerXWon.! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/16/2019 22:02:14'!
test30PlayerOWinsTheGameWhenThereAreThreeOStonesInThirdColumn

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 0@0.
	terniLapilliGame putOAt: 2@0.
	
	terniLapilliGame putXAt: 0@1.
	terniLapilliGame putOAt: 2@1.
	
	terniLapilliGame putXAt: 1@2.
	terniLapilliGame putOAt: 2@2.
	
	self assert: terniLapilliGame hasPlayerOWon.! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/16/2019 22:02:20'!
test31PlayerXWinsTheGameWhenThereAreThreeXStonesInAnyRow

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 0@0.
	terniLapilliGame putOAt: 0@1.
	
	terniLapilliGame putXAt: 1@0.
	terniLapilliGame putOAt: 1@1.
	
	terniLapilliGame putXAt: 2@0.
	
	self assert: terniLapilliGame hasPlayerXWon.! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/16/2019 22:03:45'!
test32PlayerOWinsTheGameWhenThereAreThreeOStonesInAnyRow

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 0@2.
	terniLapilliGame putOAt: 0@0.
	
	terniLapilliGame putXAt: 0@1.
	terniLapilliGame putOAt: 1@0.
	
	terniLapilliGame putXAt: 1@2.
	terniLapilliGame putOAt: 2@0.
	
	
	self assert: terniLapilliGame hasPlayerOWon.! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/16/2019 22:03:40'!
test33PlayerXWinsTheGameWhenThereAreThreeXStonesInDiagonalOne

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 0@0.
	terniLapilliGame putOAt: 0@1.
	
	terniLapilliGame putXAt: 1@1.
	terniLapilliGame putOAt: 0@2.
	
	terniLapilliGame putXAt: 2@2.
	
	self assert: terniLapilliGame hasPlayerXWon.! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/16/2019 22:03:37'!
test34PlayerOWinsTheGameWhenThereAreThreeOStonesInDiagonalOne

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 2@1.
	terniLapilliGame putOAt: 0@0.
	
	terniLapilliGame putXAt: 1@0.
	terniLapilliGame putOAt: 1@1.
	
	terniLapilliGame putXAt: 2@0.
	terniLapilliGame putOAt: 2@2.
	
	self assert: terniLapilliGame hasPlayerOWon.! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/16/2019 22:03:32'!
test35PlayerXWinsTheGameWhenThereAreThreeXStonesInDiagonalTwo

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 2@0.
	terniLapilliGame putOAt: 0@1.
	
	terniLapilliGame putXAt: 1@1.
	terniLapilliGame putOAt: 1@2.
	
	terniLapilliGame putXAt: 0@2.
	
	self assert: terniLapilliGame hasPlayerXWon.! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/16/2019 22:03:27'!
test36PlayerOWinsTheGameWhenThereAreThreeOStonesInDiagonalTwo

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 0@1.
	terniLapilliGame putOAt: 2@0.
	
	terniLapilliGame putXAt: 1@2.
	terniLapilliGame putOAt: 1@1.
	
	terniLapilliGame putXAt: 2@1.
	terniLapilliGame putOAt: 0@2.
	
	self assert: terniLapilliGame hasPlayerOWon.! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/17/2019 01:07:34'!
test37PlayerXCannotPutStoneInAPositionThatIsOutsideTheBoard

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	self
		should: [
			terniLapilliGame putXAt: 99@99.
		]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: TerniLapilliGame playerCannotPutStoneBecausePositionIsInvalidErrorDescription equals: error messageText.
			self deny: (terniLapilliGame isXAt: 99@99).
		]! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/17/2019 01:08:01'!
test38PlayerOCannotPutStoneInAPositionThatIsOutsideTheBoard

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 1@1.

	self
		should: [
			terniLapilliGame putOAt: 99@99.
		]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: TerniLapilliGame playerCannotPutStoneBecausePositionIsInvalidErrorDescription equals: error messageText.
			self deny: (terniLapilliGame isOAt: 99@99).
		]! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/16/2019 22:24:25'!
test39GameIsOverWhenPlayerXWinsTheGame

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.

	self makePlayerXToWinByOnlyPuttingStonesIn: terniLapilliGame.
	
	self assert: terniLapilliGame isOver.! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/16/2019 22:24:12'!
test40GameIsOverWhenPlayerOWinsTheGame

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.

	self makePlayerOToWinByOnlyPuttingStonesIn: terniLapilliGame.
	
	self assert: terniLapilliGame isOver.! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/16/2019 22:24:25'!
test41GameIsNotTiedWhenPlayerXWinsTheGame

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.

	self makePlayerXToWinByOnlyPuttingStonesIn: terniLapilliGame.
	
	self deny: terniLapilliGame isTied.! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/16/2019 22:56:06'!
test42GameIsNotTiedWhenPlayerOWinsTheGame

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.

	self makePlayerOToWinByOnlyPuttingStonesIn: terniLapilliGame.
	
	self deny: terniLapilliGame isTied.! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/17/2019 01:07:23'!
test43PlayerXCannotPutStoneWhenGameIsOver

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	self makePlayerOToWinByOnlyPuttingStonesIn: terniLapilliGame.

	self
		should: [
			terniLapilliGame putXAt: 0@2.
		]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: TerniLapilliGame playerCannotPutStoneBecauseGameIsOverErrorDescription equals: error messageText.
			self deny: (terniLapilliGame isXAt: 0@2).
		]! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/17/2019 01:08:04'!
test44PlayerOCannotPutStoneWhenGameIsOver

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	self makePlayerXToWinByOnlyPuttingStonesIn: terniLapilliGame.

	self
		should: [
			terniLapilliGame putOAt: 1@0.
		]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: TerniLapilliGame playerCannotPutStoneBecauseGameIsOverErrorDescription equals: error messageText.
			self deny: (terniLapilliGame isOAt: 1@0).
		]! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/17/2019 01:06:43'!
test45PlayerXCannotMoveStoneWhenGameIsOver

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	self makePlayerOToWinByOnlyPuttingStonesIn: terniLapilliGame.

	self
		should: [
			terniLapilliGame moveXAt: 1@2 to: 0@2
		]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: TerniLapilliGame playerCannotMoveStoneBecauseGameIsOverErrorDescription equals: error messageText.
			self deny: (terniLapilliGame isXAt: 0@2).
			self assert: (terniLapilliGame isXAt: 1@2).
		]! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/17/2019 01:08:14'!
test46PlayerOCannotMoveStoneWhenGameIsOver

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	self makePlayerXToWinByOnlyPuttingStonesIn: terniLapilliGame.

	self
		should: [
			terniLapilliGame moveOAt: 1@2 to: 2@2
		]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: TerniLapilliGame playerCannotMoveStoneBecauseGameIsOverErrorDescription equals: error messageText.
			self deny: (terniLapilliGame isOAt: 2@2).
			self assert: (terniLapilliGame isOAt: 1@2).
		]! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/17/2019 01:07:17'!
test47PlayerXCannotPutMoreThanThreeStones

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	self makeATieByOnlyPuttingStonesIn: terniLapilliGame.

	self
		should: [
			terniLapilliGame putXAt: 2@2.
		]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: TerniLapilliGame playerCannotPutStoneBecauseAllThreeStonesHaveAlreadyBeenPlacedErrorDescription equals: error messageText.
			self deny: (terniLapilliGame isXAt: 2@2).
		]! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/17/2019 01:51:13'!
test48PlayerXCannotMoveStoneThatIsNotInTheOriginPosition

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	self makeATieByOnlyPuttingStonesIn: terniLapilliGame.
	
	terniLapilliGame moveXAt: 1@0 to: 2@0.
	terniLapilliGame moveOAt: 1@1 to: 2@2.
	
	self
		should: [
			terniLapilliGame moveXAt: 0@0 to: 1@1.
		]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: TerniLapilliGame playerCannotMoveStoneBecauseThereIsNotStoneOfThisPlayerInTheOriginPositionErrorDescription equals: error messageText.
			self deny: (terniLapilliGame isXAt: 0@0).
			self deny: (terniLapilliGame isOAt: 0@0).
			self deny: (terniLapilliGame isXAt: 1@1).
			self assert: (terniLapilliGame isEmptyAt: 1@1).
		]! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/17/2019 02:08:09'!
test49PlayerOCannotMoveStoneThatIsNotInTheOriginPosition

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	self makeATieByOnlyPuttingStonesIn: terniLapilliGame.
	terniLapilliGame moveXAt: 2@1 to: 2@0.
	
	self
		should: [
			terniLapilliGame moveOAt: 2@1 to: 2@2.
		]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: TerniLapilliGame playerCannotMoveStoneBecauseThereIsNotStoneOfThisPlayerInTheOriginPositionErrorDescription equals: error messageText.
			self deny: (terniLapilliGame isXAt: 0@0).
			self deny: (terniLapilliGame isOAt: 0@0).
			self deny: (terniLapilliGame isOAt: 1@0).
			self assert: (terniLapilliGame isXAt: 1@0).
		]! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/17/2019 01:06:54'!
test50PlayerXCannotMoveStoneToAnAlreadyUsedPosition

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	self makeATieByOnlyPuttingStonesIn: terniLapilliGame.

	self
		should: [
			terniLapilliGame moveXAt: 1@0 to: 1@1.
		]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: TerniLapilliGame playerCannotMoveStoneBecauseThereIsAlreadyAStoneInTheDestinyPositionErrorDescription equals: error messageText.
			self assert: (terniLapilliGame isXAt: 1@0).
			self deny: (terniLapilliGame isXAt: 1@1).
			self assert: (terniLapilliGame isOAt: 1@1).
		]! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/17/2019 01:08:33'!
test51PlayerOCannotMoveStoneToAnAlreadyUsedPosition

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	self makeATieByOnlyPuttingStonesIn: terniLapilliGame.
	terniLapilliGame moveXAt: 2@1 to: 2@0.

	self
		should: [
			terniLapilliGame moveOAt: 1@1 to: 1@0.
		]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: TerniLapilliGame playerCannotMoveStoneBecauseThereIsAlreadyAStoneInTheDestinyPositionErrorDescription equals: error messageText.
			self assert: (terniLapilliGame isOAt: 1@1).
			self deny: (terniLapilliGame isOAt: 1@0).
			self assert: (terniLapilliGame isXAt: 1@0).
		]! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/17/2019 01:07:06'!
test52PlayerXCannotMoveStoneBetween0At1And1At0

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	self makeATieByOnlyPuttingStonesIn: terniLapilliGame.
	
	self
		should: [
			terniLapilliGame moveXAt: 1@0 to: 0@1.
		]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: TerniLapilliGame playerCannotMoveStoneBecauseThisMovementIsInvalidErrorDescription equals: error messageText.
		].

	self
		should: [
			terniLapilliGame moveXAt: 0@1 to: 1@0.
		]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: TerniLapilliGame playerCannotMoveStoneBecauseThisMovementIsInvalidErrorDescription equals: error messageText.
		].! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/17/2019 01:07:06'!
test53PlayerXCannotMoveStoneBetween0At1And1At2

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	self makeATieByOnlyPuttingStonesIn: terniLapilliGame.
	
	self
		should: [
			terniLapilliGame moveXAt: 1@2 to: 0@1.
		]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: TerniLapilliGame playerCannotMoveStoneBecauseThisMovementIsInvalidErrorDescription equals: error messageText.
		].

	self
		should: [
			terniLapilliGame moveXAt: 0@1 to: 1@2.
		]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: TerniLapilliGame playerCannotMoveStoneBecauseThisMovementIsInvalidErrorDescription equals: error messageText.
		].! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/17/2019 01:07:06'!
test54PlayerXCannotMoveStoneBetween1At0And2At1

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	self makeATieByOnlyPuttingStonesIn: terniLapilliGame.
	
	self
		should: [
			terniLapilliGame moveXAt: 1@0 to: 2@1.
		]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: TerniLapilliGame playerCannotMoveStoneBecauseThisMovementIsInvalidErrorDescription equals: error messageText.
		].

	self
		should: [
			terniLapilliGame moveXAt: 2@1 to: 1@0.
		]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: TerniLapilliGame playerCannotMoveStoneBecauseThisMovementIsInvalidErrorDescription equals: error messageText.
		].! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/17/2019 01:07:06'!
test55PlayerXCannotMoveStoneBetween1At2And2At1

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	self makeATieByOnlyPuttingStonesIn: terniLapilliGame.
	
	self
		should: [
			terniLapilliGame moveXAt: 1@2 to: 2@1.
		]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: TerniLapilliGame playerCannotMoveStoneBecauseThisMovementIsInvalidErrorDescription equals: error messageText.
		].

	self
		should: [
			terniLapilliGame moveXAt: 2@1 to: 1@2.
		]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: TerniLapilliGame playerCannotMoveStoneBecauseThisMovementIsInvalidErrorDescription equals: error messageText.
		].! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/17/2019 01:07:06'!
test56PlayerXCannotMoveStoneToADistanceGreaterThanOne

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	self makeATieByOnlyPuttingStonesIn: terniLapilliGame.
	
	self
		should: [
			terniLapilliGame moveXAt: 0@0 to: 0@2.
		]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: TerniLapilliGame playerCannotMoveStoneBecauseThisMovementIsInvalidErrorDescription equals: error messageText.
		].

	self
		should: [
			terniLapilliGame moveXAt: 0@0 to: 1@2.
		]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: TerniLapilliGame playerCannotMoveStoneBecauseThisMovementIsInvalidErrorDescription equals: error messageText.
		].
	
	self
		should: [
			terniLapilliGame moveXAt: 0@0 to: 2@2.
		]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: TerniLapilliGame playerCannotMoveStoneBecauseThisMovementIsInvalidErrorDescription equals: error messageText.
		].
! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/17/2019 01:08:43'!
test57PlayerOCannotMoveStoneBetweenSlotsThatAreNotConnected

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	self makeATieByOnlyPuttingStonesIn: terniLapilliGame.
	
	terniLapilliGame moveXAt: 1@0 to: 2@0.
	
	self
		should: [
			terniLapilliGame moveOAt: 1@0 to: 0@1.
		]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: TerniLapilliGame playerCannotMoveStoneBecauseThisMovementIsInvalidErrorDescription equals: error messageText.
		].
	
	self
		should: [
			terniLapilliGame moveOAt: 0@0 to: 0@2.
		]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: TerniLapilliGame playerCannotMoveStoneBecauseThisMovementIsInvalidErrorDescription equals: error messageText.
		].

	self
		should: [
			terniLapilliGame moveOAt: 0@0 to: 1@2.
		]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: TerniLapilliGame playerCannotMoveStoneBecauseThisMovementIsInvalidErrorDescription equals: error messageText.
		].
	
	self
		should: [
			terniLapilliGame moveOAt: 0@0 to: 2@2.
		]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: TerniLapilliGame playerCannotMoveStoneBecauseThisMovementIsInvalidErrorDescription equals: error messageText.
		].! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/17/2019 00:55:10'!
test58PlayerXWinsWhenMovingItsStones

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	self makeATieByOnlyPuttingStonesIn: terniLapilliGame.
	
	terniLapilliGame moveXAt: 1@0 to: 2@0.
	terniLapilliGame moveOAt: 1@1 to: 2@2.
	terniLapilliGame moveXAt: 2@1 to: 1@1.
	
	self assert: terniLapilliGame hasPlayerXWon.! !

!TestTerniLapilliGame methodsFor: 'testing' stamp: 'LR 10/17/2019 01:12:23'!
test59PlayerOCannotPutMoreThanThreeStones

	| terniLapilliGame |
	terniLapilliGame := TerniLapilliGame new.
	
	self makeATieByOnlyPuttingStonesIn: terniLapilliGame.
	terniLapilliGame moveXAt: 2@1 to: 2@2.

	self
		should: [
			terniLapilliGame putOAt: 2@0.
		]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: TerniLapilliGame playerCannotPutStoneBecauseAllThreeStonesHaveAlreadyBeenPlacedErrorDescription equals: error messageText.
			self deny: (terniLapilliGame isOAt: 2@0).
		]! !


!TestTerniLapilliGame methodsFor: 'aux' stamp: 'LR 10/16/2019 22:23:41'!
makeATieByOnlyPuttingStonesIn: aTerniLapilliGame 
	
	aTerniLapilliGame putXAt: 1@0.
	aTerniLapilliGame putOAt: 1@1.
	
	aTerniLapilliGame putXAt: 2@1.
	aTerniLapilliGame putOAt: 1@2.
	
	aTerniLapilliGame putXAt: 0@2.
	aTerniLapilliGame putOAt: 0@1.! !

!TestTerniLapilliGame methodsFor: 'aux' stamp: 'LR 10/16/2019 22:24:12'!
makePlayerOToWinByOnlyPuttingStonesIn: aTerniLapilliGame 
	
	aTerniLapilliGame putXAt: 2@1.
	aTerniLapilliGame putOAt: 0@0.
	
	aTerniLapilliGame putXAt: 1@0.
	aTerniLapilliGame putOAt: 1@1.
	
	aTerniLapilliGame putXAt: 1@2.
	aTerniLapilliGame putOAt: 2@2.! !

!TestTerniLapilliGame methodsFor: 'aux' stamp: 'LR 10/16/2019 22:24:25'!
makePlayerXToWinByOnlyPuttingStonesIn: aTerniLapilliGame 
	
	aTerniLapilliGame putXAt: 2@0.
	aTerniLapilliGame putOAt: 0@1.
	
	aTerniLapilliGame putXAt: 1@1.
	aTerniLapilliGame putOAt: 1@2.
	
	aTerniLapilliGame putXAt: 0@2.! !


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
	instanceVariableNames: 'isXTurn board xStonesCount oStonesCount'
	classVariableNames: ''
	poolDictionaries: ''
	category: '22-TerniLapilli'!

!TerniLapilliGame methodsFor: 'accessing' stamp: 'LR 10/17/2019 02:02:28'!
allStonesAreOAtAnyColumn
	
	^(self allStonesAreOAtColumn: 0)
		or: [
			(self allStonesAreOAtColumn: 1)
				or: [ self allStonesAreOAtColumn: 2 ]
		].! !

!TerniLapilliGame methodsFor: 'accessing' stamp: 'LR 10/17/2019 02:03:02'!
allStonesAreOAtAnyDiagonal
	
	^(self allStonesAreOAtDiagonalOne) or: [ self allStonesAreOAtDiagonalTwo ].! !

!TerniLapilliGame methodsFor: 'accessing' stamp: 'LR 10/17/2019 02:02:06'!
allStonesAreOAtAnyRow
	
	^(self allStonesAreOAtRow: 0)
		or: [
			(self allStonesAreOAtRow: 1)
				or: [ self allStonesAreOAtRow: 2 ]
		].! !

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

!TerniLapilliGame methodsFor: 'accessing' stamp: 'LR 10/17/2019 02:01:31'!
allStonesAreXAtAnyColumn
	
	^(self allStonesAreXAtColumn: 0)
		or: [
			(self allStonesAreXAtColumn: 1)
				or: [ self allStonesAreXAtColumn: 2 ]
		].! !

!TerniLapilliGame methodsFor: 'accessing' stamp: 'LR 10/17/2019 02:03:07'!
allStonesAreXAtAnyDiagonal
	
	^(self allStonesAreXAtDiagonalOne) or: [ self allStonesAreXAtDiagonalTwo ].! !

!TerniLapilliGame methodsFor: 'accessing' stamp: 'LR 10/17/2019 02:01:57'!
allStonesAreXAtAnyRow
	
	^(self allStonesAreXAtRow: 0)
		or: [
			(self allStonesAreXAtRow: 1)
				or: [ self allStonesAreXAtRow: 2 ]
		].! !

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

!TerniLapilliGame methodsFor: 'accessing' stamp: 'LR 10/17/2019 02:09:05'!
hasPlayerOWon
	^ ((self allStonesAreOAtAnyColumn)
		or: [ self allStonesAreOAtAnyRow ]
	) or: [ self allStonesAreOAtAnyDiagonal ].! !

!TerniLapilliGame methodsFor: 'accessing' stamp: 'LR 10/17/2019 02:08:50'!
hasPlayerXWon
	^ ((self allStonesAreXAtAnyColumn)
		or: [ self allStonesAreXAtAnyRow ]
	) or: [ self allStonesAreXAtAnyDiagonal ].! !

!TerniLapilliGame methodsFor: 'accessing' stamp: 'LR 10/16/2019 23:30:51'!
isEmptyAt: aPosition 

	^(board at: aPosition) isEmpty.! !

!TerniLapilliGame methodsFor: 'accessing' stamp: 'LR 10/16/2019 21:21:08'!
isOAt: aPosition 

	board at: aPosition ifAbsent: [ ^false ].
	^(board at: aPosition) hasOStone.! !

!TerniLapilliGame methodsFor: 'accessing' stamp: 'LR 10/16/2019 21:31:25'!
isOver
	
	^ self hasPlayerXWon or: [ self hasPlayerOWon ].! !

!TerniLapilliGame methodsFor: 'accessing' stamp: 'LR 10/14/2019 21:07:03'!
isPlayingO
	
	^ self isPlayingX not! !

!TerniLapilliGame methodsFor: 'accessing' stamp: 'LR 10/10/2019 18:25:37'!
isPlayingX
	
	^ isXTurn.! !

!TerniLapilliGame methodsFor: 'accessing' stamp: 'LR 10/16/2019 21:34:05'!
isTied
	
	^ self isOver not.! !

!TerniLapilliGame methodsFor: 'accessing' stamp: 'LR 10/17/2019 01:00:18'!
isValidMovementBetween: anOriginPosition and: aDestinyPosition

	| dX dY oX oY |
	oX := anOriginPosition x.
	oY := anOriginPosition y.
	dX := aDestinyPosition x.
	dY := aDestinyPosition y.
	
	^ (((oX ~= oY)
		and: [
			((dX = (oX + 1)) and: [ dY = (oY + 1) ])
			or: [
				((dX = (oX - 1)) and: [ dY = (oY - 1) ])
				or: [
					(oX = dY) and: [ oY = dX ]
				]
			]
	])
	or: [
		(anOriginPosition dist: aDestinyPosition) >= 2
	]) not.
	! !

!TerniLapilliGame methodsFor: 'accessing' stamp: 'LR 10/16/2019 21:20:53'!
isXAt: aPosition 

	board at: aPosition ifAbsent: [ ^false ].
	^(board at: aPosition) hasXStone.! !


!TerniLapilliGame methodsFor: 'initialization' stamp: 'LR 10/17/2019 01:44:33'!
initialize

	isXTurn := true.
	board := Dictionary newFromPairs: {
		0@0. TerniLapilliBoardSlotWithoutStone new. 0@1. TerniLapilliBoardSlotWithoutStone new. 0@2. TerniLapilliBoardSlotWithoutStone new.
		1@0. TerniLapilliBoardSlotWithoutStone new. 1@1. TerniLapilliBoardSlotWithoutStone new. 1@2. TerniLapilliBoardSlotWithoutStone new.
		2@0. TerniLapilliBoardSlotWithoutStone new. 2@1. TerniLapilliBoardSlotWithoutStone new. 2@2. TerniLapilliBoardSlotWithoutStone new.
	}.
	xStonesCount := 0.
	oStonesCount := 0.! !


!TerniLapilliGame methodsFor: 'actions' stamp: 'LR 10/17/2019 01:53:43'!
moveOAt: anOriginPosition to: aDestinyPosition 
	
	(self isValidMovementBetween: anOriginPosition and: aDestinyPosition) ifFalse: [ self error: self class playerCannotMoveStoneBecauseThisMovementIsInvalidErrorDescription ].
	self isOver ifTrue: [ self error: self class playerCannotMoveStoneBecauseGameIsOverErrorDescription ].
	(self isEmptyAt: aDestinyPosition) ifFalse: [ self error: self class playerCannotMoveStoneBecauseThereIsAlreadyAStoneInTheDestinyPositionErrorDescription ].
	self isPlayingO ifFalse: [ self error: self class playerCannotMoveStoneWhenItIsNotItsTurnErrorDescription ].
	(xStonesCount < 3) ifTrue: [ self error: self class playerCannotMoveStoneBecauseItsThreeStonesAreNotPlacedErrorDescription ].
	(self isOAt: anOriginPosition) ifFalse: [ self error: self class playerCannotMoveStoneBecauseThereIsNotStoneOfThisPlayerInTheOriginPositionErrorDescription ].
	
	board at: anOriginPosition put: TerniLapilliBoardSlotWithoutStone new.	
	board at: aDestinyPosition put: TerniLapilliBoardSlotWithOStone new.
	
	isXTurn := true.! !

!TerniLapilliGame methodsFor: 'actions' stamp: 'LR 10/17/2019 01:46:49'!
moveXAt: anOriginPosition to: aDestinyPosition 
	
	(self isValidMovementBetween: anOriginPosition and: aDestinyPosition) ifFalse: [ self error: self class playerCannotMoveStoneBecauseThisMovementIsInvalidErrorDescription ].
	self isOver ifTrue: [ self error: self class playerCannotMoveStoneBecauseGameIsOverErrorDescription ].
	(self isEmptyAt: aDestinyPosition) ifFalse: [ self error: self class playerCannotMoveStoneBecauseThereIsAlreadyAStoneInTheDestinyPositionErrorDescription ].
	self isPlayingX ifFalse: [ self error: self class playerCannotMoveStoneWhenItIsNotItsTurnErrorDescription ].
	(xStonesCount < 3) ifTrue: [ self error: self class playerCannotMoveStoneBecauseItsThreeStonesAreNotPlacedErrorDescription ].
	(self isXAt: anOriginPosition) ifFalse: [ self error: self class playerCannotMoveStoneBecauseThereIsNotStoneOfThisPlayerInTheOriginPositionErrorDescription ].
	
	board at: anOriginPosition put: TerniLapilliBoardSlotWithoutStone new.	
	board at: aDestinyPosition put: TerniLapilliBoardSlotWithXStone new.
	
	isXTurn := false.! !

!TerniLapilliGame methodsFor: 'actions' stamp: 'LR 10/17/2019 01:13:30'!
putOAt: aPosition 
	
	self isOver ifTrue: [ self error: self class playerCannotPutStoneBecauseGameIsOverErrorDescription ].
	self isPlayingO ifFalse: [ self error: self class playerCannotPutStoneWhenItIsNotItsTurnErrorDescription ].
	(oStonesCount = 3) ifTrue: [ self error: self class playerCannotPutStoneBecauseAllThreeStonesHaveAlreadyBeenPlacedErrorDescription ].
	board at: aPosition ifAbsent: [ self error: self class playerCannotPutStoneBecausePositionIsInvalidErrorDescription ].
	(board at: aPosition) isEmpty ifFalse: [ self error: self class playerCannotPutStoneBecausePositionIsAlreadyUsedErrorDescription ].
	
	board at: aPosition put: TerniLapilliBoardSlotWithOStone new.
	
	isXTurn := true.
	oStonesCount := oStonesCount + 1.! !

!TerniLapilliGame methodsFor: 'actions' stamp: 'LR 10/17/2019 01:07:34'!
putXAt: aPosition 
	
	self isOver ifTrue: [ self error: self class playerCannotPutStoneBecauseGameIsOverErrorDescription ].
	self isPlayingX ifFalse: [ self error: self class playerCannotPutStoneWhenItIsNotItsTurnErrorDescription ].
	(xStonesCount = 3) ifTrue: [ self error: self class playerCannotPutStoneBecauseAllThreeStonesHaveAlreadyBeenPlacedErrorDescription ].
	board at: aPosition ifAbsent: [ self error: self class playerCannotPutStoneBecausePositionIsInvalidErrorDescription ].
	(board at: aPosition) isEmpty ifFalse: [ self error: self class playerCannotPutStoneBecausePositionIsAlreadyUsedErrorDescription ].
	
	board at: aPosition put: TerniLapilliBoardSlotWithXStone new.
	
	isXTurn := false.
	xStonesCount := xStonesCount + 1.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliGame class' category: #'22-TerniLapilli'!
TerniLapilliGame class
	instanceVariableNames: ''!

!TerniLapilliGame class methodsFor: 'error descriptions' stamp: 'LR 10/17/2019 01:09:18'!
playerCannotMoveStoneBecauseGameIsOverErrorDescription
	
	^ 'Player cannot move a stone because the game is over'! !

!TerniLapilliGame class methodsFor: 'error descriptions' stamp: 'LR 10/17/2019 01:09:22'!
playerCannotMoveStoneBecauseItsThreeStonesAreNotPlacedErrorDescription

	^ 'Player cannot move the stone because its three stones are not placed yet'! !

!TerniLapilliGame class methodsFor: 'error descriptions' stamp: 'LR 10/17/2019 01:09:25'!
playerCannotMoveStoneBecauseThereIsAlreadyAStoneInTheDestinyPositionErrorDescription
	
	^ 'Player cannot move the stone because there is already a stone in the destiny position'! !

!TerniLapilliGame class methodsFor: 'error descriptions' stamp: 'LR 10/17/2019 01:09:43'!
playerCannotMoveStoneBecauseThereIsNotStoneOfThisPlayerInTheOriginPositionErrorDescription
	
	^ 'Player cannot move the stone because there is not a stone of this player in the origin position'! !

!TerniLapilliGame class methodsFor: 'error descriptions' stamp: 'LR 10/17/2019 01:09:48'!
playerCannotMoveStoneBecauseThisMovementIsInvalidErrorDescription
	
	^ 'Player cannot move a stone because this movement is invalid'! !

!TerniLapilliGame class methodsFor: 'error descriptions' stamp: 'LR 10/17/2019 01:09:51'!
playerCannotMoveStoneWhenItIsNotItsTurnErrorDescription
	
	^ 'Player cannot move the stone because it is not its turn'! !

!TerniLapilliGame class methodsFor: 'error descriptions' stamp: 'LR 10/17/2019 01:09:55'!
playerCannotPutStoneBecauseAllThreeStonesHaveAlreadyBeenPlacedErrorDescription
	
	^ 'Player cannot put a stone because all three stones have already been placed'! !

!TerniLapilliGame class methodsFor: 'error descriptions' stamp: 'LR 10/17/2019 01:09:58'!
playerCannotPutStoneBecauseGameIsOverErrorDescription
	
	^ 'Player cannot put a stone because the game is over'! !

!TerniLapilliGame class methodsFor: 'error descriptions' stamp: 'LR 10/17/2019 01:10:01'!
playerCannotPutStoneBecausePositionIsAlreadyUsedErrorDescription
	
	^ 'Player cannot put a stone here because there is another stone in this position'! !

!TerniLapilliGame class methodsFor: 'error descriptions' stamp: 'LR 10/17/2019 01:10:04'!
playerCannotPutStoneBecausePositionIsInvalidErrorDescription
	
	^ 'Player cannot put a stone here because this position is invalid'! !

!TerniLapilliGame class methodsFor: 'error descriptions' stamp: 'LR 10/17/2019 01:05:56'!
playerCannotPutStoneWhenItIsNotItsTurnErrorDescription
	
	^ 'Player cannot put a stone because it is not its turn'! !
