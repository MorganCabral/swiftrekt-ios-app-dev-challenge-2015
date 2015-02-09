//
//  GameOverSprite.swift
//  app-dev-challenge
//
//  Created by Tina on 2/8/15.
//  Copyright (c) 2015 Team SwiftRekt. All rights reserved.
//

import Foundation
import SpriteKit

public class GameOverSprite: SKLabelNode{
    
    public override init(){
        super.init()
    }
    
    public init( positionOnScene : CGPoint) {
        super.init(fontNamed: "Palatino")
        self.text = ""
        self.fontColor = UIColor.blackColor()
        self.fontSize = 30
        self.position = positionOnScene
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public var winningPlayerID : Int {
        get { return winningPlayerID }
        set ( playerID ) {
            if( playerID == 0 ) {
                self.text = "Player One Wins!"
            }
            else if ( playerID == 1) {
                self.text = "Player Two Wins!"
            }
            else {

            }
        }
    }
    
    public func doSlideAnimation(){
        var waitAction = SKAction.waitForDuration(NSTimeInterval(1.0))
        var slideInAnimation = SKAction.moveToY(500.0, duration: 1.0)
        self.runAction(SKAction.sequence([waitAction, slideInAnimation]))
    }
    
    
}