//
//  BEEBaseTouchable.m
//  beezy-bee
//
//  Created by Luiz Fernando Peres on 2016-01-25.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "BEEBaseTouchable.h"
#import "BEEPlayer.h"
#import "BEESessionHelper.h"
#import "BEEItem.h"
#import "BEEMonster.h"

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
    if([item.node isKindOfClass:[BEEItem class]])
    {
        BEEItem * objItem = (BEEItem *) item.node;
        
        if (objItem.hasBeenTouched)
            return;
        
        objItem.hasBeenTouched = YES;
        
        if ([player.node isKindOfClass:[BEEPlayer class]])
        {
            BEEPlayer *objPlayer = (BEEPlayer *)player.node;
            [objPlayer scoreIsSpecial:objItem.special];
        }
    }
    
    // delete them item from the screen
    [item.node removeFromParent];
}

- (void)player:(SKPhysicsBody *)player DidCollideWithMonster:(SKPhysicsBody *)monster
{
    if([monster.node isKindOfClass:[BEEMonster class]])
    {
        BEEMonster * objMonster = (BEEMonster *) monster.node;
        
        if (objMonster.hasBeenTouched)
            return;
        
        objMonster.hasBeenTouched = YES;
        
        if ([player.node isKindOfClass:[BEEPlayer class]])
        {
            BEEPlayer *objPlayer = (BEEPlayer *)player.node;
            [objPlayer dieWithMonster:YES];
        }
    }
}

@end
