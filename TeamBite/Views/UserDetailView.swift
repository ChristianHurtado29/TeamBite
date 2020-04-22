//
//  UserDetailView.swift
//  TeamBite
//
//  Created by Margiett Gil on 4/21/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

class UserDetailView: UIView {

    public lazy var restaurantPhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo.fill")
        imageView.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
   public lazy var restaurantInfo: UILabel = {
         let layout = UILabel()
         layout.numberOfLines = 2
         layout.font = UIFont(name: "Hiragino Mincho ProN", size: 15)
         layout.textColor = .black
         layout.textAlignment = .left
         return layout
         
     }()
     
     public lazy var hoursOFOperation: UILabel = {
         let layout = UILabel()
         layout.numberOfLines = 2
         layout.font = UIFont(name: "Hiragino Mincho ProN", size: 15)
         layout.textColor = .black
         layout.textAlignment = .left
         return layout
     }()
     
     public lazy var numberOfMeals: UILabel = {
         let layout = UILabel()
         layout.numberOfLines = 2
         layout.font = UIFont(name: "Hiragino Mincho ProN", size: 15)
         layout.textColor = .black
         layout.textAlignment = .left
         return layout
     }()
    
    public lazy var claimButton: UIButton = {
        let button = UIButton()
       // button.title("Claim Meal") // find out if this is correct
       // button.currentTitle = "Claim Meal"
        button.setTitle("Claim Meal", for: .normal)
        button.tintColor = #colorLiteral(red: 0.9442620873, green: 0, blue: 0, alpha: 1)
        return button
    }()
    
    public lazy var venueMap: MKMapView = {
           let map = MKMapView()
           return map
       }()
    
    
     

}
