//
//  BEEBaseObject.m
//  beezy-bee
//
//  Created by Luiz Fernando Peres on 2016-01-25.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "BEEBaseObject.h"

@implementation BEEBaseObject

- (instancetype)initWithImageNamed:(NSString *)name
{
    [NSException raise:@"Wrong initializer" format:@"Use initWithImageNamed:position:andParentScene:"];
    return nil;
}

- (instancetype) initWithImageNamed:(NSString *)imageNamed position:(CGPoint)pos andParentScene:(SKScene *)parent;
{
    self = [super initWithImageNamed:imageNamed];
    if (self)
    {
        self.position = pos;
        self.name = imageNamed;
        [parent addChild:self];
    }
    
    return self;
}

- (instancetype) initWithImageNamed:(NSString *)imageNamed imageMovableName:(NSString *)imageMovableName position:(CGPoint)pos andParentScene:(SKScene *)parent
{
    SKTexture *firstTexture = [SKTexture textureWithImageNamed:imageNamed];
    SKTexture *secondTexture = [SKTexture textureWithImageNamed:imageMovableName];
    
    self = [super initWithTexture:firstTexture];
    if (self)
    {
        SKAction *move = [SKAction repeatActionForever:[SKAction animateWithTextures:@[firstTexture, secondTexture] timePerFrame:0.2]];
        self.position = pos;
        self.name = imageNamed;
        [self runAction:move];
        [parent addChild:self];
    }
    
    return self;
}

@end
