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
    
    // Create the background sprite.
    var width = size.width * 2.0
    var height = size.height * 2.0
    backgroundNode.size = CGSize(width: width, height: height)
    backgroundNode.position = CGPoint(x: 0.0, y: 0.0)
    
    // Create player sprites.
    // TODO: Actually do this.

    // Create the player camera view.
    // TODO: This is a placeholder until we can integrate Pete's logic for
    // webcam stuff in.
    var portraitWidth = CGFloat(150.0)
    portraitNode = SKSpriteNode(imageNamed: "peter.jpg")
    
    // Make the portrait image a square.
    // TODO: Fix the aspect ratio.
    var padding = CGFloat(20.0)
    portraitNode.size = CGSize(width: portraitWidth, height: portraitWidth)
    portraitNode.position = CGPoint(x: size.width - portraitWidth/2 - padding , y: portraitWidth/2 + padding)
    backgroundNode.addChild(portraitNode)
    
    // Create health bar sprites.
    
    // Add the composed set of game sprites to the scene.
    // Make sure this is the absolutely last thing that happens.
    self.addChild(backgroundNode)
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
  var portraitNode : SKSpriteNode!
  var playerOneNode : SKSpriteNode!
  var playerTwoNode : SKSpriteNode!
  var p1HealthBar : SKShapeNode!
  var p2HealthBar : SKShapeNode!
}
