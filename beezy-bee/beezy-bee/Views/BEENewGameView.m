//
//  BEENewGameView.m
//  beezy-bee
//
//  Created by Hiroshi on 1/27/16.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "BEENewGameView.h"
#import "BEESessionHelper.h"
#import "BEESharedPreferencesHelper.h"
#import "BEEMainView.h"
#import "BEEPlayer.h"

@interface BEENewGameView ()

@property (nonatomic) NSMutableArray *objArray;
@property (nonatomic) NSArray *playerArray;

@end


@implementation BEENewGameView

+ (instancetype) sharedInstance
{
    static BEENewGameView *sharedStore;
    
    if (!sharedStore)
        sharedStore = [[self alloc] initPrivate];
    
    return sharedStore;
}

- (instancetype) init
{
    [NSException raise:@"Singleton" format:@"Use [BEENewGameView sharedInstance]"];
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

- (void) createNewGameWithParentScene:(SKScene *)parent
{
    [BEESessionHelper sharedInstance].currentScreen = BST_GAME;
    
    //That is your player
    BEE_PLAYER_TYPE playerType = [[BEESharedPreferencesHelper sharedInstance] getPlayerType];
    //SKTexture* birdTexture1 = [SKTexture textureWithImageNamed:@"First-Bee"];
    
    SKTexture* birdTexture1 = [SKTexture textureWithImageNamed:self.playerArray[playerType]];
    birdTexture1.filteringMode = SKTextureFilteringNearest;
    SKTexture* birdTexture2 = [SKTexture textureWithImageNamed:[NSString stringWithFormat:@"%@-Move", [BEEPlayer sharedInstance].playerArray[playerType]]];
    birdTexture2.filteringMode = SKTextureFilteringNearest;
    
    SKSpriteNode *player = [SKSpriteNode spriteNodeWithTexture:birdTexture1];
    SKAction* flap = [SKAction repeatActionForever:[SKAction animateWithTextures:@[birdTexture1, birdTexture2] timePerFrame:0.2]];
    player.yScale = 0.35;
    player.xScale = 0.35;
    player.position = CGPointMake(CGRectGetMidX(parent.frame)/2,CGRectGetMidY(parent.frame));
    [parent addChild:player];
    [player runAction:flap];
    
    SKTexture* birdTexture3 = [SKTexture textureWithImageNamed:@"Monster-Wasp"];
    birdTexture1.filteringMode = SKTextureFilteringNearest;
    SKTexture* birdTexture4 = [SKTexture textureWithImageNamed:@"Monster-Wasp-Move"];
    birdTexture2.filteringMode = SKTextureFilteringNearest;
    
    SKSpriteNode *monster = [SKSpriteNode spriteNodeWithTexture:birdTexture1];
    SKAction* flap1 = [SKAction repeatActionForever:[SKAction animateWithTextures:@[birdTexture3, birdTexture4] timePerFrame:0.2]];
    monster.yScale = 0.5;
    monster.xScale = 0.5;
    monster.position = CGPointMake(CGRectGetMidX(parent.frame)*2 - monster.size.width,CGRectGetMidY(parent.frame));
    [parent addChild:monster];
    [monster runAction:flap1];
    
    SKLabelNode *backLabel = [self createLabelWithParentScene:parent keyForName:@"back"];
    [self setLabelNode:backLabel position:CGPointMake(backLabel.frame.size.width / 2 + 10, parent.size.height - backLabel.frame.size.height - 10)];
    
    __weak SKSpriteNode *weakObj = player;
    [self.objArray addObject:weakObj];
    
    __weak SKSpriteNode *weakObj1 = monster;
    [self.objArray addObject:weakObj1];
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

- (void) handleNewGame:(UITouch *)touch andParentScene:(SKScene *)parent
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

@end
