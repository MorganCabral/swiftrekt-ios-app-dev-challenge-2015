//
//  ViewController.swift
//  app-dev-challenge
//
//  Created by Morgan Cabral on 2/5/15.
//  Code by Holly Hastings
//  Copyright (c) 2015 Team SwiftRekt. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Scene stuff
    let scene = LoadingScene(size: view.bounds.size)
    let spriteView : SKView = self.view as SKView;
    spriteView.showsDrawCount = true;  spriteView.showsNodeCount = true; spriteView.showsFPS = true; spriteView.ignoresSiblingOrder = true
    scene.scaleMode = .ResizeFill
    spriteView.presentScene(scene)

  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

class LoadingScene: SKScene {
    
    // Create element sprite nodes
    let fire = SKSpriteNode(imageNamed: "RedFire")
    let water = SKSpriteNode(imageNamed: "BlueWater")
    let earth = SKSpriteNode(imageNamed: "YellowEarth")
    let air = SKSpriteNode(imageNamed: "GreenAir")
    
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.darkGrayColor()
        
        // Positions of element sprites
        //      F
        //  E   +   A
        //      W
        //
        fire.position = CGPoint(x: size.width * 0.5, y: size.height * 0.1)
        water.position = CGPoint(x: size.width * 0.5, y: size.height * 0.3)
        earth.position = CGPoint(x: size.width * 0.2, y: size.height * 0.5)
        air.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        
        //add children
        addChild(fire)
        addChild(water)
        addChild(earth)
        addChild(air)
        
    }
}

