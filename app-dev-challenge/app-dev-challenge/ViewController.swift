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
  
  override func prefersStatusBarHidden() -> Bool {
    return false;
  }
  
  override func shouldAutorotate() -> Bool {
    return false;
  }
}

