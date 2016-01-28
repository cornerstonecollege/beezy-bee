//
//  BEEScoreView.h
//  beezy-bee
//
//  Created by Hiroshi on 1/27/16.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface BEEScoreView : NSObject

+ (instancetype) sharedInstance;
- (void) createScoreWithParentScene:(SKScene *)parent;
- (void) handleScore:(UITouch *)touch andParentScene:(SKScene *)parent;

@end
