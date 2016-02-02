//
//  BEEScoreView.m
//  beezy-bee
//
//  Created by Hiroshi on 1/27/16.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "BEEScoreView.h"
#import "BEEMainView.h"
#import "BEESessionHelper.h"
#import "BEEUtilitiesHelper.h"

@interface BEEScoreView ()

@property (nonatomic) NSMutableArray *objArray;
@property (nonatomic) NSArray *playerArray;

@end

@implementation BEEScoreView

+ (instancetype) sharedInstance
{
    static BEEScoreView *sharedStore;
    
    if (!sharedStore)
        sharedStore = [[self alloc] initPrivate];
    
    return sharedStore;
}

- (instancetype) init
{
    [NSException raise:@"Singleton" format:@"Use [BEEScoreView sharedInstance]"];
    return nil;
}

- (instancetype) initPrivate
{
    self = [super init];
    
    if (self)
    {
        _objArray = [NSMutableArray array];
        _playerArray = @[@"First-Bee", @"Second-Bee"];

    }
    
    return self;
}

- (void) createScoreWithParentScene:(SKScene *)parent
{
    [BEESessionHelper sharedInstance].currentScreen = BST_SCORE;
    parent.physicsWorld.gravity = CGVectorMake(0,0);
    
    SKLabelNode *backLabel = [self createLabelWithParentScene:parent keyForName:@"back"];
    
    
    SKSpriteNode *bg1Color = [SKSpriteNode spriteNodeWithColor:[[BEEUtilitiesHelper sharedInstance] goldColor] size:CGSizeMake(parent.size.width, 30)];
    bg1Color.position = CGPointMake(CGRectGetMidX(parent.frame), CGRectGetMidY(parent.frame) * 1.35 + 10);
    
    SKSpriteNode *bg2Color = [SKSpriteNode spriteNodeWithColor:[[BEEUtilitiesHelper sharedInstance] silverColor] size:CGSizeMake(parent.size.width, 30)];
    bg2Color.position = CGPointMake(CGRectGetMidX(parent.frame), CGRectGetMidY(parent.frame) + 10);

    SKSpriteNode *bg3Color = [SKSpriteNode spriteNodeWithColor:[[BEEUtilitiesHelper sharedInstance] bronzeColor] size:CGSizeMake(parent.size.width, 30)];
    bg3Color.position = CGPointMake(CGRectGetMidX(parent.frame), CGRectGetMidY(parent.frame) * 0.65 + 10);
    
    [self setLabelNode:backLabel position:CGPointMake(backLabel.frame.size.width / 2 + 10, parent.size.height - backLabel.frame.size.height - 10)];
    [parent addChild:bg1Color];
    [parent addChild:bg2Color];
    [parent addChild:bg3Color];
    
    //That is your player
    float dec = 0;
    for (NSInteger playerType=0; playerType<2; playerType++)
    {
        SKTexture* birdTexture1 = [SKTexture textureWithImageNamed:self.playerArray[playerType]];
        birdTexture1.filteringMode = SKTextureFilteringNearest;
        SKTexture* birdTexture2 = [SKTexture textureWithImageNamed:[NSString stringWithFormat:@"%@-Move", self.playerArray[playerType]]];
        birdTexture2.filteringMode = SKTextureFilteringNearest;
        
        SKSpriteNode *player = [SKSpriteNode spriteNodeWithTexture:birdTexture1];
        SKAction* flap = [SKAction repeatActionForever:[SKAction animateWithTextures:@[birdTexture1, birdTexture2] timePerFrame:0.2]];
        player.yScale = 0.35;
        player.xScale = 0.35;
        player.position = CGPointMake(CGRectGetMidX(parent.frame)/2, CGRectGetMidY(parent.frame) * (1.35 - dec) + 10);
        [parent addChild:player];
        [player runAction:flap];
        dec = 0.35;
        
        
        
        __weak SKSpriteNode *weakObj = player;
        [self.objArray addObject:weakObj];
    }
    

}

- (SKLabelNode *) createLabelWithParentScene:(SKScene *)parent keyForName:(NSString *)keyForName
{
    SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:[[BEESessionHelper sharedInstance] getLocalizedStringForName:@"font_style"]];
    label.text = [[BEESessionHelper sharedInstance] getLocalizedStringForName:keyForName];
    label.fontSize = 25;
    label.fontColor = [SKColor blackColor];
    [parent addChild:label];
    
    __weak SKLabelNode *weakLabel = label;
    [self.objArray addObject:weakLabel];
    
    return label;
}

- (void) setLabelNode:(SKLabelNode *)label position:(CGPoint)position
{
    label.position = position;
}

- (void) handleScore:(UITouch *)touch andParentScene:(SKScene *)parent
{
    CGPoint pointScr = [touch locationInNode:parent];
    SKNode *nodeTouched = [parent nodeAtPoint:pointScr];
    
    if ([nodeTouched isKindOfClass:[SKLabelNode class]])
    {
        SKLabelNode *label = (SKLabelNode *) nodeTouched;
        
        if (label.text == [[BEESessionHelper sharedInstance] getLocalizedStringForName:@"back"])
        {
            [self deleteObjectsFromParent];
            [[BEEMainView sharedInstance] createMenuWithParentScene:parent];
        }
    }
}

- (void) deleteObjectsFromParent
{
    if ([self.objArray count] > 0)
    {
        for (SKLabelNode *obj in self.objArray)
            [obj removeFromParent];
        
        self.objArray = [NSMutableArray array];
    }
}

@end
