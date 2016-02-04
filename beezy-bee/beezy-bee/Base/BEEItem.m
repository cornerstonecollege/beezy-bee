//
//  BEEPoint.m
//  beezy-bee
//
//  Created by Luiz Fernando Peres on 2016-01-25.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "BEEItem.h"

@implementation BEEItem

- (instancetype)init
{
    [NSException raise:@"Wrong initializer" format:@"Use initWithImageNamed:position:andParentScene:"];
    return nil;
}

- (instancetype) initWithImageNamed:(NSString *)imageNamed position:(CGPoint)pos andParentScene:(SKScene *)parent
{
    self = [super initWithImageNamed:imageNamed position:pos andParentScene:parent];
    
    if (self)
    {
        [self initialize];
    }
    
    return self;
}

- (instancetype)initWithImageNamed:(NSString *)imageNamed imageMovableName:(NSString *)imageMovableName position:(CGPoint)pos andParentScene:(SKScene *)parent
{
    self = [super initWithImageNamed:imageNamed imageMovableName:imageMovableName position:pos andParentScene:parent];
    
    if (self)
    {
        [self initialize];
    }
    
    return self;
}

- (void) initialize
{
    self.physicsBody.categoryBitMask = BEE_ITEM_MASK;
    self.physicsBody.contactTestBitMask = BEE_PLAYER_MASK;
}

@end
