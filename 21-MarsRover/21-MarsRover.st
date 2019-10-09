!classDefinition: #TestMarsRover category: #'21-MarsRover'!
TestCase subclass: #TestMarsRover
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!

!TestMarsRover methodsFor: 'testing' stamp: 'FA 10/9/2019 20:26:54'!
test01NewMarsRoverDoesNotChangeInitialPosition
	| marsRover |
	
	marsRover := MarsRover withPosition:10@10 andOrientation: North new.
	
	self assert: 10@10 equals: marsRover position.! !

!TestMarsRover methodsFor: 'testing' stamp: 'FA 10/9/2019 20:40:10'!
test02NewMarsRoverDoesNotChangeOrientation
	| marsRover |
	
	
	marsRover := MarsRover withPosition:10@10 andOrientation:North new.
	
	self assert: North new equals: marsRover orientation.! !

!TestMarsRover methodsFor: 'testing' stamp: 'FA 10/9/2019 20:27:02'!
test03WhenReceivingAnFCommandMarsRoverMovesForwardOnePoint
	| marsRover |
	
	marsRover := MarsRover withPosition:10@10 andOrientation:North new.
	
	marsRover do:'f'.
	
	self assert: 10@11 equals: marsRover position.! !

!TestMarsRover methodsFor: 'testing' stamp: 'FA 10/9/2019 20:27:05'!
test04WhenReceivingABCommandMarsRoverMovesBackwardsOnePoint
	| marsRover |
	
	marsRover := MarsRover withPosition:10@10 andOrientation:North new.
	
	marsRover do:'b'.
	
	self assert: 10@9 equals: marsRover position.! !

!TestMarsRover methodsFor: 'testing' stamp: 'FA 10/9/2019 20:43:58'!
test05WhenReceivingALCommandMarsRoverRotateOrientation90DegreesToLeft
	| marsRover |
	
	marsRover := MarsRover withPosition:10@10 andOrientation:North new.
	
	marsRover do:'l'.
	
	self assert: West new equals: marsRover orientation.! !

!TestMarsRover methodsFor: 'testing' stamp: 'FA 10/9/2019 20:44:08'!
test06WhenReceivingARCommandMarsRoverRotateOrientation90DegreesToRight
	| marsRover |
	
	marsRover := MarsRover withPosition:10@10 andOrientation:North new.
	
	marsRover do:'r'.
	
	self assert: East new equals: marsRover orientation.! !

!TestMarsRover methodsFor: 'testing' stamp: 'FA 10/10/2019 00:32:40'!
test07WhenReceivingAPCommandMarsRoverStopExecution
	| marsRover |
	
	marsRover := MarsRover withPosition:10@10 andOrientation:North new.
	
	self should: [marsRover do:'p'.] raise:Error - MessageNotUnderstood  withMessageText: (MarsRover invalidCommandErrorMessage).! !

!TestMarsRover methodsFor: 'testing' stamp: 'FA 10/10/2019 00:32:52'!
test08WhenReceivingAQCommandMarsRoverStopExecution
	| marsRover |
	
	marsRover := MarsRover withPosition:10@10 andOrientation:North new.
	
	self should: [marsRover do:'q'.] raise:Error - MessageNotUnderstood  withMessageText: (MarsRover invalidCommandErrorMessage).! !

!TestMarsRover methodsFor: 'testing' stamp: 'FA 10/10/2019 00:32:57'!
test09WhenReceivingACCommandMarsRoverStopExecution
	| marsRover |
	
	marsRover := MarsRover withPosition:10@10 andOrientation:North new.
	
	self should: [marsRover do:'c'.] raise:Error - MessageNotUnderstood  withMessageText: (MarsRover invalidCommandErrorMessage).! !

!TestMarsRover methodsFor: 'testing' stamp: 'FA 10/9/2019 20:27:31'!
test10WhenReceivingABAndFCommandMarsRoverMaintainSamePosition
	| marsRover |
	
	marsRover := MarsRover withPosition:10@10 andOrientation:North new.
	
	marsRover do: 'bf'.
	
	self assert: 10@10 equals: marsRover position.! !

!TestMarsRover methodsFor: 'testing' stamp: 'FA 10/9/2019 20:27:35'!
test11WhenReceivingAFAndBCommandMarsRoverMaintainSamePosition
	| marsRover |
	
	marsRover := MarsRover withPosition:10@10 andOrientation:North new.
	
	marsRover do: 'fb'.
	
	self assert: 10@10 equals: marsRover position.! !

!TestMarsRover methodsFor: 'testing' stamp: 'FA 10/9/2019 20:27:38'!
test12WhenReceivingAFAndFCommandMarsRoverMovesForwardTwoPoints
	| marsRover |
	
	marsRover := MarsRover withPosition:10@10 andOrientation:North new.
	
	marsRover do: 'ff'.
	
	self assert: 10@12 equals: marsRover position.! !

!TestMarsRover methodsFor: 'testing' stamp: 'FA 10/9/2019 20:27:41'!
test13WhenReceivingABAndBCommandMarsRoverMovesBackwardsTwoPoints
	| marsRover |
	
	marsRover := MarsRover withPosition:0@0 andOrientation:North new.
	
	marsRover do: 'bb'.
	
	self assert: 0@-2 equals: marsRover position.! !

!TestMarsRover methodsFor: 'testing' stamp: 'FA 10/9/2019 20:27:57'!
test14WhenReceivingABAndBCommandMarsRoverMovesBackwardsTwoPointsWithEastOrientation
	| marsRover |
	
	marsRover := MarsRover withPosition:0@0 andOrientation:East new.
	
	marsRover do: 'bb'.
	
	self assert: -2@0 equals: marsRover position.! !

!TestMarsRover methodsFor: 'testing' stamp: 'FA 10/9/2019 20:28:05'!
test15WhenReceivingABAndBCommandMarsRoverMovesBackwardsTwoPointsWithWestOrientation
	| marsRover |
	
	marsRover := MarsRover withPosition:0@0 andOrientation:West new.
	
	marsRover do: 'bb'.
	
	self assert: 2@0 equals: marsRover position.! !

!TestMarsRover methodsFor: 'testing' stamp: 'FA 10/9/2019 20:28:10'!
test16WhenReceivingABAndBCommandMarsRoverMovesBackwardsTwoPointsWithSouthOrientation
	| marsRover |
	
	marsRover := MarsRover withPosition:0@0 andOrientation:South new.
	
	marsRover do: 'bb'.
	
	self assert: 0@2 equals: marsRover position.! !

!TestMarsRover methodsFor: 'testing' stamp: 'FA 10/9/2019 20:44:13'!
test17WhenReceivingARCommandMarsRoverRotateOrientation90DegreesToRightWithSouthOrientation
	| marsRover |
	
	marsRover := MarsRover withPosition:10@10 andOrientation:South new.
	
	marsRover do:'r'.
	
	self assert: West new equals: marsRover orientation.! !

!TestMarsRover methodsFor: 'testing' stamp: 'FA 10/9/2019 20:44:17'!
test18WhenReceivingALCommandMarsRoverRotateOrientation90DegreesToLeftWithSouthOrientation
	| marsRover |
	
	marsRover := MarsRover withPosition:10@10 andOrientation:South new.
	
	marsRover do:'l'.
	
	self assert: East new equals: marsRover orientation.! !

!TestMarsRover methodsFor: 'testing' stamp: 'FA 10/9/2019 20:44:21'!
test19WhenReceivingALCommandMarsRoverRotateOrientation90DegreesToLeftWithWestOrientation
	| marsRover |
	
	marsRover := MarsRover withPosition:10@10 andOrientation:West new.
	
	marsRover do:'l'.
	
	self assert: South new equals: marsRover orientation.! !

!TestMarsRover methodsFor: 'testing' stamp: 'FA 10/9/2019 20:44:26'!
test20WhenReceivingALCommandMarsRoverRotateOrientation90DegreesToRigthWithWestOrientation
	| marsRover |
	
	marsRover := MarsRover withPosition:10@10 andOrientation:West new.
	
	marsRover do:'r'.
	
	self assert: North new equals: marsRover orientation.! !

!TestMarsRover methodsFor: 'testing' stamp: 'FA 10/9/2019 20:44:33'!
test21WhenReceivingALCommandMarsRoverRotateOrientation90DegreesToRigthWithEastOrientation
	| marsRover |
	
	marsRover := MarsRover withPosition:10@10 andOrientation:East new.
	
	marsRover do:'r'.
	
	self assert: South new equals: marsRover orientation.! !

!TestMarsRover methodsFor: 'testing' stamp: 'FA 10/9/2019 20:44:38'!
test22WhenReceivingALCommandMarsRoverRotateOrientation90DegreesToLeftWithEastOrientation
	| marsRover |
	
	marsRover := MarsRover withPosition:10@10 andOrientation:East new.
	
	marsRover do:'l'.
	
	self assert: North new equals: marsRover orientation.! !

!TestMarsRover methodsFor: 'testing' stamp: 'FA 10/9/2019 23:21:26'!
test23MarsRoversChangesPositionUntilAnInvalidCommandIsReceive
	| marsRover |
	
	marsRover := MarsRover withPosition:10@10 andOrientation:North new.
	self should: [marsRover do:'lfrbxfx'] raise:Error - MessageNotUnderstood   withExceptionDo: [:exception | self assert: 9@9 equals: marsRover position.].
	! !

!TestMarsRover methodsFor: 'testing' stamp: 'FA 10/9/2019 23:23:13'!
test24MarsRoversChangesOrientationUntilAnInvalidCommandIsReceive
	| marsRover |
	
	marsRover := MarsRover withPosition:10@10 andOrientation:North new.
	self should: [marsRover do:'lllfrfbxrx'] raise:Error - MessageNotUnderstood   withExceptionDo: [:exception | self assert: South new equals: marsRover orientation .].
	! !

!TestMarsRover methodsFor: 'testing' stamp: 'FA 10/9/2019 23:24:30'!
test25MarsRoversNotChangesOrientationOnEmptySequenceCommands
	| marsRover |
	
	marsRover := MarsRover withPosition:10@10 andOrientation:South new.
	marsRover  do: ''.
	self assert: South new equals: marsRover orientation.
	! !

!TestMarsRover methodsFor: 'testing' stamp: 'FA 10/9/2019 23:24:59'!
test26MarsRoversNotChangesPositionOnEmptySequenceCommands
	| marsRover |
	
	marsRover := MarsRover withPosition:10@10 andOrientation:South new.
	marsRover  do: ''.
	self assert: 10@10 equals: marsRover position.
	! !


!classDefinition: #CardinalDirection category: #'21-MarsRover'!
Object subclass: #CardinalDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!


!CardinalDirection methodsFor: 'action' stamp: 'FA 10/9/2019 23:28:37'!
rotateLeft
	self subclassResponsibility.! !

!CardinalDirection methodsFor: 'action' stamp: 'FA 10/9/2019 23:28:49'!
rotateRight
	self subclassResponsibility.! !


!CardinalDirection methodsFor: 'accesing' stamp: 'FA 10/9/2019 23:29:09'!
xCoordinateVariationOnBackwards
	self subclassResponsibility .! !

!CardinalDirection methodsFor: 'accesing' stamp: 'FA 10/9/2019 23:29:29'!
xCoordinateVariationOnForward
	self subclassResponsibility .! !

!CardinalDirection methodsFor: 'accesing' stamp: 'FA 10/9/2019 23:29:38'!
yCoordinateVariationOnBackwards
	self subclassResponsibility .! !

!CardinalDirection methodsFor: 'accesing' stamp: 'FA 10/9/2019 23:29:46'!
yCoordinateVariationOnForward
	self subclassResponsibility .! !


!classDefinition: #East category: #'21-MarsRover'!
CardinalDirection subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!

!East methodsFor: 'action' stamp: 'FA 10/9/2019 23:27:49'!
rotateLeft
	^North new.! !

!East methodsFor: 'action' stamp: 'FA 10/9/2019 20:33:37'!
rotateRight
	^South new.! !


!East methodsFor: 'accessing' stamp: 'FA 10/9/2019 21:00:48'!
xCoordinateVariationOnBackwards
	^-1.! !

!East methodsFor: 'accessing' stamp: 'FA 10/9/2019 21:04:09'!
xCoordinateVariationOnForward
	^1.! !

!East methodsFor: 'accessing' stamp: 'FA 10/9/2019 21:01:41'!
yCoordinateVariationOnBackwards
	^0.! !

!East methodsFor: 'accessing' stamp: 'FA 10/9/2019 21:04:16'!
yCoordinateVariationOnForward
	^0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'East class' category: #'21-MarsRover'!
East class
	instanceVariableNames: 'uniqueInstance'!

!East class methodsFor: 'class initialization' stamp: 'FA 10/9/2019 23:37:55'!
initialize
	uniqueInstance := self basicNew.! !

!East class methodsFor: 'class initialization' stamp: 'FA 10/9/2019 23:38:06'!
new
	^uniqueInstance.! !


!classDefinition: #North category: #'21-MarsRover'!
CardinalDirection subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!

!North methodsFor: 'action' stamp: 'FA 10/9/2019 20:32:15'!
rotateLeft
	^West new.! !

!North methodsFor: 'action' stamp: 'FA 10/9/2019 20:33:52'!
rotateRight
	^East new.! !


!North methodsFor: 'accessing' stamp: 'FA 10/9/2019 20:59:54'!
xCoordinateVariationOnBackwards
	^0.! !

!North methodsFor: 'accessing' stamp: 'FA 10/9/2019 21:04:28'!
xCoordinateVariationOnForward
	^0.! !

!North methodsFor: 'accessing' stamp: 'FA 10/9/2019 21:00:18'!
yCoordinateVariationOnBackwards
	^-1.! !

!North methodsFor: 'accessing' stamp: 'FA 10/9/2019 21:04:32'!
yCoordinateVariationOnForward
	^1.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'North class' category: #'21-MarsRover'!
North class
	instanceVariableNames: 'uniqueInstance'!

!North class methodsFor: 'class initialization' stamp: 'FA 10/9/2019 23:33:22'!
initialize
	uniqueInstance := self basicNew.! !

!North class methodsFor: 'class initialization' stamp: 'FA 10/9/2019 23:31:33'!
new
	^uniqueInstance.! !


!classDefinition: #South category: #'21-MarsRover'!
CardinalDirection subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!

!South methodsFor: 'accessing' stamp: 'FA 10/9/2019 21:02:14'!
xCoordinateVariationOnBackwards
	^0.! !

!South methodsFor: 'accessing' stamp: 'FA 10/9/2019 21:04:43'!
xCoordinateVariationOnForward
	^0.! !

!South methodsFor: 'accessing' stamp: 'FA 10/9/2019 21:02:31'!
yCoordinateVariationOnBackwards
	^1.! !

!South methodsFor: 'accessing' stamp: 'FA 10/9/2019 21:04:48'!
yCoordinateVariationOnForward
	^-1.! !


!South methodsFor: 'action' stamp: 'FA 10/9/2019 20:32:24'!
rotateLeft
	^East new.! !

!South methodsFor: 'action' stamp: 'FA 10/9/2019 20:34:04'!
rotateRight
	^West new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'South class' category: #'21-MarsRover'!
South class
	instanceVariableNames: 'uniqueInstance'!

!South class methodsFor: 'class initialization' stamp: 'FA 10/9/2019 23:38:19'!
initialize
	uniqueInstance := self basicNew.! !

!South class methodsFor: 'class initialization' stamp: 'FA 10/9/2019 23:38:26'!
new
	^uniqueInstance.! !


!classDefinition: #West category: #'21-MarsRover'!
CardinalDirection subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!

!West methodsFor: 'accessing' stamp: 'FA 10/9/2019 21:02:55'!
xCoordinateVariationOnBackwards
	^1.! !

!West methodsFor: 'accessing' stamp: 'FA 10/9/2019 21:05:06'!
xCoordinateVariationOnForward
	^-1.! !

!West methodsFor: 'accessing' stamp: 'FA 10/9/2019 21:03:02'!
yCoordinateVariationOnBackwards
	^0.! !

!West methodsFor: 'accessing' stamp: 'FA 10/9/2019 21:05:11'!
yCoordinateVariationOnForward
	^0.! !


!West methodsFor: 'action' stamp: 'FA 10/9/2019 20:33:21'!
rotateLeft
	^South new.! !

!West methodsFor: 'action' stamp: 'FA 10/9/2019 20:34:15'!
rotateRight
	^North new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'West class' category: #'21-MarsRover'!
West class
	instanceVariableNames: 'uniqueInstance'!

!West class methodsFor: 'class initialization' stamp: 'FA 10/9/2019 23:38:41'!
initialize
	uniqueInstance := self basicNew.! !

!West class methodsFor: 'class initialization' stamp: 'FA 10/9/2019 23:38:47'!
new
	^uniqueInstance.! !


!classDefinition: #Command category: #'21-MarsRover'!
Object subclass: #Command
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!

!Command methodsFor: 'action' stamp: 'FA 10/10/2019 00:18:43'!
executeOn:aMarsRover
	self subclassResponsibility .! !


!classDefinition: #BackwardsCommand category: #'21-MarsRover'!
Command subclass: #BackwardsCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!

!BackwardsCommand methodsFor: 'action' stamp: 'FA 10/10/2019 00:16:53'!
executeOn:aMarsRover
	aMarsRover moveBackwards.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BackwardsCommand class' category: #'21-MarsRover'!
BackwardsCommand class
	instanceVariableNames: 'uniqueInstance'!

!BackwardsCommand class methodsFor: 'class initialization' stamp: 'FA 10/10/2019 00:02:48'!
initialize
	uniqueInstance := self basicNew.! !

!BackwardsCommand class methodsFor: 'class initialization' stamp: 'FA 10/10/2019 00:37:29'!
new
	^uniqueInstance.! !


!classDefinition: #ForwardCommand category: #'21-MarsRover'!
Command subclass: #ForwardCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!

!ForwardCommand methodsFor: 'action' stamp: 'FA 10/10/2019 00:17:18'!
executeOn:aMarsRover
	aMarsRover moveForward.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ForwardCommand class' category: #'21-MarsRover'!
ForwardCommand class
	instanceVariableNames: 'uniqueInstance'!

!ForwardCommand class methodsFor: 'class initialization' stamp: 'FA 10/10/2019 00:37:44'!
initialize
	uniqueInstance := self basicNew.! !

!ForwardCommand class methodsFor: 'class initialization' stamp: 'FA 10/10/2019 00:37:53'!
new
	^uniqueInstance.! !


!classDefinition: #RotateLeftCommand category: #'21-MarsRover'!
Command subclass: #RotateLeftCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!

!RotateLeftCommand methodsFor: 'action' stamp: 'FA 10/10/2019 00:17:38'!
executeOn:aMarsRover
	aMarsRover rotateLeft .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RotateLeftCommand class' category: #'21-MarsRover'!
RotateLeftCommand class
	instanceVariableNames: 'uniqueInstance'!

!RotateLeftCommand class methodsFor: 'class initialization' stamp: 'FA 10/10/2019 00:38:12'!
initialize
	uniqueInstance := self basicNew.! !

!RotateLeftCommand class methodsFor: 'class initialization' stamp: 'FA 10/10/2019 00:38:20'!
new
	^uniqueInstance.! !


!classDefinition: #RotateRightCommand category: #'21-MarsRover'!
Command subclass: #RotateRightCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!

!RotateRightCommand methodsFor: 'action' stamp: 'FA 10/10/2019 00:17:58'!
executeOn:aMarsRover
	aMarsRover rotateRight.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RotateRightCommand class' category: #'21-MarsRover'!
RotateRightCommand class
	instanceVariableNames: 'uniqueInstance'!

!RotateRightCommand class methodsFor: 'class initialization' stamp: 'FA 10/10/2019 00:38:34'!
initialize
	uniqueInstance := self basicNew.! !

!RotateRightCommand class methodsFor: 'class initialization' stamp: 'FA 10/10/2019 00:38:41'!
new
	^uniqueInstance.! !


!classDefinition: #Direction category: #'21-MarsRover'!
Object subclass: #Direction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!

!Direction methodsFor: 'accessing' stamp: 'FA 10/9/2019 23:40:20'!
xCoordinateVariationOn: aCardinalDirection
	self subclassResponsibility.! !

!Direction methodsFor: 'accessing' stamp: 'FA 10/9/2019 23:40:37'!
yCoordinateVariationOn: aCardinalDirection
	self subclassResponsibility.! !


!classDefinition: #BackwardsDirection category: #'21-MarsRover'!
Direction subclass: #BackwardsDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!

!BackwardsDirection methodsFor: 'accessing' stamp: 'FA 10/9/2019 21:19:46'!
xCoordinateVariationOn: aCardinalDirection
	^ aCardinalDirection xCoordinateVariationOnBackwards.! !

!BackwardsDirection methodsFor: 'accessing' stamp: 'FA 10/9/2019 21:20:11'!
yCoordinateVariationOn: aCardinalDirection
	^ aCardinalDirection yCoordinateVariationOnBackwards.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BackwardsDirection class' category: #'21-MarsRover'!
BackwardsDirection class
	instanceVariableNames: 'uniqueInstance'!

!BackwardsDirection class methodsFor: 'class initialization' stamp: 'FA 10/9/2019 23:41:21'!
initialize
	uniqueInstance := self basicNew.! !

!BackwardsDirection class methodsFor: 'class initialization' stamp: 'FA 10/9/2019 23:41:29'!
new
	^uniqueInstance.! !


!classDefinition: #ForwardDirection category: #'21-MarsRover'!
Direction subclass: #ForwardDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!

!ForwardDirection methodsFor: 'accessing' stamp: 'FA 10/9/2019 21:20:43'!
xCoordinateVariationOn: aCardinalDirection
	^ aCardinalDirection xCoordinateVariationOnForward.! !

!ForwardDirection methodsFor: 'accessing' stamp: 'FA 10/9/2019 21:20:48'!
yCoordinateVariationOn: aCardinalDirection
	^ aCardinalDirection yCoordinateVariationOnForward.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ForwardDirection class' category: #'21-MarsRover'!
ForwardDirection class
	instanceVariableNames: 'uniqueInstance'!

!ForwardDirection class methodsFor: 'class initialization' stamp: 'FA 10/9/2019 23:41:43'!
initialize
	uniqueInstance := self basicNew.! !

!ForwardDirection class methodsFor: 'class initialization' stamp: 'FA 10/9/2019 23:41:50'!
new
	^uniqueInstance.! !


!classDefinition: #MarsRover category: #'21-MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position orientation'
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'FA 10/8/2019 19:56:43'!
initializeWithPosition: aPosition andOrientation: anOrientation 
	position:= aPosition.
	orientation:=anOrientation.! !


!MarsRover methodsFor: 'accessing' stamp: 'FA 10/8/2019 19:58:43'!
orientation
	^orientation! !

!MarsRover methodsFor: 'accessing' stamp: 'FA 10/8/2019 19:55:22'!
position
	^position.! !


!MarsRover methodsFor: 'actions' stamp: 'FA 10/10/2019 00:31:57'!
do: aCharacterSequence
	aCharacterSequence do:[ :aCharacter | 
		(self class commandsFromCharacters at:aCharacter  ifAbsent:[self error: self class invalidCommandErrorMessage.] ) executeOn:self.
		].
	! !

!MarsRover methodsFor: 'actions' stamp: 'FA 10/9/2019 21:23:27'!
move: aDirection
	|x y|
	x:= position x.
	y:= position y.
	x := x + (aDirection xCoordinateVariationOn: orientation).
	y := y + (aDirection yCoordinateVariationOn: orientation).
	position := x@y.! !

!MarsRover methodsFor: 'actions' stamp: 'FA 10/10/2019 00:01:57'!
moveBackwards
	self move: BackwardsDirection new.! !

!MarsRover methodsFor: 'actions' stamp: 'FA 10/10/2019 00:02:12'!
moveForward
	self move: ForwardDirection new.! !

!MarsRover methodsFor: 'actions' stamp: 'FA 10/9/2019 20:35:03'!
rotateLeft
	orientation:=orientation rotateLeft.
	! !

!MarsRover methodsFor: 'actions' stamp: 'FA 10/9/2019 20:35:34'!
rotateRight
	orientation:=orientation rotateRight .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #'21-MarsRover'!
MarsRover class
	instanceVariableNames: 'commandsFromCharacters'!

!MarsRover class methodsFor: 'class initialization' stamp: 'FA 10/10/2019 00:21:38'!
initialize
	commandsFromCharacters := Dictionary newFromPairs: {
	 	$f.ForwardCommand new.$b.BackwardsCommand new .$l.RotateLeftCommand new .$r.RotateRightCommand new
	}.! !


!MarsRover class methodsFor: 'instance creation' stamp: 'FA 10/8/2019 19:57:11'!
withPosition: aPosition andOrientation: anOrientation 
	^self new initializeWithPosition:aPosition andOrientation:anOrientation.! !


!MarsRover class methodsFor: 'error descriptions' stamp: 'FA 10/10/2019 00:29:42'!
invalidCommandErrorMessage
	^'Invalid command'.! !


!MarsRover class methodsFor: 'accessing' stamp: 'FA 10/10/2019 00:08:32'!
commandsFromCharacters
	^commandsFromCharacters .! !

East initialize!
North initialize!
South initialize!
West initialize!
BackwardsCommand initialize!
ForwardCommand initialize!
RotateLeftCommand initialize!
RotateRightCommand initialize!
BackwardsDirection initialize!
ForwardDirection initialize!
MarsRover initialize!