//
//  BEEPlayer.m
//  beezy-bee
//
//  Created by Luiz Fernando Peres on 2016-01-25.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "BEEPlayer.h"
#import "BEESharedPreferencesHelper.h"
#import "BEESessionHelper.h"

@interface BEEPlayer ()

@property (nonatomic) BEE_PLAYER_TYPE playerType;

@end

@implementation BEEPlayer

#define MAX_RADIAN 0.5
#define MIN_RADIAN -1

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
        GameScene *gameScene = ((GameScene *)parent);
        gameScene.eventsDelegate = self;
        __weak BEEPlayer *weakSelf = self;
        [gameScene.timerDelegateArr addObject:weakSelf];
        
        self.physicsBody.categoryBitMask = BEE_PLAYER_MASK;
        self.physicsBody.dynamic = YES;
        self.physicsBody.allowsRotation = NO;
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

- (void)didTap
{
    // Too much
    //SKAction *sound = [SKAction playSoundFileNamed:@"bee_fly.mp3" waitForCompletion:NO];
    //[self runAction:sound];
    
    if (self.position.y < self.parent.frame.size.height)
    {
        self.physicsBody.velocity = CGVectorMake(0, 0);
        [self.physicsBody applyImpulse:CGVectorMake(0, 200)];
    }
}

- (void)didUpdateParentScene:(SKScene *)gameScene
{
    self.zRotation = [self clamp:self.physicsBody.velocity.dy * (self.physicsBody.velocity.dy < 0 ? 0.003 : 0.001)];
    
    if (self.position.y < 0)
        [self dieWithMonster:NO];
}

- (CGFloat) clamp:(CGFloat) value
{
    if( value > MAX_RADIAN)
    {
        return MAX_RADIAN;
    }
    else if( value < MIN_RADIAN)
    {
        return MIN_RADIAN;
    }
    else
    {
        return value;
    }
}

- (void) dieWithMonster:(BOOL)withMonster
{
    if (withMonster && [[BEESharedPreferencesHelper sharedInstance] getIsAudioEnabled])
    {
        SKAction *sound = [SKAction playSoundFileNamed:@"player_hit_monster.mp3" waitForCompletion:NO];
        __weak BEEPlayer *weakSelf = self;
        [self runAction:sound completion:^{
            [weakSelf die];
        }];
    }
    else
    {
        [self die];
    }
}

- (void) die
{
    [[BEESharedPreferencesHelper sharedInstance] setScore:[BEESessionHelper sharedInstance].userScore withPlayerType:self.playerType];
    [[BEESharedPreferencesHelper sharedInstance] saveChanges];
    
    [BEESessionHelper sharedInstance].isGameOver = YES;
}

- (void) scoreIsSpecial:(BOOL)isSpecial
{
    if ([[BEESharedPreferencesHelper sharedInstance] getIsAudioEnabled])
    {
        NSString *scoreSound = isSpecial ? @"player_special_score.mp3" : @"player_score.mp3";
        SKAction *sound = [SKAction playSoundFileNamed:scoreSound waitForCompletion:NO];
        [self runAction:sound];
    }
    
    [BEESessionHelper sharedInstance].userScore += isSpecial ? 2 : 1;
}

@end
