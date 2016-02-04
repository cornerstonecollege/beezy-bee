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

@interface BEENewGameView ()

@property (nonatomic) NSMutableArray *objArray;
@property (nonatomic) NSArray *playerArray;
@property (nonatomic, weak) GameScene *parent;

@end


@implementation BEENewGameView

SKLabelNode *pointLabel;

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
    [BEESessionHelper sharedInstance].userScore = 0;
    
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
    NSInteger randCnt = arc4random_uniform(2);
    CGFloat y;
    CGFloat tmpY = 0;
    BEEMonster *objMonster;
    for (NSInteger cnt = 0; cnt <= randCnt; cnt++){
        y = arc4random() % (NSInteger)(parent.frame.size.height) * 0.9;
        NSInteger randObj = arc4random_uniform(2);
        switch(randObj)
        {
            case 0 :
                 objMonster = [[BEEMonster alloc] initWithImageNamed:@"Monster-Wasp" imageMovableName:@"Monster-Wasp-Move" position:CGPointMake(parent.frame.size.width + 100, y + tmpY) andParentScene:parent];
                break;
            case 1 :
                 objMonster = [[BEEMonster alloc] initWithImageNamed:@"Monster-Spider" imageMovableName:@"Monster-Spider" position:CGPointMake(parent.frame.size.width + 100, y + tmpY) andParentScene:parent];
                break;
        }
        objMonster.yScale = 0.3;
        objMonster.xScale = 0.3;
        
        tmpY += 100;
        
        //calculate your new duration based on the distance
        //float moveDuration = 0.001*distance;
        
        //move the node
        SKAction *move = [SKAction moveTo:CGPointMake(-100, y) duration: 2.0];
        SKAction *removeFromParent = [SKAction removeFromParent];
        [objMonster runAction: [SKAction sequence:@[move, removeFromParent]]];
        __weak BEEMonster *weakObj1 = objMonster;
        [self.objArray addObject:weakObj1];
    }
    
    NSInteger randPoint = arc4random_uniform(2);
    BEEItem *objItem;
    if (randPoint == 1) {
        NSInteger randPoint = arc4random_uniform(3);
        y = arc4random() % (NSInteger)(parent.frame.size.height) * 0.9;
        switch(randPoint)
        {
            case 0 :
                objItem = [[BEEItem alloc] initWithImageNamed:@"Item-Honey" imageMovableName:@"Item-Honey" position:CGPointMake(parent.frame.size.width + 100, y) andParentScene:parent];
                objItem.special = YES;
                break;
            case 1 :
                objItem = [[BEEItem alloc] initWithImageNamed:@"Item-GreenFlower" imageMovableName:@"Item-GreenFlower" position:CGPointMake(parent.frame.size.width + 100, y) andParentScene:parent];
                break;
            case 2 :
                objItem = [[BEEItem alloc] initWithImageNamed:@"Item-RedFlower" imageMovableName:@"Item-RedFlower" position:CGPointMake(parent.frame.size.width + 100, y) andParentScene:parent];
                break;
            case 3 :
                objItem = [[BEEItem alloc] initWithImageNamed:@"Item-BlueFlower" imageMovableName:@"Item-BlueFlower" position:CGPointMake(parent.frame.size.width + 100, y) andParentScene:parent];
                break;
        }
        objItem.yScale = 0.3;
        objItem.xScale = 0.3;
        
        //calculate your new duration based on the distance
        //float moveDuration = 0.001*distance;
        
        //move the node
        SKAction *move = [SKAction moveTo:CGPointMake(-100, y) duration: 2.0];
        SKAction *removeFromParent = [SKAction removeFromParent];
        [objItem runAction: [SKAction sequence:@[move, removeFromParent]]];
        __weak BEEItem *weakObj2 = objItem;
        [self.objArray addObject:weakObj2];

    }
}

- (void)didUpdateParentScene:(SKScene *)gameScene
{
    pointLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)[BEESessionHelper sharedInstance].userScore];
}

@end
