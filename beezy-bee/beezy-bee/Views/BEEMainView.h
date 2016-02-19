//
//  BEEMainView.h
//  beezy-bee
//
//  Created by Hiroshi on 1/26/16.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface BEEMainView : NSObject

+ (instancetype) sharedInstance;
- (void) createMenuWithParentScene:(SKScene *)parent;
- (void) handleMain:(UITouch *)touch andParentScene:(SKScene *)parent;

@end
