//
//  takePictureController.swift
//  app-dev-challenge
//
//  Created by Tina on 2/8/15.
//  Copyright (c) 2015 Team SwiftRekt. All rights reserved.
//

import UIKit
import SpriteKit

class takePictureController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Scene stuff
        //    let scene = LoadingScene(size: view.bounds.size)
        //    let spriteView : SKView = self.view as SKView;
        //    spriteView.showsDrawCount = true;  spriteView.showsNodeCount = true; spriteView.showsFPS = true; spriteView.ignoresSiblingOrder = true
        //    scene.scaleMode = .ResizeFill
        //    spriteView.presentScene(scene)
        
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
    @IBAction func goBack(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
 
}

