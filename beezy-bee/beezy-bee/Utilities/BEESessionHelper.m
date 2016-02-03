//
//  BEESessionHelper.m
//  beezy-bee
//
//  Created by Hiroshi on 1/26/16.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "BEESessionHelper.h"

@interface BEESessionHelper ()

@property (nonatomic) NSDictionary *dicStrings;

@end

@implementation BEESessionHelper

+ (instancetype) sharedInstance
{
    static BEESessionHelper *sharedStore;
    
    if (!sharedStore)
        sharedStore = [[self alloc] initPrivate];
    
    return sharedStore;
}

- (instancetype) init
{
    [NSException raise:@"Singleton" format:@"Use [BEESessionHelper sharedInstance]"];
    return nil;
}

- (instancetype) initPrivate
{
    self = [super init];
    if (self)
    {
        NSString *fname = [[NSBundle mainBundle] pathForResource:@"" ofType:@"strings"];
        self.dicStrings = [NSDictionary dictionaryWithContentsOfFile:fname];
    }
    return self;
}

- (NSString *)getLocalizedStringForName:(NSString *)stringName
{
    return [self.dicStrings objectForKey:stringName];
}

@end
