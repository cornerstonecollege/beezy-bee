//
//  GameScene.m
//  beezy-bee
//
//  Created by Luiz Fernando Peres on 2016-01-25.
//  Copyright (c) 2016 Ideia do Luiz. All rights reserved.
//

#import "GameScene.h"
#import "BEESessionHelper.h"

@interface GameScene () <SKPhysicsContactDelegate>

@property (nonatomic) NSTimeInterval lastSentTimeInterval;
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;

@end

@implementation GameScene

-(void)didMoveToView:(SKView *)view
{
    [self doInit];
    [self addPhysicsWorld];
    [self createLabels];
}

- (void) doInit
{
    self.backgroundColor = [UIColor whiteColor];
    self.timerDelegateArray = [NSMutableArray array];
    self.collisionDelegateArray = [NSMutableArray array];
}

- (void) addPhysicsWorld
{
    // Adding gravity to the world and making the delegate
    self.physicsWorld.gravity = CGVectorMake(0,0);
    self.physicsWorld.contactDelegate = self;
}

// create label
- (void) createLabels
{
    // Setup Start
    SKLabelNode *newGameLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    newGameLabel.text = [[BEESessionHelper sharedInstance] getLocalizedStringForName:@"new_game"];
    newGameLabel.fontSize = 45;
    newGameLabel.fontColor = [SKColor blackColor];
    newGameLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                        CGRectGetMidY(self.frame) + 100);
    [self addChild:newGameLabel];
    
    // Setup Setting
    SKLabelNode *settingsLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    settingsLabel.text = @"Settings";
    settingsLabel.fontSize = 45;
    settingsLabel.fontColor = [SKColor blackColor];
    settingsLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                   CGRectGetMidY(self.frame) - 100);
    [self addChild:settingsLabel];
    
    // Setup Score
    SKLabelNode *scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    scoreLabel.text = @"Score";
    scoreLabel.fontSize = 45;
    scoreLabel.fontColor = [SKColor blackColor];
    scoreLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                        CGRectGetMidY(self.frame));
    [self addChild:scoreLabel];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    /* Called when a touch begins */
    
    for (UITouch *touch in touches)
    {
        __unused CGPoint location = [touch locationInNode:self];
        
        /*SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        
        sprite.xScale = 0.5;
        sprite.yScale = 0.5;
        sprite.position = location;
        
        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
        [sprite runAction:[SKAction repeatActionForever:action]];
        
        [self addChild:sprite];*/
    }
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

@end
