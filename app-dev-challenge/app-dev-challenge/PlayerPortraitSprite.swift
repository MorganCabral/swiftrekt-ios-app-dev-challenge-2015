//
//  PlayerPortraitSprite.swift
//  app-dev-challenge
//
//  Created by Morgan Cabral on 2/7/15.
//  Copyright (c) 2015 Team SwiftRekt. All rights reserved.
//
import UIKit
import AVFoundation
import Foundation

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

/*
 * Sprite which is responsible for displaying the local player's 
 * image along with some kind of metronome-esque thing for when
 * to cast a spell.
 */
public class PlayerPortraitSprite {

    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var capturedImage: UIImageView!
    @IBOutlet weak var takePhotoButton: UIButton!
    
    var captureSession: AVCaptureSession?
    var stillImageOutput: AVCaptureStillImageOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    

    func viewWillAppear(animated: Bool) {
        
        captureSession = AVCaptureSession()
        captureSession!.sessionPreset = AVCaptureSessionPresetPhoto
        
        var backCamera = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        var error: NSError?
        var input = AVCaptureDeviceInput(device: backCamera, error: &error)
        
        if error == nil && captureSession!.canAddInput(input) {
            captureSession!.addInput(input)
            
            stillImageOutput = AVCaptureStillImageOutput()
            stillImageOutput!.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
            if captureSession!.canAddOutput(stillImageOutput) {
                captureSession!.addOutput(stillImageOutput)
                
                previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                previewLayer!.videoGravity = AVLayerVideoGravityResizeAspect
                previewLayer!.connection?.videoOrientation = AVCaptureVideoOrientation.Portrait
                previewView.layer.addSublayer(previewLayer)
                
                captureSession!.startRunning()
            }
        }
        
    }
    
    func viewDidAppear(animated: Bool) {
        previewLayer!.frame = previewView.bounds
    }

    @IBAction func didPressTakePhoto(sender: AnyObject) {
        
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
                        self.capturedImage.image = image
                    }
                    else if( Float(blueval) < avg && (Float(greenval)+Float(redval)>=(avg*2)) )
                    {//yellow
                        self.capturedImage.image = image
                    }
                    else if( Float(blueval) >= avg && (Float(greenval)+Float(redval)<(avg*2)))
                    {//blue
                        self.capturedImage.image = image
                    }
                    else if( Float(greenval) >= avg && (Float(redval)+Float(blueval)<(avg*2)))
                    {//green
                        self.capturedImage.image = image
                    }
                    
                }
            })
        }
    }
    
    @IBAction func didPressTakeAnother(sender: AnyObject) {
        captureSession!.startRunning()
    }
}