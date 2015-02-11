//
//  ViewController.swift
//  app-dev-challenge
//
//  Created by Morgan Cabral on 2/5/15.
//  Code by Holly Hastings
//  Tina is here too!
//  Copyright (c) 2015 Team SwiftRekt. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {
  @IBOutlet var startButton: UIButton!
  @IBOutlet weak var rotateSpriteView: SKView!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    //startButton.backgroundColor = UIColor.clearColor()
    startButton.layer.cornerRadius = 10
    startButton.layer.borderWidth = 1
    
    // Set up the rotate spritekit view.
    let scene = LoadingScene(size: rotateSpriteView.bounds.size)
    scene.scaleMode = .ResizeFill
    
    rotateSpriteView.ignoresSiblingOrder = true
    rotateSpriteView.presentScene(scene)

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
    //here we should be able to activate the camera after hte button is pressed. Try to change the completion to something
    @IBAction func startAction(sender: UIButton) {
        let gameController = self.storyboard?.instantiateViewControllerWithIdentifier("gameController") as GameViewController
        self.navigationController?.pushViewController(gameController, animated: false)
    }
}

