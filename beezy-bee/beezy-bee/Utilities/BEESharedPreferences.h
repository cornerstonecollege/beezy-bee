//
//  BEESharedPreferences.h
//  beezy-bee
//
//  Created by CICCC1 on 2016-01-29.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BEEPlayer.h"
#import "BEEBackground.h"

@interface BEESharedPreferences : NSObject <NSCoding>

@property (nonatomic, readonly, copy) NSDictionary *scores;
@property (nonatomic) BOOL isAudioEnabled;
@property (nonatomic) BEE_PLAYER_TYPE thePlayer;
@property (nonatomic) BEE_BACKGROUND_TYPE theBackground;

- (void) setScore:(NSUInteger)score withPlayerType:(BEE_PLAYER_TYPE)playerType;

- (instancetype)initWithScores:(NSMutableDictionary *)scores thePlayer:(BEE_PLAYER_TYPE)player theBackground:(BEE_BACKGROUND_TYPE)background andIsAudioEnabled:(BOOL)isAudioEnabled;

@end
