//
//  BEEBaseTouchable.m
//  beezy-bee
//
//  Created by Luiz Fernando Peres on 2016-01-25.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "BEEBaseTouchable.h"

@implementation BEEBaseTouchable


- (instancetype) initWithImageNamed:(NSString *)imageNamed position:(CGPoint)pos andParentScene:(SKScene *)parent
{
    self = [super initWithImageNamed:imageNamed position:pos andParentScene:parent];
    
    if (self)
    {
        // this way the object would be a rectangle
        //self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
        
        // this way the physics body is applied to the image only, not to the alpha channel = 0
        self.physicsBody = [SKPhysicsBody bodyWithTexture:self.texture size:self.size];
        self.physicsBody.dynamic = YES;
        self.physicsBody.collisionBitMask = 0;
    }
    
    return self;
}

@end
