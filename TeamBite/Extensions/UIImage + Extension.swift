//
//  UIImage + Extension.swift
//  TeamBite
//
//  Created by Christian Hurtado on 8/14/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import Foundation
import AVKit

extension UIImage {
  static func resizeImage(originalImage: UIImage, rect: CGRect) -> UIImage {
    let rect = AVMakeRect(aspectRatio: originalImage.size, insideRect: rect)
    let size = CGSize(width: rect.width, height: rect.height)
    let renderer = UIGraphicsImageRenderer(size: size)
    return renderer.image { (context) in
      originalImage.draw(in: CGRect(origin: .zero, size: size))
    }
  }
}
