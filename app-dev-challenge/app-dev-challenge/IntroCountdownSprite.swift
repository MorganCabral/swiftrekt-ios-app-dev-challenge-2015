//
//  IntroCountdownSprite.swift
//  app-dev-challenge
//
//  Created by Morgan Cabral on 2/8/15.
//  Copyright (c) 2015 Team SwiftRekt. All rights reserved.
//

import Foundation
import SpriteKit

public class IntroCountdownSprite : SKLabelNode {
  
  public override init() {
    self._countdownFinishedTime = 0
    
    super.init()
    self.fontName = "Palatino"
    self.text = "5"
    self.fontColor = UIColor.blackColor()
    self.fontSize = 144
  }

  required public init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  public func initializeCountdown ( currentTime : CFTimeInterval ) {
    _countdownFinishedTime = currentTime + 5
  }
  
  func updateIntroAnimationStartupTimer( currentTime : CFTimeInterval ) {
    var remainingTime = Int(_countdownFinishedTime - currentTime)
    if remainingTime <= 0 {
      self.text = "GO!"
      var waitAction = SKAction.waitForDuration(NSTimeInterval(1.0))
      var slideOutAnimation = SKAction.moveToY(3000.0, duration: 1.0)
      self.runAction(SKAction.sequence([waitAction, slideOutAnimation]))
    }
    else {
      self.text = "\(remainingTime)"
    }
  }
  
  private var _countdownFinishedTime : CFTimeInterval
}