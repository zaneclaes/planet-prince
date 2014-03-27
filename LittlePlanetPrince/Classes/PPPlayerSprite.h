//
//  PPPlayerSprite.h
//  LittlePlanetPrince
//
//  Created by an Airbnb Engineer on 3/12/14.
//  Copyright (c) 2014 inZania. All rights reserved.
//

#import "CCSprite.h"

@class PPPowerUpSprite;

@interface PPPlayerSprite : CCSprite
@property (nonatomic, readwrite) CGPoint velocity;

- (void)gainPowerup:(PPPowerUpSprite*)powerup;

@end
