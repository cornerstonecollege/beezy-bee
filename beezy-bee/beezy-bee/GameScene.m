//
//  GameScene.m
//  beezy-bee
//
//  Created by Luiz Fernando Peres on 2016-01-25.
//  Copyright (c) 2016 Ideia do Luiz. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

-(void)didMoveToView:(SKView *)view
{
    self.backgroundColor = [UIColor whiteColor];
    [self createLabels];
}

// create label

- (void) createLabels
{
    // Setup Start
    SKLabelNode *newGameLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    newGameLabel.text = @"New Game";
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
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

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
