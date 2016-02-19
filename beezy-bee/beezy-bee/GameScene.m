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
#import "BEESettingsView.h"
#import "BEEScoreView.h"
#import "BEESessionHelper.h"
#import "BEENewGameView.h"
#import "BEEInfoView.h"

@interface GameScene () <SKPhysicsContactDelegate>

@property (nonatomic) NSTimeInterval lastSentTimeInterval;
@property (nonatomic) NSTimeInterval lastSentTimeInterval1Point5;
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;

@end

@implementation GameScene

- (instancetype)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    
    return self;
}

-(void)didMoveToView:(SKView *)view
{
    [self doInit];
    [self addPhysicsWorld];
    [[BEEMainView sharedInstance] createMenuWithParentScene:self];
}

- (void) doInit
{
    self.backgroundColor = [UIColor whiteColor];
}

- (void) addPhysicsWorld
{
    // Adding gravity to the world and making the delegate
    self.physicsWorld.gravity = CGVectorMake( 0.0, -5.0);
    self.physicsWorld.contactDelegate = self;
}

- (void)resetTimerDelegate
{
    self.timerDelegateArr = [NSMutableArray array];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    /* Called when a touch begins */
    
    UITouch *touch = [touches anyObject];
    
    BEE_SCREEN_TYPE currentScreen = [BEESessionHelper sharedInstance].currentScreen;
    
    if (currentScreen == BST_MAIN)
    {
        [[BEEMainView sharedInstance] handleMain:touch andParentScene:self];
    }
    else if (currentScreen == BST_SCORE)
    {
        [[BEEScoreView sharedInstance] handleScore:touch andParentScene:self];
    }
    else if (currentScreen == BST_SETTINGS)
    {
        [[BEESettingsView sharedInstance] handleSettings:touch andParentScene:self];
    }
    else if (currentScreen == BST_GAME)
    {
        if (self.eventsDelegate && [self.eventsDelegate respondsToSelector:@selector(didTap)])
            [self.eventsDelegate didTap];
        
        [[BEENewGameView sharedInstance] handleNewGame:touch andParentScene:self];
    }
    else if (currentScreen == BST_INFO)
    {
        [[BEEInfoView sharedInstance] handleInfo:touch andParentScene:self];
    }
}

- (void)updateWithTimeSinceLastUpdate:(CFTimeInterval)timeSinceLast
{
    self.lastSentTimeInterval += timeSinceLast;
    self.lastSentTimeInterval1Point5 += timeSinceLast;
    
    if (self.lastSentTimeInterval > 1)
    {
        self.lastSentTimeInterval = 0;
        
        for (id<GameSceneTimerDelegate> timerDelegate in self.timerDelegateArr)
        {
            if ([timerDelegate respondsToSelector:@selector(didUpdateTimerWithParentScene:)])
            {
                [timerDelegate didUpdateTimerWithParentScene:self];
            }
        }
    }
    
    if (self.lastSentTimeInterval1Point5 > 1.3)
    {
        self.lastSentTimeInterval1Point5 = 0;
        
        for (id<GameSceneTimerDelegate> timerDelegate in self.timerDelegateArr)
        {
            if ([timerDelegate respondsToSelector:@selector(didUpdateTimerDelayWithParentScene:)])
            {
                [timerDelegate didUpdateTimerDelayWithParentScene:self];
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
    
    for (id<GameSceneTimerDelegate> timerDelegate in self.timerDelegateArr)
    {
        if (timerDelegate && [timerDelegate respondsToSelector:@selector(didUpdateParentScene:)])
        {
            [timerDelegate didUpdateParentScene:self];
        }
    }
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
