//
//  WizardSprite.swift
//  app-dev-challenge
//
//  Created by Morgan Cabral on 2/8/15.
//  Copyright (c) 2015 Team SwiftRekt. All rights reserved.
//

import Foundation
import SpriteKit

public class WizardSprite : SKSpriteNode {
  /**
   * Constructor.
   */
  public init( startingPosition : CGPoint, endingPosition : CGPoint, facesRight : Bool ) {
    self.startingPosition = startingPosition
    self.endingPosition = endingPosition
    self.facesRight = facesRight
    
    var texture = SKTexture(imageNamed: "wizard")
    var size = CGSize(width: texture.size().width, height: texture.size().height)
    super.init(texture: texture, color: UIColor.whiteColor(), size: size)
    
    // Set the position of the sprite to the specified starting position.
    self.position = startingPosition
  }

  required public init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }

  public func doInitialAnimation() {
    // If we aren't already moving, indicate that we're moving now.
    if( !_startedMovingToInitialPosition ) {
      _startedMovingToInitialPosition = true
      
      // Start the movement animation.
      self.runAction(SKAction.moveTo(endingPosition, duration: 2.0), withKey: "wizardInitializationAnimation")
    }
  }
  
  public func stopInitialAnimation() {
    self.removeActionForKey("wizardInitializationAnimation")
  }
  
  var startingPosition : CGPoint
  var endingPosition : CGPoint
  var facesRight : Bool
  private var _startedMovingToInitialPosition : Bool = false
}