//
//  BEEBackground.m
//  beezy-bee
//
//  Created by CICCC1 on 2016-01-29.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "BEEBackground.h"
#import "BEEAudioHelper.h"
#import "BEESharedPreferencesHelper.h"

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
        case BBT_BACKGROUND3:
        {
            [BEEBackground background3WithParentScene:gameScene];
            break;
        }
            
        default:
            break;
    }
}

+ (void) playAudioWithType:(BEE_BACKGROUND_TYPE)type
{
    if ([[BEESharedPreferencesHelper sharedInstance] getIsAudioEnabled])
    {
        switch (type)
        {
            case BBT_BACKGROUND1:
            {
                [[BEEAudioHelper sharedInstance] playAudioWithFileName:@"background_one"];
                break;
            }
            case BBT_BACKGROUND2:
            {
                [[BEEAudioHelper sharedInstance] playAudioWithFileName:@"background_two"];
                break;
            }
            case BBT_BACKGROUND3:
            {
                [[BEEAudioHelper sharedInstance] playAudioWithFileName:@"background_three"];
                break;
            }
                
            default:
                break;
        }
    }
}

+ (void) background1WithParentScene:(SKScene *)gameScene
{
    [BEEBackground resetArray];
    
    [BEEBackground getPrivateWithBackgroundImgName:@"Background-1" backgroundMovableImgName:@"Background-1-Move" type:BBT_BACKGROUND1 andParentScene:gameScene];
    
    [BEEBackground playAudioWithType:BBT_BACKGROUND1];
}

+ (void) background2WithParentScene:(SKScene *)gameScene
{
    [BEEBackground resetArray];
    
    [BEEBackground getPrivateWithBackgroundImgName:@"Background-2" backgroundMovableImgName:@"Background-2-Move" type:BBT_BACKGROUND2 andParentScene:gameScene];
    
    [BEEBackground playAudioWithType:BBT_BACKGROUND2];
}

+ (void) background3WithParentScene:(SKScene *)gameScene
{
    [BEEBackground resetArray];
    
    [BEEBackground getPrivateWithBackgroundImgName:@"Background-3" backgroundMovableImgName:nil type:BBT_BACKGROUND3 andParentScene:gameScene];
    
    [BEEBackground playAudioWithType:BBT_BACKGROUND3];
}

+ (void) getPrivateWithBackgroundImgName:(NSString *)imgName backgroundMovableImgName:(NSString *)imgMovableName type:(BEE_BACKGROUND_TYPE)type andParentScene:(SKScene *)gameScene
{
    SKTexture *background = [SKTexture textureWithImageNamed:imgName];
    SKAction *moveBackground = [SKAction moveByX:-background.size.width y:0 duration:0.03 * background.size.width];
    SKAction *resetBackground = [SKAction moveByX:background.size.width + 2 y:0 duration:0];
    SKAction *moveBackgroundForever = [SKAction repeatActionForever:[SKAction sequence:@[moveBackground, resetBackground]]];
    
    for (CGFloat i = 0; i < 2 + gameScene.frame.size.width / background.size.width; i++)
    {
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithTexture:background];
        sprite.position = CGPointMake(i * sprite.size.width, sprite.size.height / 2);
        [sprite runAction:moveBackgroundForever];
        [gameScene addChild:sprite];
        
        __weak SKSpriteNode *weakBackgroundSprite = sprite;
        [arrBackground addObject:weakBackgroundSprite];
    }
    
    if (imgMovableName)
    {
        SKTexture *backgroundMovable = [SKTexture textureWithImageNamed:imgMovableName];
        SKAction *moveBackgroundMovable = [SKAction moveByX:-backgroundMovable.size.width y:0 duration:0.02 * backgroundMovable.size.width / 2];
        SKAction *resetBackgroundMovable = [SKAction moveByX:backgroundMovable.size.width y:0 duration:0];
        SKAction *moveBackgroundMovableForever = [SKAction repeatActionForever:[SKAction sequence:@[moveBackgroundMovable, resetBackgroundMovable]]];
        
        for (CGFloat i = 0; i < 2 + gameScene.frame.size.width / backgroundMovable.size.width; i++)
        {
            SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithTexture:backgroundMovable];
            sprite.position = CGPointMake(i * sprite.size.width, sprite.size.height / 2);
            [sprite runAction:moveBackgroundMovableForever];
            [gameScene addChild:sprite];
            
            __weak SKSpriteNode *weakBackgroundSprite = sprite;
            [arrBackground addObject:weakBackgroundSprite];
        }
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
