//
//  PPGasPlanetSprite.m
//  LittlePlanetPrince
//
//  Created by an Airbnb Engineer on 3/19/14.
//  Copyright (c) 2014 inZania. All rights reserved.
//

#import "PPGasPlanetSprite.h"

@implementation PPGasPlanetSprite

- (BOOL)gaseous {
  return YES;
}

+ (id)planet {
  PPPlanetSprite *sprite = [super planet];
  sprite.color = [CCColor grayColor];
  sprite.opacity = 0.5;
  return sprite;
}

@end
