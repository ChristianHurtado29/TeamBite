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
    // Protect against human error. If a patron shows up at the wrong place, be certain to make it so that the scan won't work, or show some manner of warning.
    // Protect against scanning old QRCodes.
    // Use the offer name as a seed, but also the date of the offer as well.
    // Consider looking into invalidating QR Codes.
    
    //NOTE: The function on line 20 would make it so that nil was returned when you attempt to convert a string variable into data if allowLossyConversion was set to false. Not certain why this is, only that it happens. 
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
