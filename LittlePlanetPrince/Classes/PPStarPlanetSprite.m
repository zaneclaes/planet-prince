//
//  PPStarPlanetSprite.m
//  LittlePlanetPrince
//
//  Created by an Airbnb Engineer on 3/19/14.
//  Copyright (c) 2014 inZania. All rights reserved.
//

#import "PPStarPlanetSprite.h"

@implementation PPStarPlanetSprite

- (BOOL)killPlayer {
  return YES;
}

+ (id)planet {
  PPPlanetSprite *sprite = [self spriteWithImageNamed:@"planet5.png"];
  return sprite;
}

@end
