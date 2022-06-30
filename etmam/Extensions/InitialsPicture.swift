//
//  InitialsPicture.swift
//  calenderSwift
//
//  Created by Danya T on 19/11/1443 AH.
//

import Foundation
import SwiftUI

//class InitialsImageFactory: NSObject {
 func imageWith(name: String?) -> UIImage? {
     
     
     var picColor: UIColor = UIColor(named: "orange") ?? .gray
     if let nam = name{
         let n = nam.first?.uppercased()
         if n == "N" || n == "K" || n == "T" || n == "F" || n == "D" || n == "S" {
             picColor = UIColor(named: "pink") ?? .gray}
         
     if n == "A" || n == "C" || n == "J" || n == "M" || n == "V" || n == "L" {
             picColor = UIColor(named: "green") ?? .gray
         }
     
     }
     
     
let frame = CGRect(x: 0, y: 0, width: 47, height: 47)
let nameLabel = UILabel(frame: frame)
nameLabel.textAlignment = .center
   
//nameLabel.backgroundColor = .random()
nameLabel.backgroundColor = picColor
nameLabel.textColor = .white
nameLabel.font = UIFont.boldSystemFont(ofSize: 22)
var initials = ""

if let initialsArray = name?.components(separatedBy: " ") {
  
  if let firstWord = initialsArray.first {
      if let firstLetter = firstWord.first {
      initials += String(firstLetter).capitalized
    }
    
  }
  if initialsArray.count > 1, let lastWord = initialsArray.last {
      if let lastLetter = lastWord.first {
      initials += String(lastLetter).capitalized
    }
    
  }
} else {
  return nil
}

nameLabel.text = initials
UIGraphicsBeginImageContext(frame.size)
     if let currentContext = UIGraphicsGetCurrentContext() {
    nameLabel.layer.render(in: currentContext)
         var nameImage = UIGraphicsGetImageFromCurrentImageContext()
         nameImage = nameImage?.withRoundedCorners(radius: 100)
  return nameImage
}

    
     if initials.first == "N"{
         picColor = .brown
     }else{
         picColor = .green
     }
return nil
     
}
//}


extension UIColor {
  static func random () -> UIColor {
    return UIColor(
        red: CGFloat.random(in: 0...1),
      green: CGFloat.random(in: 0...1),
      blue: CGFloat.random(in: 0...1),
      alpha: 1.0)
  }
}


extension UIColor {
    class func getRandomColor() -> UIColor {
                      //pink,orange,green,purple
        let colors = [UIColor(red: 1.00, green: 0.23, blue: 0.47, alpha: 1.00),UIColor(red: 1.00, green: 0.63, blue: 0.07, alpha: 1.00), UIColor(red: 0.07, green: 0.76, blue: 0.33, alpha: 1.00),UIColor(red: 0.75, green: 0.47, blue: 0.86, alpha: 1.00)]
        let randomNumber = arc4random_uniform(UInt32(colors.count))
        
        return colors[Int(randomNumber)]
    }
    
}


extension UIImage {
        // image with rounded corners
        public func withRoundedCorners(radius: CGFloat? = nil) -> UIImage? {
            let maxRadius = min(size.width, size.height) / 2
            let cornerRadius: CGFloat
            if let radius = radius, radius > 0 && radius <= maxRadius {
                cornerRadius = radius
            } else {
                cornerRadius = maxRadius
            }
            UIGraphicsBeginImageContextWithOptions(size, false, scale)
            let rect = CGRect(origin: .zero, size: size)
            UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
            draw(in: rect)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        }
    }
