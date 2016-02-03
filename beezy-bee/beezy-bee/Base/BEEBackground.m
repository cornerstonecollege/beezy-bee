//
//  BEEBackground.m
//  beezy-bee
//
//  Created by CICCC1 on 2016-01-29.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "BEEBackground.h"

@implementation BEEBackground

NSMutableArray *arrBackground;

+ (void)backgroundWithType:(BEE_BACKGROUND_TYPE)type andParentScene:(SKScene *)gameScene
{
    switch (type)
    {
        case BBT_BACKGROUND1:
        {
            [BEEBackground background1WithParentScene:gameScene];
            break;
        }
        case BBT_BACKGROUND2:
        {
            [BEEBackground background2WithParentScene:gameScene];
            break;
        }
            
        default:
            break;
    }
}

+ (BEEBackgroundElements *)getConfigForBackgroundType:(BEE_BACKGROUND_TYPE)type
{
    switch (type)
    {
        case BBT_BACKGROUND1:
            return [[BEEBackgroundElements alloc] initWithAudioTrack:@"background_one" andMonsterTypes:@[[NSNumber numberWithUnsignedInteger:BMT_MONSTER1]]];
            break;
            
        default:
            return nil;
            break;
    }
}

+ (void) background1WithParentScene:(SKScene *)gameScene
{
    [BEEBackground resetArray];
    
    [BEEBackground getPrivateWithBackgroundImgName:@"Background-1" backgroundMovableImgName:@"Background-1-Move" type:BBT_BACKGROUND1 andParentScene:gameScene];
}

+ (void) background2WithParentScene:(SKScene *)gameScene
{
    [BEEBackground resetArray];
    
    [BEEBackground getPrivateWithBackgroundImgName:@"Background-2" backgroundMovableImgName:@"Background-2-Move" type:BBT_BACKGROUND2 andParentScene:gameScene];
}

+ (void) getPrivateWithBackgroundImgName:(NSString *)imgName backgroundMovableImgName:(NSString *)imgMovableName type:(BEE_BACKGROUND_TYPE)type andParentScene:(SKScene *)gameScene
{
    SKTexture *background = [SKTexture textureWithImageNamed:imgName];
    SKAction *moveBackground = [SKAction moveByX:-background.size.width y:0 duration:0.03 * background.size.width];
    SKAction *resetBackground = [SKAction moveByX:background.size.width y:0 duration:0];
    SKAction *moveBackgroundForever = [SKAction repeatActionForever:[SKAction sequence:@[moveBackground, resetBackground]]];
    
    for (CGFloat i = 0; i < 2 + gameScene.frame.size.width / background.size.width; i++)
    {
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithTexture:background];
        sprite.position = CGPointMake(i * sprite.size.width, sprite.size.height / 2);
        [sprite runAction:moveBackgroundForever];
        [gameScene insertChild:sprite atIndex:i];
        
        __weak SKSpriteNode *weakBackgroundSprite = sprite;
        [arrBackground addObject:weakBackgroundSprite];
    }
    
    SKTexture *backgroundMovable = [SKTexture textureWithImageNamed:imgMovableName];
    SKAction *moveBackgroundMovable = [SKAction moveByX:-backgroundMovable.size.width y:0 duration:0.02 * backgroundMovable.size.width / 2];
    SKAction *resetBackgroundMovable = [SKAction moveByX:backgroundMovable.size.width y:0 duration:0];
    SKAction *moveBackgroundMovableForever = [SKAction repeatActionForever:[SKAction sequence:@[moveBackgroundMovable, resetBackgroundMovable]]];
    
    for (CGFloat i = 0; i < 2 + gameScene.frame.size.width / backgroundMovable.size.width; i++)
    {
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithTexture:backgroundMovable];
        sprite.position = CGPointMake(i * sprite.size.width, sprite.size.height / 2);
        [sprite runAction:moveBackgroundMovableForever];
        [gameScene insertChild:sprite atIndex:i + 2];
        
        __weak SKSpriteNode *weakBackgroundSprite = sprite;
        [arrBackground addObject:weakBackgroundSprite];
    }
}

+ (void) resetArray
{
    if (arrBackground && [arrBackground count] > 0)
    {
        for (SKSpriteNode *node in arrBackground)
        {
            [node removeFromParent];
        }
    }
    
    arrBackground = [NSMutableArray array];
}

@end
