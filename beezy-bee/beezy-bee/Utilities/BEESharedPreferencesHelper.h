//
//  BEESharedPreferencesHelper.h
//  beezy-bee
//
//  Created by CICCC1 on 2016-01-29.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BEESharedPreferences.h"

@interface BEESharedPreferencesHelper : NSObject

+ (instancetype) sharedInstance;

- (void) setIsAudioEnabled:(BOOL)isAudioEnabled;
- (BOOL) getIsAudioEnabled;

- (void) setBackground:(BEE_BACKGROUND_TYPE)background;
- (BEE_BACKGROUND_TYPE) getBackground;

- (void) setPlayer:(BEE_PLAYER_TYPE)player;
- (BEE_PLAYER_TYPE) getPlayer;

- (void) setScore:(NSUInteger)score withPlayerType:(BEE_PLAYER_TYPE)playerType;
- (NSDictionary *) getScores;

- (BOOL) saveChanges;

@end
