//
//  GameScene.m
//  LittlePlanetPrince
//
//  Created by an Airbnb Engineer on 3/12/14.
//  Copyright (c) 2014 inZania. All rights reserved.
//

#import "PPGameScene.h"
#import "IntroScene.h"
#import "NewtonScene.h"
#import "PPPlayerSprite.h"
#import "PPPlanetSprite.h"

static CGFloat const kJumpVelocity  = 400;
static CGFloat const kGravity       = 350;
static CGSize const kPlatformSize   = {120,20};
static CGFloat const kPlatformPadding = 20;
static CGFloat const kPlanetSpacing = 180;

@implementation PPGameScene
{
  PPPlayerSprite *_playerSprite;
  NSMutableArray *_planets;
  CGFloat _lastPlanetY;
  CCButton *_heightButton;
}

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (PPGameScene *)scene
{
  return [[self alloc] init];
}

// -----------------------------------------------------------------------

// Game over!
- (void)onGameOver {
  [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
                             withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:1.0f]];
}

// Go higher!
- (void)increaseHeight:(NSInteger)amount {

  // Increase score
  self.height += amount;
  _lastPlanetY -= amount;
  [_heightButton setTitle:[@(self.height) stringValue]];

  // Move all world objects down...
  NSArray *objects = [_planets arrayByAddingObject:_playerSprite];
  for(CCSprite *sprite in objects) {
    sprite.position = ccp(sprite.position.x, sprite.position.y - amount);
  }

  // Check for off-scren planets...
  for(NSInteger x=0; x<_planets.count; x++) {
    PPPlanetSprite *planet = _planets[x];
    if((planet.position.y + planet.contentSize.height) < 0) {
      [planet removeFromParent];
      [_planets removeObjectAtIndex:x];
      x--;
    }
  }

  // Spawn planets...
  [self spawnPlanets];
}

- (void)gameLoop:(CCTime)dt {
  // Adjust the player's position...
  CGPoint playerLast = _playerSprite.position;
  CGFloat xPos = _playerSprite.position.x + _playerSprite.velocity.x * dt;
  if(_playerSprite.velocity.x < 0 && xPos < 0) {
    xPos = self.contentSize.width + xPos;
  }
  else if(_playerSprite.velocity.x > 0 && xPos > self.contentSize.width) {
    xPos = xPos - self.contentSize.width;
  }
  _playerSprite.velocity = ccp(_playerSprite.velocity.x, _playerSprite.velocity.y - kGravity * dt);
  _playerSprite.position = ccp(xPos, _playerSprite.position.y + _playerSprite.velocity.y * dt);

  // Check for collision with a planet...
  if(_playerSprite.velocity.y < 0) {
    _playerSprite.scaleY = MAX(_playerSprite.scaleY - dt, 0.66);
    for(PPPlanetSprite *planet in _planets) {
      CGRect platform = CGRectMake(planet.boundingBox.origin.x, planet.boundingBox.origin.y + planet.boundingBox.size.height - 5,
                                   planet.boundingBox.size.width, 5);
      CGFloat playerMovedBy = _playerSprite.position.y - playerLast.y;
      CGRect player = CGRectMake(_playerSprite.boundingBox.origin.x, _playerSprite.boundingBox.origin.y, _playerSprite.boundingBox.size.width, 5 + fabsf(playerMovedBy));
      if(CGRectIntersectsRect(platform, player) && !planet.gaseous) {
        // Collided!
        if(planet.killPlayer) {
          [self onGameOver];
          return;
        }

        [planet onPlayerJump];
        _playerSprite.velocity = ccp(_playerSprite.velocity.x, kJumpVelocity * planet.jumpMultiplier);

        [_playerSprite runAction:[CCActionScaleTo actionWithDuration:0.25 scaleX:1 scaleY:1]];
        break;
      }
    }
  }

  // Check for increasing height...
  NSInteger increaseHeightBy = _playerSprite.position.y - self.contentSize.height/2;
  if(increaseHeightBy > 0) {
    [self increaseHeight:increaseHeightBy];
  }

  // Check for game gover
  if((_playerSprite.position.y + _playerSprite.contentSize.height) < 0) {
    [self onGameOver];
    return;
  }
}

- (PPPlanetSprite*)createPlanetAt:(CGPoint)pos ofType:(NSString*)key {
  PPPlanetSprite *planet = [NSClassFromString(key) planet];
  planet.anchorPoint = ccp(0.5, 0);
  planet.position = pos;
  [_planets addObject:planet];
  [self addChild:planet];
  return planet;
}

- (PPPlanetSprite*)createPlanetAt:(CGPoint)pos {
  NSDictionary *map = @{@"PPBouncyPlanetSprite":@{@"chance":@(20),@"minHeight":@(200)},
                        @"PPStickyPlanetSprite":@{@"chance":@(30),@"minHeight":@(500)},
                        @"PPGasPlanetSprite":@{@"chance":@(70),@"minHeight":@(1000)},
                        @"PPStarPlanetSprite":@{@"chance":@(30),@"minHeight":@(1000)}};

  NSInteger idx = arc4random_uniform(map.allKeys.count);
  NSString *key = map.allKeys[idx];
  NSDictionary *def = map[key];
  NSInteger chance = [def[@"chance"] integerValue];
  NSInteger minHeight = [def[@"minHeight"] integerValue];
  if(minHeight > self.height || arc4random_uniform(100) > chance) {
    return nil;
  }
  return [self createPlanetAt:pos ofType:key];
}

// Creates a planet that does not intersect with others
- (void)spawnPlanets {
  CGPoint pos = CGPointMake(0, _lastPlanetY + kPlanetSpacing);

  if(pos.y > self.contentSize.height) {
    // The target Y is above the top of the screen; don't need a new planet, just yet.
    return;
  }
  BOOL intersects = NO;
  NSInteger tries = 0;
  do {
    tries++;
    pos = ccp(arc4random_uniform(self.contentSize.width - kPlatformSize.width) + kPlatformSize.width/2, pos.y);
    CGRect area = CGRectMake(pos.x - kPlatformSize.width/2 - kPlatformPadding, pos.y - kPlatformPadding,
                             kPlatformSize.width + kPlatformPadding *2, kPlatformSize.height + kPlatformPadding*2);
    intersects = NO;
    for(PPPlanetSprite *planet in _planets) {
      if(CGRectIntersectsRect(planet.boundingBox, area)) {
        intersects = YES;
        break;
      }
    }
    if(tries > 40) {
      return;
    }
  } while(intersects);
  [self createPlanetAt:pos ofType:@"PPNormalPlanetSprite"];
  _lastPlanetY = pos.y;
  pos.y += kPlatformSize.height + kPlatformPadding + arc4random_uniform(kPlanetSpacing/4 * 3);
  [self createPlanetAt:pos];
}

- (id)init
{
  // Apple recommend assigning self with supers return value
  self = [super init];
  if (!self) return(nil);

  // Enable touch handling on scene node
  self.userInteractionEnabled = YES;

  // Create a colored background (Dark Grey)
  CCNodeColor *background = [CCSprite spriteWithImageNamed:@"bkgd.png"];
  background.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
  [self addChild:background];

  // Add a sprite
  _playerSprite = [PPPlayerSprite spriteWithImageNamed:@"player1.png"];
  _playerSprite.anchorPoint = ccp(0.5, 0);
  _playerSprite.position  = ccp(self.contentSize.width/2,40);
  _playerSprite.velocity = ccp(0,kJumpVelocity);
  [self addChild:_playerSprite];

  // Add some starting planets
  _planets = [NSMutableArray new];
  [self createPlanetAt:ccp(_playerSprite.position.x, _playerSprite.position.y - 70) ofType:@"PPNormalPlanetSprite"];
  for(NSInteger x=0; x<10; x++) {
    [self spawnPlanets];
  }

  // Create a back button
  _heightButton = [CCButton buttonWithTitle:@"[ Menu ]" fontName:@"Verdana-Bold" fontSize:18.0f];
  _heightButton.positionType = CCPositionTypeNormalized;
  _heightButton.position = ccp(0.85f, 0.95f); // Top Right of screen
  [_heightButton setTarget:self selector:@selector(onBackClicked:)];
  [self addChild:_heightButton];

  [self schedule:@selector(gameLoop:) interval:1.f / 30.f];

  // done
	return self;
}

// -----------------------------------------------------------------------

- (void)dealloc
{
  // clean up code goes here
}

// -----------------------------------------------------------------------
#pragma mark - Enter & Exit
// -----------------------------------------------------------------------

- (void)onEnter
{
  // always call super onEnter first
  [super onEnter];

  // In pre-v3, touch enable and scheduleUpdate was called here
  // In v3, touch is enabled by setting userInterActionEnabled for the individual nodes
  // Per frame update is automatically enabled, if update is overridden

}

// -----------------------------------------------------------------------

- (void)onExit
{
  // always call super onExit last
  [super onExit];
}

// -----------------------------------------------------------------------
#pragma mark - Touch Handler
// -----------------------------------------------------------------------

-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
  CGPoint touchLoc = [touch locationInNode:self];
  _playerSprite.velocity = ccp(touchLoc.x - _playerSprite.position.x, _playerSprite.velocity.y);
}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onBackClicked:(id)sender
{
  // back to intro scene with transition
  [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
                             withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:1.0f]];
}

- (void)onNewtonClicked:(id)sender
{
  [[CCDirector sharedDirector] pushScene:[NewtonScene scene] withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:1.0f]];
}

// -----------------------------------------------------------------------

@end
