//
//  BEEPlayer.m
//  beezy-bee
//
//  Created by Luiz Fernando Peres on 2016-01-25.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "BEEPlayer.h"

@implementation BEEPlayer

- (instancetype)init
{
    [NSException raise:@"Wrong initializer" format:@"Use [BEEPlayer shareInstance]"];
    return nil;
}

- (instancetype) initWithImageNamed:(NSString *)imageNamed position:(CGPoint)pos andParentScene:(SKScene *)parent
{
    self = [super initWithImageNamed:imageNamed position:pos andParentScene:parent];
    
    if (self)
    {
        if ([parent isKindOfClass:[GameScene class]])
        {
            ((GameScene *)parent).eventsDelegate = self;
        }
    }
    
    return self;
}

- (void)didTap
{
    SKAction * actionMove = [SKAction moveTo:CGPointMake(self.position.x, self.position.y + 10) duration:0.2];
    
    [self runAction:actionMove];
}

@end
