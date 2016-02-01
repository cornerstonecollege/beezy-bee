//
//  BEENewGameView.h
//  beezy-bee
//
//  Created by Hiroshi on 1/27/16.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface BEENewGameView : NSObject

+ (instancetype) sharedInstance;
- (void) createNewGameWithParentScene:(SKScene *)parent;
- (void) handleNewGame:(UITouch *)touch andParentScene:(SKScene *)parent;

@end
