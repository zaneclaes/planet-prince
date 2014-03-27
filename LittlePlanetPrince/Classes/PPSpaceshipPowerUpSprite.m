//
//  PPSpaceshipPowerUpSprite.m
//  LittlePlanetPrince
//
//  Created by an Airbnb Engineer on 3/26/14.
//  Copyright (c) 2014 inZania. All rights reserved.
//

#import "PPSpaceshipPowerUpSprite.h"

@implementation PPSpaceshipPowerUpSprite

- (CGFloat)velocity {
  return 1000;
}

+ (id)powerup {
  return [self spriteWithImageNamed:@"player2.png"];
}

@end
