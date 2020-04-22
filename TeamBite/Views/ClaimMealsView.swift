//
//  ClaimMealsView.swift
//  TeamBite
//
//  Created by Margiett Gil on 4/22/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

class ClaimMealsView: UIView {

    lazy var contentViewSize = CGSize(width: centerView.frame.width, height: centerView.frame.height + 400)
   

    
    public lazy var scrollView: UIScrollView = {
        let sv = UIScrollView(frame: .zero)
        sv.frame = self.bounds
        sv.contentSize = CGSize(width: (self.frame.width * 0.75), height: (self.frame.height * 0.658))
        sv.backgroundColor = .systemBackground
        return sv 
        
    }


}
