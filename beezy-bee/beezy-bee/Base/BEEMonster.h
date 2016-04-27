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
    BMT_MONSTER3 = 2,
    BMT_MONSTER4 = 3,
};

@property (nonatomic, readonly) BEE_MONSTER_TYPE type;
@property (nonatomic) BOOL hasBeenTouched;

- (void) setType:(BEE_MONSTER_TYPE)type;

@end
