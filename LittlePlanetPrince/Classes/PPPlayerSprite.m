//
//  PPPlayerSprite.m
//  LittlePlanetPrince
//
//  Created by an Airbnb Engineer on 3/12/14.
//  Copyright (c) 2014 inZania. All rights reserved.
//

#import "PPPlayerSprite.h"
#import "PPPowerUpSprite.h"

@interface PPPlayerSprite ()
@property (nonatomic, strong) CCSpriteFrame *origFrame;
@end

@implementation PPPlayerSprite

- (void)gainPowerup:(PPPowerUpSprite*)powerup {
  if(!self.origFrame) {
    self.origFrame = self.spriteFrame;
  }
  self.spriteFrame = powerup.spriteFrame;
  if(powerup.velocity) {
    self.velocity = ccp(self.velocity.x, powerup.velocity);
  }
  [self performSelector:@selector(setSpriteFrame:) withObject:self.origFrame afterDelay:powerup.duration];
}

@end
