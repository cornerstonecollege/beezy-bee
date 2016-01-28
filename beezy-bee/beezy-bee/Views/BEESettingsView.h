//
//  BEESettingsView.h
//  beezy-bee
//
//  Created by Hiroshi on 1/27/16.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface BEESettingsView : NSObject

+ (instancetype) sharedInstance;
- (void) createSettingsWithParentScene:(SKScene *)parent;
- (void) handleSettings:(UITouch *)touch andParentScene:(SKScene *)parent;

@end
