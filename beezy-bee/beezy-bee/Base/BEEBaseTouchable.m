//
//  BEEBaseTouchable.m
//  beezy-bee
//
//  Created by Luiz Fernando Peres on 2016-01-25.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "BEEBaseTouchable.h"
#import "BEEPlayer.h"

@implementation BEEBaseTouchable

BOOL hasSharedInstanceBeenCreated;

+ (instancetype) sharedInstance
{
    static BEEBaseTouchable *sharedStore;
    
    if (!sharedStore)
    {
        sharedStore = [[self alloc] init];
        hasSharedInstanceBeenCreated = YES;
    }
    
    return sharedStore;
}

- (instancetype) initWithImageNamed:(NSString *)imageNamed position:(CGPoint)pos andParentScene:(SKScene *)parent
{
    self = [super initWithImageNamed:imageNamed position:pos andParentScene:parent];
    
    if (self)
    {
        [self initializeObjectWithParent:parent];
    }
    
    return self;
}

- (instancetype)initWithImageNamed:(NSString *)imageNamed imageMovableName:(NSString *)imageMovableName position:(CGPoint)pos andParentScene:(SKScene *)parent
{
    self = [super initWithImageNamed:imageNamed imageMovableName:imageMovableName position:pos andParentScene:parent];
    
    if (self)
    {
        [self initializeObjectWithParent:parent];
    }
    
    return self;
}

- (void) initializeObjectWithParent:(SKScene *)parent
{
    // this way the object would be a rectangle
    //self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
    
    // this way the physics body is applied to the image only, not to the alpha channel = 0
    self.physicsBody = [SKPhysicsBody bodyWithTexture:self.texture size:self.size];
    self.physicsBody.dynamic = NO;
    self.physicsBody.collisionBitMask = 0;
    
    // set the sharedInstance to the delegate collision
    if ([parent isKindOfClass:[GameScene class]])
    {
        if (!hasSharedInstanceBeenCreated)
            ((GameScene *)parent).collisionDelegate = [BEEBaseTouchable sharedInstance];
    }
}

- (void)player:(SKPhysicsBody *)player DidCollideWithItem:(SKPhysicsBody *)item
{
    // delete them item from the screen
    [item.node removeFromParent];
    
    // make score
}

- (void)player:(SKPhysicsBody *)player DidCollideWithMonster:(SKPhysicsBody *)monster
{
    if ([player.node isKindOfClass:[BEEPlayer class]])
    {
        BEEPlayer *objPlayer = (BEEPlayer *)player.node;
        [objPlayer die];
    }
}

@end
