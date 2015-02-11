//
//  LoadingScene.swift
//  app-dev-challenge
//
//  Created by Morgan Cabral on 2/7/15.
//  Copyright (c) 2015 Team SwiftRekt. All rights reserved.
//

import UIKit
import Darwin
import SpriteKit
import Foundation

class LoadingScene: SKScene {

  override func didMoveToView(view: SKView) {
    backgroundColor = SKColor.greenColor()
    
    // This is radius of the circle path.
    var r = 90.0
    
    // Calculate the midpoint and the size of our boundary.
    var circleOrigin = CGPointMake(CGRectGetMidX(view.frame), CGRectGetMidY(view.frame))
    var boundarySize = CGSize( width: (r / 2.0), height: (r / 2.0 ))
    
    // Create element sprite nodes
    //      F
    //  E   +   A
    //      W
    let spriteNodes = [
      SKSpriteNode(imageNamed: "RedFire"),
      SKSpriteNode(imageNamed: "BlueWater"),
      SKSpriteNode(imageNamed: "YellowEarth"),
      SKSpriteNode(imageNamed: "GreenAir")
    ]
    
    // Initialize each of the sprites.
    for i in 0...3 {
      var sprite = spriteNodes[i]
      
      // Set the sprite size.
      sprite.size = CGSize( width: 100.0, height: 100.0 )
      
      // Calculate the angle of the sprite's position (on the circle).
      var angle = (M_PI / 2.0) * Double(i)
      
      // Calculate the x and y coordinates of the sprite's starting on the circle.
      var yPos: Double = r * sin( angle )
      var xPos: Double = r * cos( angle )
      sprite.position = CGPoint(x: xPos, y: yPos)
    }
    
    // Create a node that contains the other sprites.
    var superSprite = SKSpriteNode();
    for sprite in spriteNodes {
      superSprite.addChild(sprite);
    }
    superSprite.position = circleOrigin;
    
    // Insert the mega sprite into the scene.
    addChild(superSprite);
    
    // Initialize a circular animation for the sprite.
    var fullRotation : CGFloat = CGFloat(2.0 * M_PI);
    var rotateAction = SKAction.rotateByAngle(fullRotation, duration: 1.5)
    var finalAction = SKAction.repeatActionForever(rotateAction)
    
    // Apply the animation to the sprite.
    superSprite.runAction(finalAction)
  }
}