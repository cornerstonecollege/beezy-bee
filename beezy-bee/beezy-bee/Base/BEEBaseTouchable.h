//
//  BEEBaseTouchable.h
//  beezy-bee
//
//  Created by Luiz Fernando Peres on 2016-01-25.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "BEEBaseObject.h"
#import "GameScene.h"

@interface BEEBaseTouchable : BEEBaseObject <GameSceneCollisionDelegate>

#define BEE_PLAYER_MASK 0x1 << 0
#define BEE_MONSTER_MASK 0x1 << 1
#define BEE_ITEM_MASK 0x1 << 2

@end
