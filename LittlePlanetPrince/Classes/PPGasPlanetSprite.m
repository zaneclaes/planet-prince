//
//  PPGasPlanetSprite.m
//  LittlePlanetPrince
//
//  Created by an Airbnb Engineer on 3/19/14.
//  Copyright (c) 2014 inZania. All rights reserved.
//

#import "PPGasPlanetSprite.h"
#import "PPGaseousPowerUpSprite.h"

@implementation PPGasPlanetSprite

- (PPPowerUpSprite*)powerup {
  return [PPGaseousPowerUpSprite powerup];
}

- (BOOL)gaseous {
  return YES;
}

+ (id)planet {
  PPPlanetSprite *sprite = [self spriteWithImageNamed:@"planet6.png"];
  sprite.opacity = 0.5;
  return sprite;
}

@end
