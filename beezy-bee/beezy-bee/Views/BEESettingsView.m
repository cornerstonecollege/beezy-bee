//
//  BEESettingsView.m
//  beezy-bee
//
//  Created by Hiroshi on 1/27/16.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "BEESettingsView.h"
#import "BEESessionHelper.h"
#import "BEEMainView.h"
#import "BEEPlayer.h"

@interface BEESettingsView ()

@property (nonatomic) NSMutableArray *objArray;

@end

@implementation BEESettingsView

+ (instancetype) sharedInstance
{
    static BEESettingsView *sharedStore;
    
    if (!sharedStore)
        sharedStore = [[self alloc] initPrivate];
    
    return sharedStore;
}

- (instancetype) init
{
    [NSException raise:@"Singleton" format:@"Use [BEESettingsView sharedInstance]"];
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

- (void) createSettingsWithParentScene:(SKScene *)parent
{
    [BEESessionHelper sharedInstance].currentScreen = BST_SETTINGS;
    parent.physicsWorld.gravity = CGVectorMake(0,0);
    
    SKLabelNode *backLabel = [self createLabelWithParentScene:parent keyForName:@"back"];
    SKLabelNode *audioLabel = [self createLabelWithParentScene:parent keyForName:@"audio"];
    SKLabelNode *stageLabel = [self createLabelWithParentScene:parent keyForName:@"stage"];
    SKLabelNode *characterLabel = [self createLabelWithParentScene:parent keyForName:@"character"];
    
    BEEPlayer *player = [[BEEPlayer alloc] initWithImageNamed:@"First-Bee" position:CGPointMake(CGRectGetMidX(parent.frame),CGRectGetMidY(parent.frame) - 100) andParentScene:parent];
    player.yScale = 0.5;
    player.xScale = 0.5;
    
    [self setLabelNode:backLabel position:CGPointMake(backLabel.frame.size.width / 2 + 10, parent.size.height - backLabel.frame.size.height - 10)];
    [self setLabelNode:audioLabel position:CGPointMake(CGRectGetMidX(parent.frame), CGRectGetMidY(parent.frame) * 1.7)];
    [self setLabelNode:stageLabel position:CGPointMake(CGRectGetMidX(parent.frame), CGRectGetMidY(parent.frame) * 1.5)];
    [self setLabelNode:characterLabel position:CGPointMake(CGRectGetMidX(parent.frame), CGRectGetMidY(parent.frame) * 1.2)];
    
    [self.objArray addObject:player];
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

- (void) handleSettings:(UITouch *)touch andParentScene:(SKScene *)parent
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
