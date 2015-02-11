//
//  GameViewController.swift
//  app-dev-challenge
//
//  Created by Morgan Cabral on 2/6/15.
//  Copyright (c) 2015 Team SwiftRekt. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

extension UIImage {
  
  func getPixelColor(pos: CGPoint)-> UIColor {
    var pixelData = CGDataProviderCopyData(CGImageGetDataProvider(self.CGImage))
    var data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
    
    var pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4
    
    var r = CGFloat(data[pixelInfo])/255
    var g = CGFloat(data[pixelInfo+1])/255
    var b = CGFloat(data[pixelInfo+2])/255
    var a = CGFloat(data[pixelInfo+3])/255
    
    return UIColor(red: r, green: g, blue: b, alpha: a)
  }
}

extension SKNode {
  class func unarchiveFromFile(file : NSString) -> SKNode? {
    if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
      var sceneData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!
      var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
      
      archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
      let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as GameScene
      archiver.finishDecoding()
      return scene
    } else {
      return nil
    }
  }
}

class GameViewController: UIViewController {
  
  @IBOutlet weak var previewView: UIView!
  
  var captureSession: AVCaptureSession?
  var stillImageOutput: AVCaptureStillImageOutput?
  var previewLayer: AVCaptureVideoPreviewLayer?
  
  var scene : GameScene!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    scene = GameScene(size: view.bounds.size)
    let skView = view as SKView
    skView.showsFPS = true
    skView.showsNodeCount = true
    skView.ignoresSiblingOrder = true
    scene.scaleMode = .AspectFill
    skView.presentScene(scene)
  }
  
  override func viewWillAppear(animated: Bool) {
    
    captureSession = AVCaptureSession()
    captureSession!.sessionPreset = AVCaptureSessionPresetPhoto
    
//    var backCamera = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
    var frontCamera = getFrontFacingCamera()
    
    var error: NSError?
    var input = AVCaptureDeviceInput(device: frontCamera, error: &error)
    
    if error == nil && captureSession!.canAddInput(input) {
      captureSession!.addInput(input)
      
      stillImageOutput = AVCaptureStillImageOutput()
      stillImageOutput!.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
      if captureSession!.canAddOutput(stillImageOutput) {
        captureSession!.addOutput(stillImageOutput)
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer!.videoGravity = AVLayerVideoGravityResizeAspect
        
        if UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeRight {
          previewLayer!.connection?.videoOrientation = AVCaptureVideoOrientation.LandscapeLeft
        }
        
        if UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeLeft {
          previewLayer!.connection?.videoOrientation = AVCaptureVideoOrientation.LandscapeRight
        }

        previewView.layer.addSublayer(previewLayer)
        
        captureSession!.startRunning()
      }
    }
  }
  
  func getFrontFacingCamera() -> AVCaptureDevice? {
    var devices = AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo)
    for device in devices {
      if device.position == AVCaptureDevicePosition.Front {
        return device as? AVCaptureDevice
      }
    }
    return nil
  }
  
  override func viewDidAppear(animated: Bool) {
    previewLayer!.frame = previewView.bounds
  }
  
  override func prefersStatusBarHidden() -> Bool {
    return true
  }
  
  override func shouldAutorotate() -> Bool {
    return true
  }
  
  override func supportedInterfaceOrientations() -> Int {
    if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
      return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
    } else {
      return Int(UIInterfaceOrientationMask.All.rawValue)
    }
  }
  
  @IBAction func didTakePhoto(sender: UITapGestureRecognizer) {
    if let videoConnection = stillImageOutput!.connectionWithMediaType(AVMediaTypeVideo) {
      videoConnection.videoOrientation = AVCaptureVideoOrientation.Portrait
      stillImageOutput?.captureStillImageAsynchronouslyFromConnection(videoConnection, completionHandler: {(sampleBuffer, error) in
        if (sampleBuffer != nil) {
          var imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
          var dataProvider = CGDataProviderCreateWithCFData(imageData)
          var cgImageRef = CGImageCreateWithJPEGDataProvider(dataProvider, nil, true, kCGRenderingIntentDefault)
          
          var image = UIImage(CGImage: cgImageRef, scale: 1.0, orientation: UIImageOrientation.Right)
          let rowCount = image!.size.width;
          let columnCount = image!.size.height;
          let center = CGPoint(x: columnCount/2, y: rowCount/2)
          
          let imageColor = image!.getPixelColor(center)
          
          
          // Dump RGBA values
          var redval: CGFloat = 0
          var greenval: CGFloat = 0
          var blueval: CGFloat = 0
          var alphaval: CGFloat = 0
          imageColor.getRed(&redval, green: &greenval, blue: &blueval, alpha: &alphaval)
          let total = redval + greenval + blueval
          let avg = Float(total/3);
          
          if( Float(redval) >= avg
            && (Float(greenval)+Float(blueval)<(avg*2)
              && Float(greenval)<(avg)))
          {//red
            self.scene.mostRecentElement = .Fire
          }
          else if( Float(greenval) >= avg
            && (Float(redval) < avg)
            && (Float(blueval) < avg)
            )
          {//green
            self.scene.mostRecentElement = .Air
          }
          else if( Float(blueval) >= avg && (Float(greenval)+Float(redval)<(avg*2)))
          {//blue
            self.scene.mostRecentElement = .Water
          }
          else if( Float(blueval) < avg
            && ((Float(greenval) > avg) && ( Float(redval) > avg) )
            )
          {//yellow
            self.scene.mostRecentElement = .Earth
            }
        }
      })
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Release any cached data, images, etc that aren't in use.
  }
}
