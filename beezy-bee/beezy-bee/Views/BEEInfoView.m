//
//  BEEInfoView.m
//  beezy-bee
//
//  Created by Hiroshi on 2/18/16.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "BEEInfoView.h"
#import "BEEMainView.h"
#import "BEESharedPreferencesHelper.h"
#import "BEESessionHelper.h"

@interface BEEInfoView ()

@property (nonatomic) NSMutableArray *objArray;

@end

@implementation BEEInfoView

+ (instancetype) sharedInstance
{
    static BEEInfoView *sharedStore;
    
    if (!sharedStore)
        sharedStore = [[self alloc] initPrivate];
    
    return sharedStore;
}

- (instancetype) init
{
    [NSException raise:@"Singleton" format:@"Use [BEEInfoView sharedInstance]"];
    return nil;
}

- (instancetype) initPrivate
{
    self = [super init];
    
    if (self)
    {
        _objArray = [NSMutableArray array];
        [self initSharedPreferences];
    }
    
    return self;
}

- (void) initSharedPreferences
{
    [BEESharedPreferencesHelper sharedInstance];
    // TODO: set background, player and audio.
}

- (void) createInfoWithParentScene:(SKScene *)parent
{
    [BEESessionHelper sharedInstance].currentScreen = BST_INFO;
    
    SKLabelNode *backLabel = [self createLabelWithParentScene:parent keyForName:@"back"];
    backLabel.fontSize = 25;
    [self setLabelNode:backLabel position:CGPointMake(backLabel.frame.size.width / 2 + 10, parent.size.height - backLabel.frame.size.height - 10)];
    
    SKLabelNode *mainLabel = [self createLabelWithParentScene:parent keyForName:@"info_mainTitle"];
    mainLabel.fontSize = 35;
    [self setLabelNode:mainLabel position:CGPointMake(CGRectGetMidX(parent.frame), CGRectGetMidY(parent.frame) * 1.6)];
    
    SKLabelNode *expLabel1 = [self createLabelWithParentScene:parent keyForName:@"info_explain1"];
    expLabel1.fontSize = 15;
    [self setLabelNode:expLabel1 position:CGPointMake(CGRectGetMidX(parent.frame), CGRectGetMidY(parent.frame) * 1.4)];
    
    SKLabelNode *andLabel = [self createLabelWithParentScene:parent keyForName:@"info_and"];
    andLabel.fontSize = 15;
    [self setLabelNode:andLabel position:CGPointMake(CGRectGetMidX(parent.frame), CGRectGetMidY(parent.frame) * 1.3)];
    
    SKLabelNode *expLabel2 = [self createLabelWithParentScene:parent keyForName:@"info_explain2"];
    expLabel2.fontSize = 15;
    [self setLabelNode:expLabel2 position:CGPointMake(CGRectGetMidX(parent.frame), CGRectGetMidY(parent.frame) * 1.2)];
    
    SKLabelNode *butLabel = [self createLabelWithParentScene:parent keyForName:@"info_but"];
    butLabel.fontSize = 15;
    [self setLabelNode:butLabel position:CGPointMake(CGRectGetMidX(parent.frame), CGRectGetMidY(parent.frame) * 1.1)];
    
    SKLabelNode *expLabel3 = [self createLabelWithParentScene:parent keyForName:@"info_explain3"];
    expLabel3.fontSize = 15;
    [self setLabelNode:expLabel3 position:CGPointMake(CGRectGetMidX(parent.frame), CGRectGetMidY(parent.frame) * 1.0)];
    
    SKLabelNode *copyRightLabel = [self createLabelWithParentScene:parent keyForName:@"copyright"];
    copyRightLabel.fontSize = 10;
    [self setLabelNode:copyRightLabel position:CGPointMake((parent.size.width - CGRectGetMidX(parent.frame)), CGRectGetMidY(parent.frame) * 0.05)];
    
    SKLabelNode *createdByLabel = [self createLabelWithParentScene:parent keyForName:@"createdBy"];
    createdByLabel.fontSize = 30;
    [self setLabelNode:createdByLabel position:CGPointMake(CGRectGetMidX(parent.frame), CGRectGetMidY(parent.frame) * 0.8)];
    
    SKLabelNode *luizLabel = [self createLabelWithParentScene:parent keyForName:@"luiz"];
    luizLabel.fontSize = 20;
    [self setLabelNode:luizLabel position:CGPointMake(CGRectGetMidX(parent.frame), CGRectGetMidY(parent.frame) * 0.6)];
    
    SKLabelNode *hiroshiLabel = [self createLabelWithParentScene:parent keyForName:@"hiroshi"];
    hiroshiLabel.fontSize = 20;
    [self setLabelNode:hiroshiLabel position:CGPointMake(CGRectGetMidX(parent.frame), CGRectGetMidY(parent.frame) * 0.5)];
    
    SKLabelNode *shreekanLabel = [self createLabelWithParentScene:parent keyForName:@"sreekanth"];
    shreekanLabel.fontSize = 20;
    [self setLabelNode:shreekanLabel position:CGPointMake(CGRectGetMidX(parent.frame), CGRectGetMidY(parent.frame) * 0.4)];
    
    SKLabelNode *shawnLabel = [self createLabelWithParentScene:parent keyForName:@"shawn"];
    shawnLabel.fontSize = 20;
    [self setLabelNode:shawnLabel position:CGPointMake(CGRectGetMidX(parent.frame), CGRectGetMidY(parent.frame) * 0.3)];
    
    SKLabelNode *tomokoLabel = [self createLabelWithParentScene:parent keyForName:@"tomoko"];
    tomokoLabel.fontSize = 20;
    [self setLabelNode:tomokoLabel position:CGPointMake(CGRectGetMidX(parent.frame), CGRectGetMidY(parent.frame) * 0.2)];
    
    
}

- (SKLabelNode *) createLabelWithParentScene:(SKScene *)parent keyForName:(NSString *)keyForName
{
    SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:[[BEESessionHelper sharedInstance] getLocalizedStringForName:@"font_style"]];
    label.text = [[BEESessionHelper sharedInstance] getLocalizedStringForName:keyForName];
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

- (void) deleteObjectsFromParent
{
    if ([self.objArray count] > 0)
    {
        for (SKLabelNode *obj in self.objArray)
            [obj removeFromParent];
        
        self.objArray = [NSMutableArray array];
    }
}

- (void) handleInfo:(UITouch *)touch andParentScene:(SKScene *)parent
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

