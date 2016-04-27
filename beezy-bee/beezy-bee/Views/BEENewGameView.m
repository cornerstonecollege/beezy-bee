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
#import "BEEItem.h"
#import "BEEBaseObject.h"
#import "BEEMonster.h"

@interface BEENewGameView ()

@property (nonatomic) NSMutableArray *objArray;
@property (nonatomic) NSArray *playerArray;
@property (nonatomic, weak) GameScene *parent;
@property (nonatomic) NSMutableArray *monsterArray;

@end


@implementation BEENewGameView

SKLabelNode *pointLabel;
BEEItem *objItem;

#define DEFAULT_X -100

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
        _monsterArray = [NSMutableArray array];
    }
    
    return self;
}

- (void) createNewGameWithParentScene:(SKScene *)parent
{
    [BEESessionHelper sharedInstance].currentScreen = BST_GAME;
    [BEESessionHelper sharedInstance].userScore = 0;
    [BEESessionHelper sharedInstance].isGameOver = NO;
    
    if ([parent isKindOfClass:[GameScene class]])
    {
        self.parent = (GameScene *)parent;
        __weak BEENewGameView *weakSelf = self;
        [self.parent resetTimerDelegate];
        [self.parent.timerDelegateArr addObject:weakSelf];
    }
    
    SKLabelNode *backLabel = [self createLabelWithParentScene:parent keyForName:@"back"];
    [self setLabelNode:backLabel position:CGPointMake(backLabel.frame.size.width / 2 + 10, parent.size.height - backLabel.frame.size.height - 10)];
    
    
    pointLabel = [SKLabelNode labelNodeWithFontNamed:[[BEESessionHelper sharedInstance] getLocalizedStringForName:@"font_style"]];
    pointLabel.fontColor = [SKColor blackColor];
    [parent addChild:pointLabel];
    [self setLabelNode:pointLabel position:CGPointMake(CGRectGetMidX(parent.frame), parent.size.height - backLabel.frame.size.height - 50)];
    pointLabel.fontSize = 80;
    
    __weak BEEPlayer *player = [BEEPlayer playerWithParent:parent];
    if (parent.size.height < 500)
    {
        player.yScale = 0.25;
        player.xScale = 0.25;
    }
    else
    {
        player.yScale = 0.35;
        player.xScale = 0.35;
    }
    
    [self.objArray addObject:player];
    
    __weak SKLabelNode *weakScoreLabel = pointLabel;
    [self.objArray addObject:weakScoreLabel];
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
    else if ([nodeTouched isKindOfClass:[BEEBaseObject class]] && nodeTouched.name == [[BEESessionHelper sharedInstance] getLocalizedStringForName:@"restart"])
    {
        [self deleteObjectsFromParent];
        [self createNewGameWithParentScene:self.parent];
    }
}

- (void)didUpdateTimerWithParentScene:(SKScene *)parent
{
    if ([BEESessionHelper sharedInstance].isGameOver)
        return;
    
    if ([self.monsterArray count] > 4)
    {
        [self.objArray removeObject:self.monsterArray[0]];
        [self.objArray removeObject:self.monsterArray[1]];
        
        [self.monsterArray removeObjectAtIndex:0];
        [self.monsterArray removeObjectAtIndex:0];
    }
    
    NSInteger randCnt = arc4random_uniform(2);
    CGFloat y = 0.0;
    BEEMonster *objMonster;
    for (NSInteger cnt = 0; cnt <= randCnt; cnt++)
    {
        y = arc4random() % (NSInteger)(parent.frame.size.height);
        if(cnt != 0){
            while(objMonster.position.y > y - 50 && objMonster.position.y < y + 50 ){
                y = arc4random() % (NSInteger)(parent.frame.size.height);
            }
        }
        
        NSUInteger monsterType = arc4random_uniform(4);
        switch(monsterType)
        {
            case BMT_MONSTER1 :
                 objMonster = [[BEEMonster alloc] initWithImageNamed:@"Monster-Wasp" imageMovableName:@"Monster-Wasp-Move" position:CGPointMake(parent.frame.size.width + 100, y) andParentScene:parent];
                break;
            case BMT_MONSTER2 :
                 objMonster = [[BEEMonster alloc] initWithImageNamed:@"Monster-Spider" imageMovableName:@"Monster-Spider" position:CGPointMake(parent.frame.size.width + 100, y) andParentScene:parent];
                break;
            case BMT_MONSTER3 :
                objMonster = [[BEEMonster alloc] initWithImageNamed:@"Monster-Bat" imageMovableName:@"Monster-Bat-Move" position:CGPointMake(parent.frame.size.width + 100, y) andParentScene:parent];
                break;
            case BMT_MONSTER4 :
                objMonster = [[BEEMonster alloc] initWithImageNamed:@"Monster-Bat-2" imageMovableName:@"Monster-Bat-2-Move" position:CGPointMake(parent.frame.size.width + 100, y) andParentScene:parent];
                break;
        }
        
        [objMonster setType:(BEE_MONSTER_TYPE)monsterType];
        
        if (parent.size.height < 500)
        {
            objMonster.yScale = 0.3;
            objMonster.xScale = 0.3;
        }
        else
        {
            objMonster.yScale = 0.4;
            objMonster.xScale = 0.4;
        }
        
        y = objMonster.position.y + objMonster.frame.size.height / 2 > parent.frame.size.height ? parent.frame.size.height -  objMonster.frame.size.height / 2 - 10 : objMonster.position.y;
        
        y = objMonster.position.y - objMonster.frame.size.height / 2 < 0 ? objMonster.frame.size.height / 2 : objMonster.position.y;
        
        objMonster.position = CGPointMake(objMonster.position.x, y);
        
        //calculate your new duration based on the distance
        //float moveDuration = 0.001*distance;
        
        //move the node
        SKAction *move = [SKAction moveTo:CGPointMake(DEFAULT_X, y) duration: 2.0];
        SKAction *removeFromParent = [SKAction removeFromParent];
        [objMonster runAction: [SKAction sequence:@[move, removeFromParent]]];
        __weak BEEMonster *weakObj1 = objMonster;
        [self.objArray addObject:weakObj1];
        [self.monsterArray addObject:weakObj1];
    }
}

- (void)didUpdateTimerDelayWithParentScene:(SKScene *)parent
{
    if ([BEESessionHelper sharedInstance].isGameOver)
        return;
    
    if (objItem)
    {
        [self.objArray removeObject:objItem];
    }
    
    NSInteger randPoint = arc4random_uniform(2);
    if (randPoint == 1) {
        NSInteger randPoint = arc4random_uniform(4);
        CGFloat y = arc4random() % (NSInteger)(parent.frame.size.height);
        
        switch(randPoint)
        {
            case 0 :
                objItem = [[BEEItem alloc] initWithImageNamed:@"Item-Honey" position:CGPointMake(parent.frame.size.width + 100, y) andParentScene:parent];
                objItem.special = YES;
                break;
            case 1 :
                objItem = [[BEEItem alloc] initWithImageNamed:@"Item-GreenFlower" position:CGPointMake(parent.frame.size.width + 100, y) andParentScene:parent];
                break;
            case 2 :
                objItem = [[BEEItem alloc] initWithImageNamed:@"Item-RedFlower" position:CGPointMake(parent.frame.size.width + 100, y) andParentScene:parent];
                break;
            case 3 :
                objItem = [[BEEItem alloc] initWithImageNamed:@"Item-BlueFlower"position:CGPointMake(parent.frame.size.width + 100, y) andParentScene:parent];
                break;
        }
        
        if (parent.size.height < 500)
        {
            objItem.yScale = 0.3;
            objItem.xScale = 0.3;
        }
        else
        {
            objItem.yScale = 0.4;
            objItem.xScale = 0.4;
        }
        
        y = objItem.position.y + objItem.frame.size.height / 2 > parent.frame.size.height ? parent.frame.size.height -  objItem.frame.size.height / 2 - 10 : objItem.position.y;
        
        y = objItem.position.y - objItem.frame.size.height / 2 < 0 ? objItem.frame.size.height / 2 : objItem.position.y;
        
        objItem.position = CGPointMake(objItem.position.x, y);
        
        //calculate your new duration based on the distance
        //float moveDuration = 0.001*distance;
        
        //move the node
        SKAction *move = [SKAction moveTo:CGPointMake(DEFAULT_X, y) duration: 2.0];
        SKAction *removeFromParent = [SKAction removeFromParent];
        [objItem runAction: [SKAction sequence:@[move, removeFromParent]]];
        __weak BEEItem *weakObj2 = objItem;
        [self.objArray addObject:weakObj2];
    }

}

- (void)didUpdateParentScene:(SKScene *)parent
{
    pointLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)[BEESessionHelper sharedInstance].userScore];
    
    if([BEESessionHelper sharedInstance].isGameOver)
    {
        [self doGameOverWithParent:parent];
    }
}

- (void) doGameOverWithParent:(SKScene *)parent
{
    for (id obj in self.objArray)
    {
        if ([obj isKindOfClass:[BEEBaseObject class]])
        {
            BEEBaseObject *baseObj = (BEEBaseObject *)obj;
            [baseObj removeFromParent];
        }
    }
    
    BEEBaseObject *restart = [[BEEBaseObject alloc] initWithImageNamed:[[BEESessionHelper sharedInstance] getLocalizedStringForName:@"restart"] position:CGPointMake(CGRectGetMidX(parent.frame),CGRectGetMidY(parent.frame)) andParentScene:parent];
    restart.yScale = 0.5;
    restart.xScale = 0.5;
    
    __weak BEEBaseObject *weakRestart = restart;
    [self.objArray addObject:weakRestart];
}

@end
