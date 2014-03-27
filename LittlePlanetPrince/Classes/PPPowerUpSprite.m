//
//  PPPowerUpSprite.m
//  LittlePlanetPrince
//
//  Created by an Airbnb Engineer on 3/26/14.
//  Copyright (c) 2014 inZania. All rights reserved.
//

#import "PPPowerUpSprite.h"

@implementation PPPowerUpSprite

- (NSTimeInterval)duration {
  return 2;
}

+ (id)powerup {
  return [self spriteWithImageNamed:@"player2.png"];
}

@end
