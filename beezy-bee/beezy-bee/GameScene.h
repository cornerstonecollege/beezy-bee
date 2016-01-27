//
//  GameScene.h
//  beezy-bee
//

//  Copyright (c) 2016 Ideia do Luiz. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@protocol GameSceneEvents <NSObject>

@optional
- (void) didTap;

@end

@protocol GameSceneCollisionDelegate <NSObject>

@required
- (void) player:(SKPhysicsBody *)player DidCollideWithMonster:(SKPhysicsBody*) monster;
- (void) player:(SKPhysicsBody *)player DidCollideWithItem:(SKPhysicsBody*) item;

@end

@protocol GameSceneTimerDelegate <NSObject>

@required
- (void) didUpdateTimer;

@end

@interface GameScene : SKScene

@property (nonatomic, weak) NSMutableArray<id<GameSceneTimerDelegate>> *timerDelegateArray;
@property (nonatomic, weak) id<GameSceneCollisionDelegate> collisionDelegate;
@property (nonatomic, weak) id<GameSceneEvents> eventsDelegate;


@end
