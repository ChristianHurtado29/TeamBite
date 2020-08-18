//
//  PaddedTextField.swift
//  TeamBite
//
//  Created by Cameron Rivera on 8/14/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

class PaddedTextField: UITextField {
    
    let padding  = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
