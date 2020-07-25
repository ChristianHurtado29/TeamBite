//
//  PatronOfferCell.swift
//  TeamBite
//
//  Created by Cameron Rivera on 7/24/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

class PatronOfferCell: UITableViewCell {

    private lazy var offerTitleLabel: UILabel = {
       let label = UILabel()
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
    }
    
}
