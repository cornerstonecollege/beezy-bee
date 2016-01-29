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
@property (nonatomic) NSArray *playerArray;
@property (nonatomic) NSInteger playerSelectedIndex;

@end

@implementation BEESettingsView

#define PLY_SML_SCALE 0.7;
#define PLY_LRG_SCALE 1;
#define ARW_SML_SCALE 0.3;
#define ARW_LRG_SCALE 0.5;


SKLabelNode *audioOnLabel;
SKLabelNode *audioOffLabel;
BEEBaseObject *arrowLeft1;
BEEBaseObject *arrowRight1;
BEEBaseObject *arrowLeft2;
BEEBaseObject *arrowRight2;

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
        _playerArray = @[@"First-Bee", @"Item-Honey"];
        _playerSelectedIndex = 0;
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
    
    BEEBaseObject *player = [[BEEPlayer alloc] initWithImageNamed:self.playerArray[self.playerSelectedIndex] position:CGPointMake(CGRectGetMidX(parent.frame),(CGRectGetMidY(parent.frame) * 0.4)) andParentScene:parent];
    
    //BEEBaseObject *stage = [[BEEPlayer alloc] initWithImageNamed:self.playerArray[self.playerSelectedIndex] position:CGPointMake(CGRectGetMidX(parent.frame),(CGRectGetMidY(parent.frame) * 0.9) - 120) andParentScene:parent];
    
    arrowLeft1 = [[BEEBaseObject alloc] initWithImageNamed:@"Arrow-Left" position:CGPointMake(CGRectGetMidX(parent.frame) * 0.3,(CGRectGetMidY(parent.frame) * 1.2)) andParentScene:parent];
    
    arrowRight1 = [[BEEBaseObject alloc] initWithImageNamed:@"Arrow-Right" position:CGPointMake(CGRectGetMidX(parent.frame) * 1.7,(CGRectGetMidY(parent.frame) * 1.2)) andParentScene:parent];
    
    arrowLeft2 = [[BEEBaseObject alloc] initWithImageNamed:@"Arrow-Left" position:CGPointMake(CGRectGetMidX(parent.frame) * 0.3, (CGRectGetMidY(parent.frame) * 0.4)) andParentScene:parent];
    
    arrowRight2 = [[BEEBaseObject alloc] initWithImageNamed:@"Arrow-Right" position:CGPointMake(CGRectGetMidX(parent.frame) * 1.7, (CGRectGetMidY(parent.frame) * 0.4)) andParentScene:parent];
    
    // 4s, iPod
    if (parent.size.height < 500)
    {
        player.yScale = PLY_SML_SCALE;
        player.xScale = PLY_SML_SCALE;
        arrowLeft1.yScale = ARW_SML_SCALE;
        arrowLeft1.xScale = ARW_SML_SCALE;
        arrowLeft2.yScale = ARW_SML_SCALE;
        arrowLeft2.xScale = ARW_SML_SCALE;
        arrowRight1.yScale = ARW_SML_SCALE;
        arrowRight1.xScale = ARW_SML_SCALE;
        arrowRight2.yScale = ARW_SML_SCALE;
        arrowRight2.xScale = ARW_SML_SCALE;
    }
    else
    {
        player.yScale = PLY_LRG_SCALE;
        player.xScale = PLY_LRG_SCALE;
        arrowLeft1.yScale = ARW_LRG_SCALE;
        arrowLeft1.xScale = ARW_LRG_SCALE;
        arrowLeft2.yScale = ARW_LRG_SCALE;
        arrowLeft2.xScale = ARW_LRG_SCALE;
        arrowRight1.yScale = ARW_LRG_SCALE;
        arrowRight1.xScale = ARW_LRG_SCALE;
        arrowRight2.yScale = ARW_LRG_SCALE;
        arrowRight2.xScale = ARW_LRG_SCALE;
    }
    
    [self setLabelNode:backLabel position:CGPointMake(backLabel.frame.size.width / 2 + 10, parent.size.height - backLabel.frame.size.height - 10)];
    audioOnLabel.fontColor = [SKColor redColor];
    [self setLabelNode:audioLabel position:CGPointMake(CGRectGetMidX(parent.frame) * 0.7, CGRectGetMidY(parent.frame) * 1.7)];
    [self setLabelNode:audioOnLabel position:CGPointMake(CGRectGetMidX(parent.frame) * 1.2, CGRectGetMidY(parent.frame) * 1.7)];
    [self setLabelNode:audioOffLabel position:CGPointMake(CGRectGetMidX(parent.frame) * 1.5, CGRectGetMidY(parent.frame) * 1.7)];
    [self setLabelNode:stageLabel position:CGPointMake(CGRectGetMidX(parent.frame), CGRectGetMidY(parent.frame) * 1.5)];
    [self setLabelNode:characterLabel position:CGPointMake(CGRectGetMidX(parent.frame), CGRectGetMidY(parent.frame) * 0.75)];
    
    __weak BEEBaseObject *weakPlayer = player;
    [self.objArray addObject:weakPlayer];
    
    __weak BEEBaseObject *weakArrowLeft2 = arrowLeft2;
    [self.objArray addObject:weakArrowLeft2];
    
    __weak BEEBaseObject *weakArrowRight2 = arrowRight2;
    [self.objArray addObject:weakArrowRight2];

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
    }
    else if ([nodeTouched isKindOfClass:[BEEBaseObject class]])
    {
        __weak BEESettingsView *weakSelf = self;
        [self.objArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
        {
            if ([obj isKindOfClass:[BEEBaseObject class]])
            {
                BEEBaseObject *baseObj = ((BEEBaseObject *)obj);
                if ([baseObj.name isEqualToString:weakSelf.playerArray[weakSelf.playerSelectedIndex]])
                {
                    [weakSelf.objArray removeObject:baseObj];
                    [baseObj removeFromParent];
                    *stop = YES;
                }
            }
        }];
        
        if (nodeTouched == arrowLeft2)
        {
            self.playerSelectedIndex = self.playerSelectedIndex == 0 ? [self.playerArray count] - 1 : self.playerSelectedIndex - 1;
        }
        else if (nodeTouched == arrowRight2)
        {
            self.playerSelectedIndex = self.playerSelectedIndex == [self.playerArray count] - 1 ? 0 : self.playerSelectedIndex + 1;
        }
        
        BEEBaseObject *player = [[BEEBaseObject alloc] initWithImageNamed:self.playerArray[self.playerSelectedIndex] position:CGPointMake(CGRectGetMidX(parent.frame),(CGRectGetMidY(parent.frame) * 0.4)) andParentScene:parent];
        if (parent.size.height < 500){
            player.xScale = PLY_SML_SCALE;
            player.yScale = PLY_SML_SCALE;
        }
        else{
            player.xScale = PLY_LRG_SCALE;
            player.yScale = PLY_LRG_SCALE;
        }
        
        
        __weak BEEBaseObject *weakPlayer = player;
        [self.objArray addObject:weakPlayer];
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
