//
//  BEESessionHelper.h
//  beezy-bee
//
//  Created by Hiroshi on 1/26/16.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameScene.h"

@interface BEESessionHelper : NSObject

typedef enum
{
    BST_MAIN,
    BST_GAME,
    BST_SETTINGS,
    BST_SCORE,
    BST_INFO,
}BEE_SCREEN_TYPE;


@property (nonatomic) BEE_SCREEN_TYPE currentScreen;
@property (nonatomic) NSUInteger userScore;
@property (nonatomic) BOOL isGameOver;

+ (instancetype) sharedInstance;
- (NSString *) getLocalizedStringForName:(NSString *)stringName;



@end
