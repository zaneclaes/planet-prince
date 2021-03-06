//
//  PPStickyPlanetSprite.m
//  LittlePlanetPrince
//
//  Created by an Airbnb Engineer on 3/19/14.
//  Copyright (c) 2014 inZania. All rights reserved.
//

#import "PPStickyPlanetSprite.h"

@implementation PPStickyPlanetSprite

- (CGFloat)jumpMultiplier {
  return .75f;
}

+ (id)planet {
  PPPlanetSprite *sprite = [self spriteWithImageNamed:@"planet3.png"];
  return sprite;
}

@end
