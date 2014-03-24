//
//  PPPlanetSprite.h
//  LittlePlanetPrince
//
//  Created by an Airbnb Engineer on 3/12/14.
//  Copyright (c) 2014 inZania. All rights reserved.
//

#import "CCSprite.h"

@interface PPPlanetSprite : CCSprite

@property (nonatomic, readonly) BOOL killPlayer;
@property (nonatomic, readwrite) BOOL gaseous;
@property (nonatomic, readonly) CGFloat jumpMultiplier;

- (void)onPlayerJump;

+ (id)planet;

@end
