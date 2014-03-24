//
//  PPBouncyPlanetSprite.m
//  LittlePlanetPrince
//
//  Created by an Airbnb Engineer on 3/19/14.
//  Copyright (c) 2014 inZania. All rights reserved.
//

#import "PPBouncyPlanetSprite.h"

@implementation PPBouncyPlanetSprite

- (CGFloat)jumpMultiplier {
  return 2.5f;
}

+ (id)planet {
  PPBouncyPlanetSprite *sprite = [super planet];
  sprite.color = [CCColor greenColor];
  return sprite;
}

@end
