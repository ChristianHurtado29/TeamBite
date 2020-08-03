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
    // Protect against human error. If a patron shows up at the wrong place, be certain to make it so that the scan won't work, or show some manner of warning.
    // Protect against scanning old QRCodes.
    // Use the offer name as a seed, but also the date of the offer as well.
    // Consider looking into invalidating QR Codes. 
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
