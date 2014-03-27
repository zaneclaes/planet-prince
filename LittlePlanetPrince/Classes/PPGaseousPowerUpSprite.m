//
//  PPGaseousPowerUpSprite.m
//  LittlePlanetPrince
//
//  Created by an Airbnb Engineer on 3/26/14.
//  Copyright (c) 2014 inZania. All rights reserved.
//

#import "PPGaseousPowerUpSprite.h"

@implementation PPGaseousPowerUpSprite

- (CGFloat)velocity {
  return 50;
}

+ (id)powerup {
  return [self spriteWithImageNamed:@"player4.png"];
}

@end
