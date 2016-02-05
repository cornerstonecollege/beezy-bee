//
//  BEESharedPreferencesHelper.m
//  beezy-bee
//
//  Created by CICCC1 on 2016-01-29.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "BEESharedPreferencesHelper.h"
#import "BEEBackground.h"
#import "BEEAudioHelper.h"

@interface BEESharedPreferencesHelper ()

@property (nonatomic) BEESharedPreferences *sharedPreferences;

@end

@implementation BEESharedPreferencesHelper

+ (instancetype) sharedInstance
{
    static BEESharedPreferencesHelper *sharedInstance;
    
    if (!sharedInstance)
        sharedInstance = [[self alloc] initPrivate];
    
    return sharedInstance;
}

- (instancetype)init
{
    [NSException raise:@"Singleton" format:@"Use +[BEESharedPreferencesHelper sharedInstance]"];
    return nil;
}

- (instancetype) initPrivate
{
    self = [super init];
    if (self)
    {
        NSString *path = [self itemArchivePath];
        _sharedPreferences = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        
        if (!_sharedPreferences)
            _sharedPreferences = [[BEESharedPreferences alloc] initWithScores:[NSMutableDictionary dictionary] thePlayer:BPT_PLAYER1 theBackground:BBT_BACKGROUND1 andIsAudioEnabled:YES];
    }
    return self;
}

- (NSString *)itemArchivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories firstObject];
    return [documentDirectory stringByAppendingPathComponent:@"bee.archive"];
}

- (BOOL) saveChanges
{
    NSString *path = [self itemArchivePath];
    return [NSKeyedArchiver archiveRootObject:self.sharedPreferences toFile:path];
}

- (void) setIsAudioEnabled:(BOOL)isAudioEnabled
{
    self.sharedPreferences.isAudioEnabled = isAudioEnabled;
    if (self.sharedPreferences.isAudioEnabled)
    {
        [BEEBackground playAudioWithType:[self getBackgroundType]];
    }
    else
    {
        [[BEEAudioHelper sharedInstance] stop];
    }
}

- (BOOL) getIsAudioEnabled
{
    return self.sharedPreferences.isAudioEnabled;
}

- (void)setPlayerType:(BEE_PLAYER_TYPE)player
{
    self.sharedPreferences.thePlayer = player;
}

- (BEE_PLAYER_TYPE) getPlayerType
{
    return self.sharedPreferences.thePlayer;
}

- (void)setBackgroundType:(BEE_BACKGROUND_TYPE)background
{
    self.sharedPreferences.theBackground = background;
}

- (BEE_BACKGROUND_TYPE) getBackgroundType
{
    return self.sharedPreferences.theBackground;
}

- (void) setScore:(NSUInteger)score withPlayerType:(BEE_PLAYER_TYPE)playerType
{
    [self.sharedPreferences setScore:score withPlayerType:playerType];
}

- (NSDictionary *) getScores
{
    return self.sharedPreferences.scores;
}

@end
