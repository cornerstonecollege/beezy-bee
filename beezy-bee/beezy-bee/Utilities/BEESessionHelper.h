//
//  BEESessionHelper.h
//  beezy-bee
//
//  Created by Hiroshi on 1/26/16.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameScene.h"

@interface BEESessionHelper : NSObject <GameSceneTimerDelegate>

typedef enum
{
    BST_MAIN,
    BST_GAME,
    BST_SETTINGS,
    BST_SCORE,
}BEE_SCREEN_TYPE;


@property (nonatomic) BEE_SCREEN_TYPE currentScreen;

+ (instancetype) sharedInstance;
- (NSString *) getLocalizedStringForName:(NSString *)stringName;

@end
