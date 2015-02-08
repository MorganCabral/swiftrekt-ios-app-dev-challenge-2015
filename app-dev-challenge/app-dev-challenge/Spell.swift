//
//  Spell.swift
//  app-dev-challenge
//
//  Created by Morgan Cabral on 2/7/15.
//  Copyright (c) 2015 Team SwiftRekt. All rights reserved.
//

import UIKit

/**
 * Enumeration which represents a specific type of spell.
 */
public enum SpellElement {
  /**
   * The fire element.
   */
  case Fire
  
  /**
   * The water element.
   */
  case Water
  
  /**
   * The earth element.
   */
  case Earth
  
  /**
   * The air element.
   */
  case Air
}

public extension SpellElement {

  /**
   * Get the color associated with the element.
   */
  public var color : UIColor {
    get {
      switch self {
        case .Fire:
          return UIColor.redColor()
        case .Water:
          return UIColor.blueColor()
        case .Earth:
          return UIColor.yellowColor()
        case .Air:
          return UIColor.greenColor()
      }
    }
  }
    
  public var spriteFileName : String {
    get {
      switch self {
        case .Fire:
          return "fire_spell_sprite"
        case .Water:
          return "water_spell_sprite"
        case .Earth:
          return "earth_spell_sprite"
        case .Air:
          return "air_spell_sprite"
      }
    }
  }

  /**
   * Get the element that this element is weak against.
   * Being weak against an element means that you will
   * do no damage against the other person, but they will
   * do damage to you.
   */
  public var weakness : SpellElement {
    get {
      switch self {
        case .Fire:
          return .Air
        case .Water:
          return .Fire
        case .Earth:
          return .Water
        case .Air:
          return .Earth
      }
    }
  }
  
  /**
   * Get the element that this element is strong against.
   * Being strong against an element means that you will
   * do damage against the other person, but they will do no
   * damage to you.
   */
  public var strength : SpellElement {
    get {
      switch self {
        case .Fire:
          return .Water
        case .Water:
          return .Earth
        case .Earth:
          return .Air
        case .Air:
          return .Fire
      }
    }
  }
  
  /**
   * Get the element that this element is neutral against.
   * Being neutral against an element means that that you will
   * do damage against the other person and they will do damage
   * against you as well.
   */
  public var neutral : SpellElement {
    get {
      switch self {
      case .Fire:
        return .Earth
      case .Water:
        return .Air
      case .Earth:
        return .Fire
      case .Air:
        return .Water
      }
    }
  }
  
  /**
   * Determine if this spell will fizzle against the specified spell.
   * 
   * :param: other The other spell element.
   * :returns: True if the spell will fizzle against the specified spell.
   */
  public func isFizzleAgainst( other : SpellElement ) -> Bool {
    return self == other
  }
  
  /**
   * Determine if this spell is weak against the specified spell.
   * 
   * :param: other The other spell element.
   * :returns: True if this spell is weak against the specified spell.
   */
  public func isWeakAgainst( other : SpellElement ) -> Bool {
    return self.weakness == other
  }
  
  /**
   * Determine if this spell is strong against the specified spell.
   *
   * :param: other The other spell element.
   * :returns: True if this spell is strong against the specified spell.
   */
  public func isStrongAgainst( other : SpellElement ) -> Bool {
    return self.strength == other
  }
  
  /**
   * Determine if this neutral against the specified spell.
   * 
   * :param: other The other spell element.
   * :returns: True if this neutral against the specified spell.
   */
  public func isNeutralAgainst( other : SpellElement ) -> Bool {
    return self.neutral == other
  }
}
