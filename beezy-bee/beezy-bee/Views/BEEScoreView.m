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
    parent.physicsWorld.gravity = CGVectorMake(0,0);
    
    SKLabelNode *backLabel = [self createLabelWithParentScene:parent keyForName:@"back"];
    
    
    SKLabelNode *label = [[SKLabelNode alloc]initWithFontNamed:@"Helvetica"];
    label.position = CGPointMake(0, -label.frame.size.height/2);
    
    SKSpriteNode *bg1Color = [SKSpriteNode spriteNodeWithColor:[[BEEUtilitiesHelper sharedInstance] goldColor] size:CGSizeMake(parent.size.width, 70)];
    bg1Color.position = CGPointMake(CGRectGetMidX(parent.frame), CGRectGetMidY(parent.frame) * 1.35);
    
    
    SKLabelNode *background1Label = [self createLabelWithParentScene:parent keyForName:@"1st"];
    SKLabelNode *background2Label = [self createLabelWithParentScene:parent keyForName:@"2nd"];
    SKLabelNode *background3Label = [self createLabelWithParentScene:parent keyForName:@"3rd"];
    
    [self setLabelNode:backLabel position:CGPointMake(backLabel.frame.size.width / 2 + 10, parent.size.height - backLabel.frame.size.height - 10)];
    [self setLabelNode:background1Label position:CGPointMake(backLabel.frame.size.width / 2 + 10, CGRectGetMidY(parent.frame) * 1.35)];
    [self setLabelNode:background2Label position:CGPointMake(backLabel.frame.size.width / 2 + 10, CGRectGetMidY(parent.frame))];
    [self setLabelNode:background3Label position:CGPointMake(backLabel.frame.size.width / 2 + 10, CGRectGetMidY(parent.frame) * 0.65)];
    
    [bg1Color addChild:label];
    [parent addChild:bg1Color];

    
    background1Label.fontColor = [SKColor colorWithRed:0.1 green:1 blue:0.1 alpha:1.0];
    
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
