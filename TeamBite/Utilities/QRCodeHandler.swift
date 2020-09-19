//
//  QRCodeHandler.swift
//  TeamBite
//
//  Created by Cameron Rivera on 7/22/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit
import CoreImage

struct QRCodeHandler {
    
    static func generateQRCode(from str: String) -> UIImage? {
        let data = str.data(using: String.Encoding.ascii, allowLossyConversion: true)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
            
            if let output = filter.outputImage?.transformed(by: transform){
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
    
    static func parseQRCode(_ str: String) -> (message: String, offerId: String, userId: String){
        guard !str.isEmpty else { return ("","","") }
        
        var strArr = str.components(separatedBy: " ")
        let userId = strArr.removeLast()
        let offerId = strArr.removeLast()
        let outputStr = strArr.joined(separator: " ")
        
        return (outputStr, offerId, userId)
    }
    
}
