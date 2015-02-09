//
//  Player.swift
//  app-dev-challenge
//
//  Created by Morgan Cabral on 2/7/15.
//  Copyright (c) 2015 Team SwiftRekt. All rights reserved.
//

import UIKit

/**
 * Model class which contains state which is specific to a player.
 */
public class Player : NSObject {
  /**
   * The total number of remaining hit points on the player.
   */
  public dynamic var remainingHitPoints : Int {
    get { return _hitPoints }
    set ( newHitPoints ) {
      // If our hit points hit or fall below zero, we're dead.
      if newHitPoints <= 0 {
        self.isAlive = false;
      }
      
      // Update the hit points.
      _hitPoints = newHitPoints
      
      // Update the health percentage.
      self.healthPercentage = Double(_hitPoints) / Double(maxHitPoints)
    }
  }
  private var _hitPoints : Int
  
  /**
   * The maximum number of health points that the player can have.
   */
  public let maxHitPoints : Int
  
  /**
   * Observable property which indicates the percentage of the
   * players health which remains.
   */
  public dynamic var healthPercentage : Double {
    get { return _healthPercentage }
    set ( newPercentage ) {
      _healthPercentage = newPercentage;
    }
  }
  private var _healthPercentage : Double
  
  /**
  * KVO property which which is used to keep track of whether or
  * not the player is still alive.
  * If this changes it's a pretty good indication that a player
  * just died.
  */
  public dynamic var isAlive : Bool = true
  
  /**
   * Optional value which contains the player's image, or a default.
   */
//  public var playerImage : UIImage?
  
  /**
   * Constructor.
   *
   * :param: hitPoints The player's starting health.
   * :param: playerImage The image to associate with the player
   */
  public init( hitPoints : Int ) {
    self.maxHitPoints = hitPoints
    self._hitPoints = hitPoints
    self._healthPercentage = 1.0
//    self.playerImage = playerImage
  }
}

