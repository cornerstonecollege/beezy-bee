//
//  BEEScoreView.m
//  beezy-bee
//
//  Created by Hiroshi on 1/27/16.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "BEEScoreView.h"
#import "BEESessionHelper.h"

@interface BEEScoreView ()

@property (nonatomic) NSMutableArray *objArray;

@end

@implementation BEEScoreView

+ (instancetype) sharedInstance
{
    static BEEScoreView *sharedStore;
    
    if (!sharedStore)
        sharedStore = [[self alloc] initPrivate];
    
    return sharedStore;
}

- (instancetype) init
{
    [NSException raise:@"Singleton" format:@"Use [BEEScoreView sharedInstance]"];
    return nil;
}

- (instancetype) initPrivate
{
    self = [super init];
    
    if (self)
    {
        _objArray = [NSMutableArray array];
    }
    
    return self;
}

- (void) createScoreWithParentScene:(SKScene *)parent
{
    [BEESessionHelper sharedInstance].currentScreen = BST_SCORE;
    
}

@end
