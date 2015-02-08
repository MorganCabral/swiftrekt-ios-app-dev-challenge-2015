//
//  GameScene.swift
//  app-dev-challenge
//
//  Created by Morgan Cabral on 2/6/15.
//  Copyright (c) 2015 Team SwiftRekt. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {

  override func didMoveToView(view: SKView) {
    // Initialize the background sprite.
    backgroundNode = SKSpriteNode(imageNamed: "background")
    backgroundNode.anchorPoint = CGPoint(x: 0, y: 1)
    backgroundNode.position = CGPointMake(0, size.height)
    
    var uiOrigin = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
    
    // Initialize the counterdown timer. This will go away after five seconds.
    countdownTimerSprite = IntroCountdownSprite();
    countdownTimerSprite.position = uiOrigin
    
    // Initialize sprites for the wizards.
    var leftWizardStart = CGPoint(x: -300.0, y: 300.0)
    var leftWizardEnd = CGPoint(x: size.width * 0.15, y: 300.0)
    
    var rightWizardStart = CGPoint(x: size.width + 300.0, y: 300.0)
    var rightWizardEnd = CGPoint(x: size.width * 0.85, y: 300.0)
    
    var wizardOne = WizardSprite(startingPosition: leftWizardStart, endingPosition: leftWizardEnd, facesRight: true)
    var wizardTwo = WizardSprite(startingPosition: rightWizardStart, endingPosition: rightWizardEnd, facesRight: false)
    
    // Create the spell sprites.
    var leftSpellCastPosition = CGPoint( x: size.width * 0.15, y : 300.0 );
    var rightSpellCastPosition = CGPoint( x: size.width * 0.85, y : 300.0 );
    
    // Initalize Health Sprites
    var playerOneHealthSprite = HealthBarSprite(positionOnScene: CGPoint(x: 100.0, y: 20.0))
    var playerTwoHealthSprite = HealthBarSprite(positionOnScene: CGPoint(x: size.width - 100.0, y: size.height - 40.0))
    
    // Add the composed set of game sprites to the scene.
    // Make sure this is the absolutely last thing that happens.
    self.addChild(backgroundNode)
    
    // Add the wizards.
    self.addChild(wizardOne)
    self.addChild(wizardTwo)
    
    // Add the countdown timer in.
    self.addChild(countdownTimerSprite)
    
    // Add the HP Player One Label
    self.addChild(playerOneHealthSprite)
    self.addChild(playerTwoHealthSprite)
    
    // Add placeholder spell sprite
    var leftSpellStart = CGPoint(x: width * 0.15, y: 300.0)
    var leftSpellEnd = CGPoint(x: width, y: 100.0)
    var placeholderSpell = SpellElement.Fire
    
    var placeholderSpellSprite = SpellSprite(spell: placeholderSpell, startingPosition: leftSpellStart, endingPosition: leftSpellEnd, facesRight: true)
    
    // Start up the initialization animation.
    playerOneWizard.doInitialAnimation();
    self.addChild(placeholderSpellSprite)
    placeholderSpellSprite.doInitialAnimation()

    // Make moves son.
    wizardOne.doInitialAnimation()
    wizardTwo.doInitialAnimation()
  }
  
  override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
    /* Called when a touch begins */
//    
//    for touch: AnyObject in touches {
//      let location = touch.locationInNode(self)
//      
//      let sprite = SKSpriteNode(imageNamed:"Spaceship")
//      
//      sprite.xScale = 0.5
//      sprite.yScale = 0.5
//      sprite.position = location
//      
//      let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
//      
//      sprite.runAction(SKAction.repeatActionForever(action))
//      
//      self.addChild(sprite)
//    }
  }
  
  override func update(currentTime: CFTimeInterval) {
    if !_hasInitializedCountdown {
      countdownTimerSprite.initializeCountdown(currentTime)
      _hasInitializedCountdown = true
    }
    
    if !_hasSetGameBeginTime {
      _gameBeginTime = currentTime + 6
      _hasSetGameBeginTime = true
    }

    countdownTimerSprite.updateIntroAnimationStartupTimer(currentTime)
    
    // If the intro animation hasn't started, don't do anything.
    if !isGameStarted( currentTime ) {
      return
    }
    
  }
  
  func isGameStarted( currentTime : CFTimeInterval ) -> Bool {
    return currentTime >= _gameBeginTime
  }
  
  var backgroundNode : SKSpriteNode!
  
  private var _gameBeginTime : CFTimeInterval!
  private var _hasSetGameBeginTime : Bool = false
  
  var countdownTimerSprite : IntroCountdownSprite!
  private var _hasInitializedCountdown : Bool = false
}
