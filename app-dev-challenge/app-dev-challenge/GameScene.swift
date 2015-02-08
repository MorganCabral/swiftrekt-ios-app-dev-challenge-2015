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
    backgroundNode = SKSpriteNode(imageNamed: "background")
    backgroundNode.anchorPoint = CGPoint(x: 0, y: 1)
    backgroundNode.position = CGPointMake(0, size.height)
    
    // Create the background sprite.
    var width = size.width * 2.0
    var height = size.height * 2.0
    
    // Initialize sprites for the wizards.
    var leftWizardStart = CGPoint(x: -300.0, y: 300.0)
    var leftWizardEnd = CGPoint(x: width * 0.15, y: 300.0)
    
    var playerOneWizard = WizardSprite(startingPosition: leftWizardStart, endingPosition: leftWizardEnd, facesRight: true);
//    var playerTwoWizard = WizardSprite(rightWizardStart, rightWizardEnd, false);
    
    // Initalize Health Sprites
    var playerOneHealthSprite = HealthBarSprite(positionOnScene: CGPoint(x: 100.0, y: 20.0))
    var playerTwoHealthSprite = HealthBarSprite(positionOnScene: CGPoint(x: size.width - 100.0, y: size.height - 40.0))
    
    // Add the composed set of game sprites to the scene.
    // Make sure this is the absolutely last thing that happens.
    self.addChild(backgroundNode)
    
    // Add the wizards.
    self.addChild(playerOneWizard)
    
    // Add the HP Player One Label
    self.addChild(playerOneHealthSprite)
    self.addChild(playerTwoHealthSprite)
    
    // Start up the initialization animation.
    playerOneWizard.doInitialAnimation();
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
    /* Called before each frame is rendered */
  }
  
  var backgroundNode : SKSpriteNode!
}
