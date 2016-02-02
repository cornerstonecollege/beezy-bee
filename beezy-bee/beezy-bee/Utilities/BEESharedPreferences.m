//
//  BEESharedPreferences.m
//  beezy-bee
//
//  Created by CICCC1 on 2016-01-29.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "BEESharedPreferences.h"

@interface BEESharedPreferences ()

@property (nonatomic) NSMutableDictionary *mutScores;

@end

@implementation BEESharedPreferences

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    NSMutableDictionary *dicScores = [aDecoder decodeObjectForKey:@"scores"];
    BOOL isAudioEnabled = [((NSNumber *) [aDecoder decodeObjectForKey:@"isAudioEnabled"]) boolValue];
    BEE_PLAYER_TYPE thePlayer = [((NSNumber *) [aDecoder decodeObjectForKey:@"thePlayer"]) unsignedIntegerValue];
    BEE_BACKGROUND_TYPE theBackground = [((NSNumber *) [aDecoder decodeObjectForKey:@"theBackground"]) unsignedIntegerValue];
    
    return [self initWithScores:dicScores thePlayer:thePlayer theBackground:theBackground andIsAudioEnabled:isAudioEnabled];
}

- (instancetype)initWithScores:(NSMutableDictionary *)scores thePlayer:(BEE_PLAYER_TYPE)player theBackground:(BEE_BACKGROUND_TYPE)background andIsAudioEnabled:(BOOL)isAudioEnabled
{
    self = [super init];
    if (self)
    {
        _mutScores = scores;
        _isAudioEnabled = isAudioEnabled;
        _thePlayer = player;
        _theBackground = background;
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.mutScores forKey:@"scores"];
    [aCoder encodeObject:[NSNumber numberWithBool:self.isAudioEnabled] forKey:@"isAudioEnabled"];
    [aCoder encodeObject:[NSNumber numberWithUnsignedInteger:self.thePlayer] forKey:@"thePlayer"];
    [aCoder encodeObject:[NSNumber numberWithUnsignedInteger:self.theBackground] forKey:@"theBackground"];
}

- (void)setScore:(NSUInteger)score withPlayerType:(BEE_PLAYER_TYPE)playerType
{
    NSNumber *lastScore = (NSNumber *)[self.mutScores objectForKey:[NSNumber numberWithUnsignedInteger:playerType]];
    if (lastScore)
    {
        if([lastScore unsignedIntegerValue] < score)
            [self.mutScores setObject:[NSNumber numberWithUnsignedInteger:score] forKey:[NSNumber numberWithUnsignedInteger:playerType]];
    }
    else
    {
        [self.mutScores setObject:[NSNumber numberWithUnsignedInteger:score] forKey:[NSNumber numberWithUnsignedInteger:playerType]];
    }
}

- (NSDictionary *) scores
{
    if ([self.mutScores count] == 0)
    {
        [self.mutScores setObject:[NSNumber numberWithUnsignedInteger:0] forKey:[NSNumber numberWithUnsignedInteger:BPT_PLAYER1]];
        [self.mutScores setObject:[NSNumber numberWithUnsignedInteger:0] forKey:[NSNumber numberWithUnsignedInteger:BPT_PLAYER2]];
        [self.mutScores setObject:[NSNumber numberWithUnsignedInteger:0] forKey:[NSNumber numberWithUnsignedInteger:BPT_PLAYER3]];
    }
    
    return [self.mutScores copy];
}

@end
