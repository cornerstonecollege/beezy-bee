//
//  BEEPlayer.h
//  beezy-bee
//
//  Created by Luiz Fernando Peres on 2016-01-25.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "BEEBaseTouchable.h"
#import "GameScene.h"

@interface BEEPlayer : BEEBaseTouchable <GameSceneEvents, GameSceneTimerDelegate>

typedef NS_ENUM(NSUInteger, BEE_PLAYER_TYPE)
{
    BPT_PLAYER1 = 0,
    BPT_PLAYER2 = 1,
    BPT_PLAYER3 = 2,
};

+ (instancetype) playerWithParent:(SKScene *)parent;
+ (NSArray*) playerArray;
- (void) scoreIsSpecial:(BOOL)isSpecial;
- (void) dieWithMonster:(BOOL)withMonster;

@end
