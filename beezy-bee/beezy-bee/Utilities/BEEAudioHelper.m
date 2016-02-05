//
//  BEEAudioHelper.m
//  beezy-bee
//
//  Created by CICCC1 on 2016-02-04.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "BEEAudioHelper.h"

@interface BEEAudioHelper ()

@property (nonatomic) AVAudioPlayer *audioPlayer;
@property (nonatomic) NSString *lastAudio;

@end

@implementation BEEAudioHelper

+ (instancetype) sharedInstance
{
    static BEEAudioHelper *sharedStore;
    
    if (!sharedStore)
        sharedStore = [[self alloc] initPrivate];
    
    return sharedStore;
}

- (instancetype) init
{
    [NSException raise:@"Singleton" format:@"Use [BEEAudioHelper sharedInstance]"];
    return nil;
}

- (instancetype) initPrivate
{
    self = [super init];
    if (self)
    {
    }
    return self;
}

- (void) playAudioWithFileName:(NSString *)audioName
{
    if ([self.audioPlayer isPlaying])
    {
        if (audioName == self.lastAudio)
            return;
        else
            [self.audioPlayer stop];
    }
    
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@.mp3", [[NSBundle mainBundle] resourcePath], audioName]];
    
    NSError *error;
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    self.audioPlayer.numberOfLoops = -1;
    
    if (!self.audioPlayer)
        NSLog(@"%@", [error localizedDescription]);
    else
    {
        [self.audioPlayer play];
        self.lastAudio = audioName;
    }
}

- (void) stop
{
    [self.audioPlayer stop];
}

@end
