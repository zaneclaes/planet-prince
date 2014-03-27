//
//  PPPowerUpSprite.h
//  LittlePlanetPrince
//
//  Created by an Airbnb Engineer on 3/26/14.
//  Copyright (c) 2014 inZania. All rights reserved.
//

#import "CCSprite.h"

@interface PPPowerUpSprite : CCSprite

@property (nonatomic, readonly) NSTimeInterval duration;
@property (nonatomic, readonly) CGFloat velocity;

+ (id)powerup;

@end
