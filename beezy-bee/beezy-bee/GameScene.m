//
//  GameScene.m
//  beezy-bee
//
//  Created by Luiz Fernando Peres on 2016-01-25.
//  Copyright (c) 2016 Ideia do Luiz. All rights reserved.
//

#import "GameScene.h"
#import "BEEBaseTouchable.h"
#import "BEEMainView.h"

@interface GameScene () <SKPhysicsContactDelegate>

@property (nonatomic) NSTimeInterval lastSentTimeInterval;
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;

@end

@implementation GameScene

-(void)didMoveToView:(SKView *)view
{
    [self doInit];
    [self addPhysicsWorld];
    [[BEEMainView sharedInstance] createMenuWithParentScene:self];
}

- (void) doInit
{
    self.backgroundColor = [UIColor whiteColor];
    self.timerDelegateArray = [NSMutableArray array];
}

- (void) addPhysicsWorld
{
    // Adding gravity to the world and making the delegate
    self.physicsWorld.gravity = CGVectorMake(0,0);
    self.physicsWorld.contactDelegate = self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    /* Called when a touch begins */
    
    //for (UITouch *touch in touches)
    //{
    if (self.eventsDelegate && [self.eventsDelegate respondsToSelector:@selector(didTap)])
        [self.eventsDelegate didTap];
    //}
}

- (void)updateWithTimeSinceLastUpdate:(CFTimeInterval)timeSinceLast
{
    self.lastSentTimeInterval += timeSinceLast;
    if (self.lastSentTimeInterval > 1)
    {
        self.lastSentTimeInterval = 0;
        for (id<GameSceneTimerDelegate> obj in self.timerDelegateArray)
        {
            if ([obj respondsToSelector:@selector(didUpdateTimer)])
            {
                [obj didUpdateTimer];
            }
        }
    }
}

- (void)update:(NSTimeInterval)currentTime {
    // Handle time delta.
    // If we drop below 60fps, we still want everything to move the same distance.
    CFTimeInterval timeSinceLast = currentTime - self.lastUpdateTimeInterval;
    self.lastUpdateTimeInterval = currentTime;
    // more than a second since last update
    if (timeSinceLast > 1)
    {
        timeSinceLast = 1.0 / 60.0;
        self.lastUpdateTimeInterval = currentTime;
    }
    
    [self updateWithTimeSinceLastUpdate:timeSinceLast];
    
}

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    SKPhysicsBody *playerBody = nil;
    playerBody = (contact.bodyA.categoryBitMask & BEE_PLAYER_MASK) != 0 ? contact.bodyA : playerBody;
    playerBody = (contact.bodyB.categoryBitMask & BEE_PLAYER_MASK) != 0 ? contact.bodyB : playerBody;
    
    SKPhysicsBody *monsterBody = nil;
    monsterBody = (contact.bodyA.categoryBitMask & BEE_MONSTER_MASK) != 0 ? contact.bodyA : monsterBody;
    monsterBody = (contact.bodyB.categoryBitMask & BEE_MONSTER_MASK) != 0 ? contact.bodyB : monsterBody;
    
    SKPhysicsBody *itemBody = nil;
    itemBody = (contact.bodyA.categoryBitMask & BEE_ITEM_MASK) != 0 ? contact.bodyA : itemBody;
    itemBody = (contact.bodyB.categoryBitMask & BEE_ITEM_MASK) != 0 ? contact.bodyB : itemBody;
    
    if (playerBody && monsterBody)
    {
        if (self.collisionDelegate && [self.collisionDelegate respondsToSelector:@selector(player:DidCollideWithMonster:)])
            [self.collisionDelegate player:playerBody DidCollideWithMonster:monsterBody];
    }
    else if (playerBody && itemBody)
    {
        if (self.collisionDelegate && [self.collisionDelegate respondsToSelector:@selector(player:DidCollideWithItem:)])
            [self.collisionDelegate player:playerBody DidCollideWithItem:itemBody];
    }
    
    // otherwise ignore
}

@end
