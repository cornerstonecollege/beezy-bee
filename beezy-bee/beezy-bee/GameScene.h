//
//  GameScene.h
//  beezy-bee
//

//  Copyright (c) 2016 Ideia do Luiz. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@protocol GameSceneCollisionDelegate <NSObject>

@required
- (void) didCollide;

@end

@protocol GameSceneTimerDelegate <NSObject>

@required
- (void) didUpdateTimer;

@end

@interface GameScene : SKScene

@property (nonatomic, weak) NSMutableArray<id<GameSceneTimerDelegate>> *timerDelegateArray;
@property (nonatomic, weak) NSMutableArray<id<GameSceneCollisionDelegate>> *collisionDelegateArray;

@end
