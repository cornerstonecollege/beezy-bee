//
//  BEEPoint.m
//  beezy-bee
//
//  Created by Luiz Fernando Peres on 2016-01-25.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "BEEItem.h"

@implementation BEEItem

- (instancetype) initWithImageNamed:(NSString *)imageNamed position:(CGPoint)pos andParentScene:(SKScene *)parent
{
    self = [super initWithImageNamed:imageNamed position:pos andParentScene:parent];
    
    if (self)
    {
        self.physicsBody.categoryBitMask = BEE_ITEM_MASK;
        self.physicsBody.contactTestBitMask = BEE_PLAYER_MASK;
    }
    
    return self;
}

@end
