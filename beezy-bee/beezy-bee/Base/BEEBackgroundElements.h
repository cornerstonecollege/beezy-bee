//
//  BEEBackgroundElements.h
//  beezy-bee
//
//  Created by CICCC1 on 2016-02-01.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BEEMonster.h"

@interface BEEBackgroundElements : NSObject

@property (nonatomic, readonly) NSString *audioTrack;
@property (nonatomic, readonly) NSArray *monsterTypes;

- (instancetype) initWithAudioTrack:(NSString *)audioTrack andMonsterTypes:(NSArray *)monsterTypes;

@end
