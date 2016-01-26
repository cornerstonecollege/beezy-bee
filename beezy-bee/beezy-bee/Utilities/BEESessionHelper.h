//
//  BEESessionHelper.h
//  beezy-bee
//
//  Created by Hiroshi on 1/26/16.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BEESessionHelper : NSObject

+ (instancetype) sharedInstance;
- (NSString *) getLocalizedStringForName:(NSString *)stringName;

@end
