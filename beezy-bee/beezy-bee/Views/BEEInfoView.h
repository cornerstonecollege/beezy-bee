//
//  BEEInfoView.h
//  beezy-bee
//
//  Created by Hiroshi on 2/18/16.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface BEEInfoView : NSObject

+ (instancetype) sharedInstance;
- (void) createInfoWithParentScene:(SKScene *)parent;
- (void) handleInfo:(UITouch *)touch andParentScene:(SKScene *)parent;

@end
