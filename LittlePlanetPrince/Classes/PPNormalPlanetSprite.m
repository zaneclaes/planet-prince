//
//  PPNormalPlanetSprite.m
//  LittlePlanetPrince
//
//  Created by an Airbnb Engineer on 3/22/14.
//  Copyright (c) 2014 inZania. All rights reserved.
//

#import "PPNormalPlanetSprite.h"

@implementation PPNormalPlanetSprite

- (void)onPlayerJump {
  self.opacity = MAX(0, self.opacity - 0.34);
  if(self.opacity <= 0) {
    self.gaseous = YES;
  }
}

+ (id)planet {
  return [self spriteWithImageNamed:@"planet1.png"];
}

@end
