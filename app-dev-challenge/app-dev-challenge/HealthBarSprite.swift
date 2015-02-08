//
//  HealthBarSprite.swift
//  app-dev-challenge
//
//  Created by Morgan Cabral on 2/7/15.
//  Copyright (c) 2015 Team SwiftRekt. All rights reserved.
//

import UIKit
import SpriteKit

/*
 * Sprite which is responsible for displaying a healthbar.
 */
public class HealthBarSprite : SKLabelNode {
    
    public override init() {
        self._hitPoints = 100
        super.init();
    }
    
    public init( positionOnScene : CGPoint) {
        self._hitPoints = initialHP
        super.init(fontNamed: "Palatino")
        
        self.text = self.hitPointsLabel
        self.fontColor = UIColor.blackColor()
        self.fontSize = 30
        self.position = positionOnScene
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var hitPoints : Int {
        get { return _hitPoints }
        set ( newValue ) {
            if( newValue < 0 ) {
                _hitPoints = 0
            }
            else if ( newValue > 100 ) {
                _hitPoints = 100
            }
            else {
                _hitPoints = newValue
                self.text = self.hitPointsLabel
            }
        }
    }
    private var _hitPoints : Int
    
    public var hitPointsLabel : String {
        get { return "Health: \(hitPoints)" }
    }
    
    let initialHP : Int = 100
}