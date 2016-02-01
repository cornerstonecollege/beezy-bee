//
//  BEEBackground.m
//  beezy-bee
//
//  Created by CICCC1 on 2016-01-29.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "BEEBackground.h"

@implementation BEEBackground

+ (void) background1WithParentScene:(SKScene *)gameScene
{
    [[self alloc] getPrivateWithBackgroundImgName:@"Background-1" backgroundMovableImgName:@"Background-1-Move" type:BBT_BACKGROUND1 andParentScene:gameScene];
}

+ (void) getPrivateWithBackgroundImgName:(NSString *)imgName backgroundMovableImgName:(NSString *)imgMovableName type:(BEE_BACKGROUND_TYPE)type andParentScene:(SKScene *)gameScene
{
    SKTexture *background = [SKTexture textureWithImageNamed:imgName];
    SKAction *moveBackground = [SKAction moveByX:-background.size.width y:0 duration:0.01 * background.size.width];
    SKAction *resetBackground = [SKAction moveByX:background.size.width y:0 duration:0];
    SKAction *moveBackgroundForever = [SKAction repeatActionForever:[SKAction sequence:@[moveBackground, resetBackground]]];
    
    
}

@end
