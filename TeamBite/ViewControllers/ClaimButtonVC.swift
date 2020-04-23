//
//  claimButtonVC.swift
//  TeamBite
//
//  Created by Margiett Gil on 4/22/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

class ClaimButtonVC: UIViewController {
    
    private let claimButton = ClaimMealsView()
    
    override func loadView() {
        view = claimButton
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .systemBackground
        view.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1) // testing
        navigationItem.title = "Claim Your Meal"

        
    }
    
    @objc private func oneMeal(_ sender: UIButton) {
        print("Selected one meal")
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let continueAction = UIAlertAction(title: "Claim My Meal", style: .default)
        }
    
    @objc private func twoMeal(_ sender: UIButton) {
        print("Selected Two Meals")
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        }
    }

        }
        
