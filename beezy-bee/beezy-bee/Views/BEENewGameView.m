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
@property (nonatomic, weak) GameScene *parent;

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
    if ([parent isKindOfClass:[GameScene class]])
    {
        self.parent = (GameScene *)parent;
        __weak BEENewGameView *weakSelf = self;
        [self.parent resetTimerDelegate];
        [self.parent.timerDelegateArr addObject:weakSelf];
    }
    
    SKLabelNode *backLabel = [self createLabelWithParentScene:parent keyForName:@"back"];
    [self setLabelNode:backLabel position:CGPointMake(backLabel.frame.size.width / 2 + 10, parent.size.height - backLabel.frame.size.height - 10)];
    
    __weak BEEPlayer *player = [BEEPlayer playerWithParent:parent];
    player.yScale = 0.35;
    player.xScale = 0.35;
    
    
    [self.objArray addObject:player];
}

- (void) deleteObjectsFromParent
{
    if ([self.objArray count] > 0)
    {
        for (SKLabelNode *obj in self.objArray)
            [obj removeFromParent];
        
        self.objArray = [NSMutableArray array];
    }
    
    [self.parent resetTimerDelegate];
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

- (void)didUpdateTimerWithParentScene:(SKScene *)parent
{
    BEEMonster *monster = [[BEEMonster alloc] initWithImageNamed:@"Monster-Wasp" imageMovableName:@"Monster-Wasp-Move" position:CGPointMake(CGRectGetMidX(parent.frame)*2 - 100,CGRectGetMidY(parent.frame)) andParentScene:parent];
    monster.yScale = 0.5;
    monster.xScale = 0.5;
    
    
    //get the distance between the destination position and the node's position
    double distance = sqrt(pow((100 - monster.position.x), 2.0) + pow((100 - monster.position.y), 2.0));
    
    //calculate your new duration based on the distance
    float moveDuration = 0.001*distance;
    
    //move the node
    SKAction *move = [SKAction moveTo:CGPointMake(100, 100) duration: moveDuration];
    [monster runAction: move];
    __weak BEEMonster *weakObj1 = monster;
    [self.objArray addObject:weakObj1];
}

@end
