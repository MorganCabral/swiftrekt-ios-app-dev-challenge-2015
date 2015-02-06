// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

// Create and add a colored square
let coloredSquare1 = UIView()
let coloredSquare2 = UIView()
let coloredSquare3 = UIView()
let coloredSquare4 = UIView()

// set background color to blue
coloredSquare1.backgroundColor = UIColor.blueColor()
coloredSquare2.backgroundColor = UIColor.yellowColor()
coloredSquare3.backgroundColor = UIColor.redColor()
coloredSquare4.backgroundColor = UIColor.greenColor()

// set frame (position and size) of the square
// iOS coordinate system starts at the top left of the screen
// so this square will be at top left of screen, 50x50pt
// CG in CGRect stands for Core Graphics
coloredSquare1.frame = CGRect(x: 0, y: 120, width: 50, height: 50)
coloredSquare2.frame = CGRect(x: 52, y: 120, width: 50, height: 50)
coloredSquare3.frame = CGRect(x: 0, y: 68, width: 50, height: 50)
coloredSquare4.frame = CGRect(x: 52, y: 68, width: 50, height: 50)


let frame = CGRect(x: 0, y: 0, width: 200, height: 200)
let view = UIView(frame: frame)
view.backgroundColor = UIColor.whiteColor()

let smallFrame = frame.rectByInsetting(dx: 25, dy: 25)
let smallView = UIView(frame: smallFrame)
smallView.backgroundColor = UIColor.brownColor()

view.addSubview(smallView)

let bigCat = UIImage(named: "rit")
let catFrame = frame.rectByInsetting(dx: 50, dy: 50)
let catView = UIImageView(image: bigCat)
catView.contentMode = .ScaleAspectFill
catView.frame = catFrame

view.addSubview(catView)

@objc class Wub {
}

var datType = Wub.self
println("\(datType)");