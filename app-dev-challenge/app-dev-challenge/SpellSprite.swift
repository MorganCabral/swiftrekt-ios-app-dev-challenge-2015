//
//  SpellSprite.swift
//  app-dev-challenge
//
//  Created by Morgan Cabral on 2/7/15.
//  Copyright (c) 2015 Team SwiftRekt. All rights reserved.
//

import Foundation
import SpriteKit

/*
 * Sprite which is responsible for visualizing spell casting.
 */
public class SpellSprite : SKSpriteNode {
  
    public init(spell : SpellElement, startingPosition : CGPoint, endingPosition : CGPoint, facesRight : Bool) {
        self.startingPosition = startingPosition
        self.endingPosition = endingPosition
        self.facesRight = facesRight
        self._spell = spell
        
        var texture = SKTexture(imageNamed: _spell.spriteFileName)
        var size = CGSize(width: texture.size().width, height: texture.size().height)
        super.init(texture: texture, color: UIColor.whiteColor(), size: size)
        self.setScale(CGFloat(0.3))
        
        // Scale the sprite if we need to make it look to the left.
        if !facesRight {
            self.xScale = fabs(self.xScale) * -1
        }
        
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
        self.runAction(SKAction.moveTo(endingPosition, duration: 2.0), withKey: "spellInitializationAnimation")
            }
    }
    
    public func stopInitialAnimation() {
                self.removeActionForKey("spellInitializationAnimation")
    }
    
    
    var startingPosition : CGPoint
    var endingPosition : CGPoint
    var facesRight : Bool
    private var _spell : SpellElement
    private var _startedMovingToInitialPosition : Bool = false
}