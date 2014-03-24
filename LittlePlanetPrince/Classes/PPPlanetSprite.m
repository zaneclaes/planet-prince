//
//  PPPlanetSprite.m
//  LittlePlanetPrince
//
//  Created by an Airbnb Engineer on 3/12/14.
//  Copyright (c) 2014 inZania. All rights reserved.
//

#import "PPPlanetSprite.h"

@implementation PPPlanetSprite

- (CGFloat)jumpMultiplier {
  return 1.f;
}

- (void)onPlayerJump {
  
}

- (BOOL)killPlayer {
  return NO;
}

+ (id)planet {
  return [self spriteWithImageNamed:@"planet.png"];
}

@end
