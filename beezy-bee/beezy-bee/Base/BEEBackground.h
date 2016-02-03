//
//  BEEBackground.h
//  beezy-bee
//
//  Created by CICCC1 on 2016-01-29.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "BEEBaseObject.h"
#import "BEEBackgroundElements.h"
#import <Foundation/Foundation.h>

@interface BEEBackground : NSObject

typedef NS_ENUM(NSUInteger, BEE_BACKGROUND_TYPE)
{
    BBT_BACKGROUND1 = 0,
    BBT_BACKGROUND2 = 1,
};

+ (void) backgroundWithType:(BEE_BACKGROUND_TYPE)type andParentScene:(SKScene *)gameScene;
+ (BEEBackgroundElements *) getConfigForBackgroundType:(BEE_BACKGROUND_TYPE)type;

+ (void) background1WithParentScene:(SKScene *)gameScene;
+ (void) background2WithParentScene:(SKScene *)gameScene;

// + (void) background2;
// ...

@end
