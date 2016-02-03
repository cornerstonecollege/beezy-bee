//
//  BEEBaseObject.h
//  beezy-bee
//
//  Created by Luiz Fernando Peres on 2016-01-25.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface BEEBaseObject : SKSpriteNode

- (instancetype) initWithImageNamed:(NSString *)imageName position:(CGPoint)pos andParentScene:(SKScene *)parent;
- (instancetype) initWithImageNamed:(NSString *)imageNamed imageMovableName:(NSString *)imageMovableName position:(CGPoint)pos andParentScene:(SKScene *)parent;

@end
