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
    playerOneHealthSprite = HealthBarSprite(positionOnScene: CGPoint(x: 100.0, y: 20.0))
    playerTwoHealthSprite = HealthBarSprite(positionOnScene: CGPoint(x: size.width - 100.0, y: size.height - 40.0))
    
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
    // Is the game over? bail out.
    if( _isGameOver ) {
      return
    }

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
    
    // Add placeholder spell sprite
    var _leftSpellLocation = CGPoint(x: self.frame.width * 0.15, y: 300.0)
    var _rightSpellLocation = CGPoint(x: self.frame.width * 0.85, y: 300.0)
    
    // Update the players.
    if shouldUpdateAIPlayer(currentTime) {
      updateAIPlayer(currentTime, _spellStart: _rightSpellLocation, _spellEnd: _leftSpellLocation)
    }
    
    if shouldUpdateHumanPlayer(currentTime) {
      updateHumanPlayer(currentTime, _spellStart: _leftSpellLocation, _spellEnd: _rightSpellLocation)
    }
    
    // Handle players dying.
    for (id, player) in enumerate(players) {
      if !player.isAlive {
        doGameOver(id)
      }
    }
  }
  
  func hurtPlayerOne( hitPoints : Int ) {
    players[0].remainingHitPoints -= hitPoints
    playerOneHealthSprite.hitPoints = players[0].remainingHitPoints
  }
  
  func hurtPlayerTwo( hitPoints : Int ) {
    players[1].remainingHitPoints -= hitPoints
    playerTwoHealthSprite.hitPoints = players[1].remainingHitPoints
  }
  
  func goToRootViewController() {
    var viewController = self.scene?.view?.window?.rootViewController as UINavigationController
    viewController.popToRootViewControllerAnimated(true)
  }
  
  func isGameStarted( currentTime : CFTimeInterval ) -> Bool {
    return currentTime >= _gameBeginTime
  }
  
  func doGameOver( id : Int ) {
    var gameOverSprite = GameOverSprite(positionOnScene: CGPoint(x: 500.0, y: -2000.0))
    gameOverSprite.winningPlayerID = id
    self.addChild(gameOverSprite)
    gameOverSprite.doSlideAnimation()
    println("Show the game over screen. We also want to enable touch screen support.")
    _isTouchEnabled = true
    _isGameOver = true
  }
  
  func getAIPlayerSpell() -> SpellElement? {
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
        return nil
    }
  }
  
  func schedulePlayerCastSpell( spell : SpellElement ) {
    _hasPlayerSpell = true
    mostRecentElement = spell
  }
  
  func shouldUpdateHumanPlayer( currentTime : CFTimeInterval ) -> Bool {
    return ( currentTime >= _nextPlayerSpellCastTime ) && _hasPlayerSpell
  }
  
  func shouldUpdateAIPlayer( currentTime : CFTimeInterval ) -> Bool {
    return currentTime >= _nextAISpellCastTime
  }
  
  func updateHumanPlayer( currentTime : CFTimeInterval, _spellStart : CGPoint, _spellEnd : CGPoint ) {
    // Grab a spell from the player using the camera.
    var maybePlayerSpell = self.mostRecentElement
    var playerSpell = maybePlayerSpell == nil ? .Fire : maybePlayerSpell!
    
    var playerSpellSprite = SpellSprite(spell: playerSpell, startingPosition: _spellStart, endingPosition: _spellEnd, facesRight: true)
    playerSpellSprite.position = _spellStart
    
    var moveRight = SKAction.moveTo(_spellEnd, duration: 1.0)
    var hurtAi = SKAction.runBlock({self.hurtPlayerTwo(10)})
    var removeHumanSprite = SKAction.runBlock({playerSpellSprite.removeFromParent()})
    
    var playerActionSequence = SKAction.sequence([moveRight, hurtAi, removeHumanSprite])
    self.addChild(playerSpellSprite)
    playerSpellSprite.runAction(playerActionSequence)
    
    // Clear out the spell and add in the spell cooldown time.
    _hasPlayerSpell = false
    _nextPlayerSpellCastTime = currentTime + 0.1
  }
  
  func updateAIPlayer( currentTime : CFTimeInterval, _spellStart : CGPoint, _spellEnd : CGPoint  ) {
    // Generate a random spell for the AI player.
    var maybeAISpell = getAIPlayerSpell()
    
    var aiSpellSprite = SpellSprite(spell: maybeAISpell!, startingPosition: _spellStart, endingPosition: _spellEnd, facesRight: false)
    aiSpellSprite.position = _spellStart
    
    var moveLeft = SKAction.moveTo(_spellEnd, duration: 1.0)
    var hurtHuman = SKAction.runBlock({self.hurtPlayerOne(10)})
    var removeAiSprite = SKAction.runBlock({aiSpellSprite.removeFromParent()})
    
    var aiActionSequence = SKAction.sequence([moveLeft, hurtHuman, removeAiSprite])
    self.addChild(aiSpellSprite)
    aiSpellSprite.runAction(aiActionSequence)
    
    // Set the next spell casting time for the AI player.
    _nextAISpellCastTime = currentTime + 5
  }
  
  var backgroundNode : SKSpriteNode!
  
  private var _isGameOver = false;

  private var _gameBeginTime : CFTimeInterval!
  private var _nextAISpellCastTime : CFTimeInterval!
  private var _nextPlayerSpellCastTime : CFTimeInterval!
  
  private var _hasSetGameBeginTime : Bool = false
  
  var countdownTimerSprite : IntroCountdownSprite!
  private var _hasInitializedCountdown : Bool = false
  
  private var _isTouchEnabled = false
  
  private var players : [Player] = [Player(hitPoints: 100), Player(hitPoints: 100)]
  
  private var mostRecentElement : SpellElement?
  private var _hasPlayerSpell : Bool = false
  
  private var playerOneHealthSprite : HealthBarSprite!
  private var playerTwoHealthSprite : HealthBarSprite!
    
}
