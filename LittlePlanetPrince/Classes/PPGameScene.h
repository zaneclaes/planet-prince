//
//  GameScene.h
//  LittlePlanetPrince
//
//  Created by an Airbnb Engineer on 3/12/14.
//  Copyright (c) 2014 inZania. All rights reserved.
//

#import "CCScene.h"

@interface PPGameScene : CCScene
@property (nonatomic, readwrite) NSInteger height;

+ (PPGameScene *)scene;

@end
