//
//  BEEPlayer.m
//  beezy-bee
//
//  Created by Luiz Fernando Peres on 2016-01-25.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "BEEPlayer.h"

@interface BEEPlayer ()

@property (nonatomic) NSDictionary *dicStrings;

@end

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
            self.physicsBody.dynamic = YES;
        }
    }
    
    return self;
}

+ (instancetype) sharedInstance
{
    static BEEPlayer *sharedStore;
    
    if (!sharedStore)
        sharedStore = [[self alloc] initPrivate];
    
    return sharedStore;
}

- (NSArray *)playerArray
{
    return @[@"First-Bee", @"Second-Bee", @"Third-Bee"];
}

- (instancetype) initPrivate
{
    self = [super init];
    if (self)
    {
        NSString *fname = [[NSBundle mainBundle] pathForResource:@"" ofType:@"strings"];
        self.dicStrings = [NSDictionary dictionaryWithContentsOfFile:fname];
    }
    return self;
}

- (void)didTap
{
    SKAction * actionMove = [SKAction moveTo:CGPointMake(self.position.x, self.position.y + 50) duration:0.3];
    
    [self runAction:actionMove];
}

@end
