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
#import "BEESharedPreferencesHelper.h"
#import "BEEPlayer.h"

@interface BEEScoreView ()

@property (nonatomic) NSMutableArray *objArray;

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
    }
    
    return self;
}

- (void) createScoreWithParentScene:(SKScene *)parent
{
    [BEESessionHelper sharedInstance].currentScreen = BST_SCORE;
    
    SKLabelNode *backLabel = [self createLabelWithParentScene:parent keyForName:@"back"];
    
    SKSpriteNode *bg1Color = [SKSpriteNode spriteNodeWithColor:[[BEEUtilitiesHelper sharedInstance] goldColor] size:CGSizeMake(parent.size.width, 80)];
    bg1Color.position = CGPointMake(CGRectGetMidX(parent.frame), CGRectGetMidY(parent.frame) * 1.35);
    
    SKSpriteNode *bg2Color = [SKSpriteNode spriteNodeWithColor:[[BEEUtilitiesHelper sharedInstance] silverColor] size:CGSizeMake(parent.size.width, 80)];
    bg2Color.position = CGPointMake(CGRectGetMidX(parent.frame), CGRectGetMidY(parent.frame));

    SKSpriteNode *bg3Color = [SKSpriteNode spriteNodeWithColor:[[BEEUtilitiesHelper sharedInstance] bronzeColor] size:CGSizeMake(parent.size.width, 80)];
    bg3Color.position = CGPointMake(CGRectGetMidX(parent.frame), CGRectGetMidY(parent.frame) * 0.65);
    
    [self setLabelNode:backLabel position:CGPointMake(backLabel.frame.size.width / 2 + 10, parent.size.height - backLabel.frame.size.height - 10)];
    [parent addChild:bg1Color];
    [parent addChild:bg2Color];
    [parent addChild:bg3Color];
    
    
    NSDictionary *scores = [[BEESharedPreferencesHelper sharedInstance] getScores];
    NSArray *keysOrdered = [scores keysSortedByValueUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj2 compare:obj1];
    }];
    
    //That is your player
    float dec = 0;
    for (NSNumber *type in keysOrdered)
    {
        BEE_PLAYER_TYPE playerType = [type unsignedIntegerValue];
        NSNumber *value = scores[type];
        

        SKLabelNode *scoreLabel = [self createLabelWithParentScene:parent keyForName:@""];
        scoreLabel.text = [value stringValue];
        scoreLabel.fontSize = 70;

        [self setLabelNode:scoreLabel position:CGPointMake(CGRectGetMidX(parent.frame) * 1.5, CGRectGetMidY(parent.frame) * (1.35 - dec) -  scoreLabel.frame.size.height / 2)];
        
        SKTexture* birdTexture1 = [SKTexture textureWithImageNamed:[[BEEPlayer playerArray] objectAtIndex:playerType]];
        birdTexture1.filteringMode = SKTextureFilteringNearest;
        SKTexture* birdTexture2 = [SKTexture textureWithImageNamed:[NSString stringWithFormat:@"%@-Move", [[BEEPlayer playerArray] objectAtIndex:playerType]]];
        birdTexture2.filteringMode = SKTextureFilteringNearest;
        
        SKSpriteNode *player = [SKSpriteNode spriteNodeWithTexture:birdTexture1];
        SKAction* flap = [SKAction repeatActionForever:[SKAction animateWithTextures:@[birdTexture1, birdTexture2] timePerFrame:0.2]];
        player.yScale = 0.35;
        player.xScale = 0.35;
        player.position = CGPointMake(CGRectGetMidX(parent.frame)/2, CGRectGetMidY(parent.frame) * (1.35 - dec));
        [parent addChild:player];
        [player runAction:flap];
        dec += 0.35;
        
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
