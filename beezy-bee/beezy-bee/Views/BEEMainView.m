//
//  BEEMainView.m
//  beezy-bee
//
//  Created by Hiroshi on 1/26/16.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "BEEMainView.h"
#import "BEESettingsView.h"
#import "BEESessionHelper.h"
#import "BEEScoreView.h"
#import "BEEPlayer.h"
#import "BEENewGameView.h"

@interface BEEMainView ()

@property (nonatomic) NSMutableArray *objArray;

@end


@implementation BEEMainView

+ (instancetype) sharedInstance
{
    static BEEMainView *sharedStore;
    
    if (!sharedStore)
        sharedStore = [[self alloc] initPrivate];
    
    return sharedStore;
}

- (instancetype) init
{
    [NSException raise:@"Singleton" format:@"Use [BEEMainView sharedInstance]"];
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

- (void) createMenuWithParentScene:(SKScene *)parent
{
    [BEESessionHelper sharedInstance].currentScreen = BST_MAIN;
    
    [self createLabelWithParentScene:parent keyForName:@"new_game" andPosition:CGPointMake(CGRectGetMidX(parent.frame), CGRectGetMidY(parent.frame) * 1.35)];
    
    [self createLabelWithParentScene:parent keyForName:@"settings" andPosition:CGPointMake(CGRectGetMidX(parent.frame), CGRectGetMidY(parent.frame) * 0.65)];
    
    [self createLabelWithParentScene:parent keyForName:@"score" andPosition:CGPointMake(CGRectGetMidX(parent.frame), CGRectGetMidY(parent.frame))];
    }

- (void) createLabelWithParentScene:(SKScene *)parent keyForName:(NSString *)keyForName andPosition:(CGPoint)position
{
    SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"font_style"];
    label.text = [[BEESessionHelper sharedInstance] getLocalizedStringForName:keyForName];
    label.fontSize = 35;
    label.fontColor = [SKColor blackColor];
    label.position = position;
    [parent addChild:label];
    
    __weak SKLabelNode *weakLabel = label;
    [self.objArray addObject:weakLabel];
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

- (void) handleMain:(UITouch *)touch andParentScene:(SKScene *)parent
{
    CGPoint pointScr = [touch locationInNode:parent];
    SKNode *nodeTouched = [parent nodeAtPoint:pointScr];
    
    if ([nodeTouched isKindOfClass:[SKLabelNode class]])
    {
        SKLabelNode *label = (SKLabelNode *) nodeTouched;
        
        SKAction * actionMove = [SKAction moveTo:CGPointMake(label.position.x + 1000, label.position.y) duration:0.3];
        [label runAction:actionMove completion:^{
            if (label.text == [[BEESessionHelper sharedInstance] getLocalizedStringForName:@"new_game"])
            {
                [self deleteObjectsFromParent];
                [[BEENewGameView sharedInstance] createNewGameWithParentScene:parent];
            }
            else if (label.text == [[BEESessionHelper sharedInstance] getLocalizedStringForName:@"score"])
            {
                [self deleteObjectsFromParent];
                [[BEEScoreView sharedInstance] createScoreWithParentScene:parent];
            }
            else if (label.text == [[BEESessionHelper sharedInstance] getLocalizedStringForName:@"settings"])
            {
                [self deleteObjectsFromParent];
                [[BEESettingsView sharedInstance] createSettingsWithParentScene:parent];
            }
        }];
    }
    
}

@end
