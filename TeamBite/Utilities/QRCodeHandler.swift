//
//  QRCodeHandler.swift
//  TeamBite
//
//  Created by Cameron Rivera on 7/22/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit
import CoreImage

struct qrCodeHandler {
    
    func generateQRCode(from str: String) -> UIImage? {
        let data = str.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
            
            if let output = filter.outputImage?.transformed(by: transform){
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
    
}
