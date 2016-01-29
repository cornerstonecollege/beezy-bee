//
//  BEEPlayer.h
//  beezy-bee
//
//  Created by Luiz Fernando Peres on 2016-01-25.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "BEEBaseTouchable.h"
#import "GameScene.h"

@interface BEEPlayer : BEEBaseTouchable <GameSceneEvents>

typedef enum
{
    PLAYER1,
    PLAYER2,
}BEE_PLAYER_TYPE;

@property (nonatomic) BEE_PLAYER_TYPE currentPlayer;

+ (instancetype) sharedInstance;

@end
