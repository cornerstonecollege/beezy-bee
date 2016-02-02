//
//  BEEBackgroundElements.m
//  beezy-bee
//
//  Created by CICCC1 on 2016-02-01.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "BEEBackgroundElements.h"

@implementation BEEBackgroundElements

- (instancetype)initWithAudioTrack:(NSString *)audioTrack andMonsterTypes:(NSArray *)monsterTypes
{
    self = [super init];
    if (self)
    {
        _audioTrack = audioTrack;
        _monsterTypes = monsterTypes;
    }
    
    return self;
}

@end
