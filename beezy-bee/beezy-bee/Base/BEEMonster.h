//
//  BEEMonster.h
//  beezy-bee
//
//  Created by Luiz Fernando Peres on 2016-01-25.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "BEEBaseTouchable.h"
#import "GameScene.h"

@interface BEEMonster : BEEBaseTouchable

typedef NS_ENUM(NSUInteger, BEE_MONSTER_TYPE)
{
    BMT_MONSTER1 = 0,
    BMT_MONSTER2 = 1,
};

@end
