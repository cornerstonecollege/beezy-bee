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
#import "BEEBaseObject.h"

@interface BEESettingsView ()

@property (nonatomic) NSMutableArray *objArray;

@end

@implementation BEESettingsView

SKLabelNode *audioOnLabel;
SKLabelNode *audioOffLabel;

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
    audioOnLabel = [self createLabelWithParentScene:parent keyForName:@"on"];
    audioOffLabel = [self createLabelWithParentScene:parent keyForName:@"off"];
    SKLabelNode *stageLabel = [self createLabelWithParentScene:parent keyForName:@"stage"];
    SKLabelNode *characterLabel = [self createLabelWithParentScene:parent keyForName:@"character"];
    
    BEEPlayer *player1 = [[BEEPlayer alloc] initWithImageNamed:@"First-Bee" position:CGPointMake(CGRectGetMidX(parent.frame),(CGRectGetMidY(parent.frame) * 0.9) - 120) andParentScene:parent];
    
    BEEBaseObject *arrowLeft = [[BEEBaseObject alloc] initWithImageNamed:@"Arrow-Left" position:CGPointMake(CGRectGetMidX(parent.frame) * 0.5,(CGRectGetMidY(parent.frame) * 0.9) - 120) andParentScene:parent];
    
    BEEBaseObject *arrowRight = [[BEEBaseObject alloc] initWithImageNamed:@"Arrow-Right" position:CGPointMake(CGRectGetMidX(parent.frame) * 1.5,(CGRectGetMidY(parent.frame) * 0.9) - 120) andParentScene:parent];
    
    // 4s, iPod
    if (parent.size.height < 500)
    {
        player1.yScale = 0.7;
        player1.xScale = 0.7;
        arrowLeft.yScale = 0.3;
        arrowLeft.xScale = 0.3;
        arrowRight.yScale = 0.3;
        arrowRight.xScale = 0.3;
    }
    else
    {
        player1.yScale = 1;
        player1.xScale = 1;
    }
    
    [self setLabelNode:backLabel position:CGPointMake(backLabel.frame.size.width / 2 + 10, parent.size.height - backLabel.frame.size.height - 10)];
    audioOnLabel.fontColor = [SKColor redColor];
    [self setLabelNode:audioLabel position:CGPointMake(CGRectGetMidX(parent.frame) * 0.7, CGRectGetMidY(parent.frame) * 1.7)];
    [self setLabelNode:audioOnLabel position:CGPointMake(CGRectGetMidX(parent.frame) * 1.2, CGRectGetMidY(parent.frame) * 1.7)];
    [self setLabelNode:audioOffLabel position:CGPointMake(CGRectGetMidX(parent.frame) * 1.5, CGRectGetMidY(parent.frame) * 1.7)];
    [self setLabelNode:stageLabel position:CGPointMake(CGRectGetMidX(parent.frame), CGRectGetMidY(parent.frame) * 1.5)];
    [self setLabelNode:characterLabel position:CGPointMake(CGRectGetMidX(parent.frame), CGRectGetMidY(parent.frame) * 0.85)];
    
    __weak BEEPlayer *weakPlayer1 = player1;
    [self.objArray addObject:weakPlayer1];
    
    __weak BEEBaseObject *weakArrowLeft = arrowLeft;
    [self.objArray addObject:weakArrowLeft];
    
    __weak BEEBaseObject *weakArrowRight = arrowRight;
    [self.objArray addObject:weakArrowRight];

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
        else if (label.text == [[BEESessionHelper sharedInstance] getLocalizedStringForName:@"off"])
        {
            [BEESessionHelper sharedInstance].isAudioEnabled = NO;
            audioOffLabel.fontColor = [SKColor redColor];
            audioOnLabel.fontColor = [SKColor blackColor];
        }
        else if (label.text == [[BEESessionHelper sharedInstance] getLocalizedStringForName:@"on"])
        {
            [BEESessionHelper sharedInstance].isAudioEnabled = YES;
            audioOnLabel.fontColor = [SKColor redColor];
            audioOffLabel.fontColor = [SKColor blackColor];
        }
        else if (label.text == [[BEESessionHelper sharedInstance] getLocalizedStringForName:@"Arrow-Left"])
        {
        
        }
        else if (label.text == [[BEESessionHelper sharedInstance] getLocalizedStringForName:@"Arrow-Right"])
        {
            
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
