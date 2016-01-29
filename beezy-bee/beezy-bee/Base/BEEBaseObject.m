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

@end
