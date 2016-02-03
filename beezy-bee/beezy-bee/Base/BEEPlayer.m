//
//  BEEPlayer.m
//  beezy-bee
//
//  Created by Luiz Fernando Peres on 2016-01-25.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "BEEPlayer.h"
#import "BEESharedPreferencesHelper.h"

@interface BEEPlayer ()

@property (nonatomic) BEE_PLAYER_TYPE playerType;

@end

@implementation BEEPlayer

- (instancetype)init
{
    [NSException raise:@"Wrong initializer" format:@"Use [BEEPlayer sharedInstance]"];
    return nil;
}

- (instancetype) initWithImageNamed:(NSString *)imageNamed position:(CGPoint)pos andParentScene:(SKScene *)parent
{
    self = [super initWithImageNamed:imageNamed position:pos andParentScene:parent];
    
    if (self)
    {
        [self initilizePlayerWithParent:parent];
    }
    
    return self;
}

- (instancetype)initWithImageNamed:(NSString *)imageNamed imageMovableName:(NSString *)imageMovableName position:(CGPoint)pos andParentScene:(SKScene *)parent
{
    self = [super initWithImageNamed:imageNamed imageMovableName:imageMovableName position:pos andParentScene:parent];
    if (self)
    {
        [self initilizePlayerWithParent:parent];
    }
    
    return self;
}

- (void) initilizePlayerWithParent:(SKScene *)parent
{
    if ([parent isKindOfClass:[GameScene class]])
    {
        ((GameScene *)parent).eventsDelegate = self;
        self.physicsBody.categoryBitMask = BEE_PLAYER_MASK;
        self.physicsBody.dynamic = YES;
    }
}

+ (instancetype) playerWithParent:(SKScene *)parent
{
    BEEPlayer *player;
    
    NSString *strImgPlayer = [[BEEPlayer playerArray] objectAtIndex:[[BEESharedPreferencesHelper sharedInstance] getPlayerType]];
        
    player = [[BEEPlayer alloc] initWithImageNamed:strImgPlayer imageMovableName:[NSString stringWithFormat:@"%@-Move", strImgPlayer] position:CGPointMake(CGRectGetMidX(parent.frame)/2,CGRectGetMidY(parent.frame)) andParentScene:parent];
    player.playerType = [[BEESharedPreferencesHelper sharedInstance] getPlayerType];
    
    return player;
}

+ (NSArray *)playerArray
{
    return @[@"First-Bee", @"Second-Bee", @"Third-Bee"];
}

- (instancetype) initPrivate
{
    self = [super init];
    if (self)
    {
    }
    return self;
}

- (void)didTap
{
    SKAction * actionMove = [SKAction moveTo:CGPointMake(self.position.x, self.position.y + 50) duration:0.3];
    
    [self runAction:actionMove];
}

@end
