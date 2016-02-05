//
//  BEEAudioHelper.h
//  beezy-bee
//
//  Created by CICCC1 on 2016-02-04.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

@interface BEEAudioHelper : NSObject

+ (instancetype) sharedInstance;
- (void) playAudioWithFileName:(NSString *)audioname;
- (void) stop;

@end
