//
//  IntroScene.m
//  LittlePlanetPrince
//
//  Created by an Airbnb Engineer on 3/5/14.
//  Copyright inZania 2014. All rights reserved.
//
// -----------------------------------------------------------------------

// Import the interfaces
#import "IntroScene.h"
#import "NewtonScene.h"
#import "PPGameScene.h"

// -----------------------------------------------------------------------
#pragma mark - IntroScene
// -----------------------------------------------------------------------

@implementation IntroScene

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (IntroScene *)scene
{
	return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
  // Create a colored background (Dark Grey)
  CCNodeColor *background = [CCSprite spriteWithImageNamed:@"bkgd.png"];
  background.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
  [self addChild:background];

    // Hello world
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"Planet Prince" fontName:@"Chalkduster" fontSize:36.0f];
    label.positionType = CCPositionTypeNormalized;
    label.color = [CCColor yellowColor];
    label.position = ccp(0.5f, 0.5f); // Middle of screen
    [self addChild:label];
    
    // Spinning scene button
    CCButton *spinningButton = [CCButton buttonWithTitle:@"[ Play Game ]" fontName:@"Chalkduster" fontSize:18.0f];
    spinningButton.positionType = CCPositionTypeNormalized;
    spinningButton.position = ccp(0.5f, 0.35f);
    [spinningButton setTarget:self selector:@selector(onPlayGameClicked:)];
    [self addChild:spinningButton];
	
    // done
	return self;
}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onPlayGameClicked:(id)sender
{
    // start spinning scene with transition
    [[CCDirector sharedDirector] replaceScene:[PPGameScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:1.0f]];
}

- (void)onNewtonClicked:(id)sender
{
    // start newton scene with transition
    // the current scene is pushed, and thus needs popping to be brought back. This is done in the newton scene, when pressing back (upper left corner)
    [[CCDirector sharedDirector] pushScene:[NewtonScene scene]
                            withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:1.0f]];
}

// -----------------------------------------------------------------------
@end
