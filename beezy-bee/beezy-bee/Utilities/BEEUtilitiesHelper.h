//
//  BEEUtilitiesHelper.h
//  beezy-bee
//
//  Created by Hiroshi on 2/1/16.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface BEEUtilitiesHelper : NSObject

+ (instancetype) sharedInstance;

- (UIColor *) goldColor;
- (UIColor *) silverColor;
- (UIColor *) bronzeColor;

@end
