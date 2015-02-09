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
    // Set up our player models.
    players = [ Player(hitPoints: 100), Player(hitPoints: 100)]
    
    // Initialize the background sprite.
    backgroundNode = SKSpriteNode(imageNamed: "background")
    backgroundNode.anchorPoint = CGPoint(x: 0, y: 1)
    backgroundNode.position = CGPointMake(0, size.height)
    
    var uiOrigin = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
    var width = self.frame.size.width
    var height = self.frame.size.height
    
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
    self.addChild(placeholderSpellSprite)
    placeholderSpellSprite.doInitialAnimation()

    // Make moves son.
    wizardOne.doInitialAnimation()
    wizardTwo.doInitialAnimation()
  }
  
  override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
    if !_isTouchEnabled {
      return
    }
    
    // Go back to the root view controller.
    goToRootViewController()
  }
  
  override func update(currentTime: CFTimeInterval) {
    // One time setup stuff
    if !_hasInitializedCountdown {
      countdownTimerSprite.initializeCountdown(currentTime)
      _hasInitializedCountdown = true
    }
    
    if !_hasSetGameBeginTime {
      _gameBeginTime = currentTime + 6
      _hasSetGameBeginTime = true
    }

    // Update the countdown timer "animation"
    countdownTimerSprite.updateIntroAnimationStartupTimer(currentTime)
    
    // After this point, we're ready to actually run our game.
    if !isGameStarted( currentTime ) {
      return
    }
    
    // Handle players dying.
    for (id, player) in enumerate(players) {
      if !player.isAlive {
        doGameOver(id)
      }
    }
    
    // After this point, we're casting spells.
    // We're going to do spells and shit. And we're going to be pleased about.
    if !isTimeToCastSpells(currentTime) {
      return
    }
    
    // Grab a spell from the player using the camera.
    var humanPlayerSpell = getHumanPlayerSpell()
    
    // Generate a random spell for the AI player.
    var aiPlayerSpell = getAIPlayerSpell()
    
    if humanPlayerSpell.isFizzleAgainst(aiPlayerSpell) {
      doFizzleSpellCastAnimation(humanPlayerSpell, aiSpell: aiPlayerSpell)
    }
    else if humanPlayerSpell.isStrongAgainst(aiPlayerSpell) {
      doStrongSpellCastAnimation(humanPlayerSpell, aiSpell: aiPlayerSpell)
    }
    else if humanPlayerSpell.isWeakAgainst(aiPlayerSpell) {
      doWeakSpellCastAnimation(humanPlayerSpell, aiSpell: aiPlayerSpell)
    }
    else {
      doNeutralSpellCastAnimation(humanPlayerSpell, aiSpell: aiPlayerSpell)
    }
    
    // Set the next spell casting time.
    _nextSpellCastingTime = currentTime + 5
  }
  
  func doFizzleSpellCastAnimation( humanSpell : SpellElement, aiSpell : SpellElement ) {
    
  }
  
  func doStrongSpellCastAnimation( humanSpell : SpellElement, aiSpell : SpellElement ) {
    
  }
  
  func doWeakSpellCastAnimation( humanSpell : SpellElement, aiSpell : SpellElement ) {
    
  }
  
  func doNeutralSpellCastAnimation( humanSpell : SpellElement, aiSpell : SpellElement ) {
    
  }
  
  func goToRootViewController() {
    var viewController = self.scene?.view?.window?.rootViewController as UINavigationController
    viewController.popToRootViewControllerAnimated(true)
  }
  
  func isGameStarted( currentTime : CFTimeInterval ) -> Bool {
    return currentTime >= _gameBeginTime
  }
  
  func isTimeToCastSpells( currentTime : CFTimeInterval ) -> Bool {
    return currentTime >= _nextSpellCastingTime
  }
  
  func doGameOver( id : Int ) {
    println("Show the game over screen. We also want to enable touch screen support.")
    _isTouchEnabled = true
  }
  
  func getHumanPlayerSpell() -> SpellElement {
    // TODO: Pete, put your stuff here.
    
    
    return .Fire
  }
  
  func getAIPlayerSpell() -> SpellElement {
    var randomNumber = Int(arc4random() % 4)
    switch randomNumber {
      case 0:
       return .Fire
      case 1:
        return .Water
      case 2:
        return .Earth
      case 3:
        return .Air
      default:
        return .Fire
    }
  }
  
  var backgroundNode : SKSpriteNode!
  
  private var _gameBeginTime : CFTimeInterval!
  private var _nextSpellCastingTime : CFTimeInterval!
  
  private var _hasSetGameBeginTime : Bool = false
  
  var countdownTimerSprite : IntroCountdownSprite!
  private var _hasInitializedCountdown : Bool = false
  
  private var _isTouchEnabled = false
  
  private var players : [Player] = [Player(hitPoints: 100), Player(hitPoints: 100)]
}
