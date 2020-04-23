//
//  ClaimMealsView.swift
//  TeamBite
//
//  Created by Margiett Gil on 4/22/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

class ClaimMealsView: UIView {

    public lazy var instructionsLabel: UILabel = {
        let layout = UILabel()
        layout.numberOfLines = 2
        layout.text = "The maximum meals a day you can pick up are 2"
        layout.font = UIFont(name: "Hiragino Mincho ProN", size: 14)
        layout.textColor = .black
        layout.textAlignment = .center
        return layout
        
    }()
    
    public lazy var questionHowMany: UILabel = {
        let layout = UILabel()
        layout.numberOfLines = 2
        layout.font = UIFont(name: "Hiragino Mincho ProN", size: 14)
        layout.text = "How many meals will you be picking up today?"
        layout.textColor = .black
        layout.textAlignment = .center
        return layout
        
    }()
    
    public lazy var oneMeal: UIButton = {
          let button = UIButton()
          button.setTitle("1", for: .normal)
          button.backgroundColor = #colorLiteral(red: 0.9442620873, green: 0, blue: 0, alpha: 1)
          button.layer.cornerRadius = 5.0
          button.setTitleColor(.white, for: .normal)
          button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.semibold)
          return button
      }()
    
    public lazy var twoMeals: UIButton = {
          let button = UIButton()
          button.setTitle("2", for: .normal)
          button.backgroundColor = #colorLiteral(red: 0.9442620873, green: 0, blue: 0, alpha: 1)
          button.layer.cornerRadius = 5.0
          button.setTitleColor(.white, for: .normal)
          button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.semibold)
          return button
      }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        
        
    }
    
    private func setupInstructionLabel() {
        addSubview(instructionsLabel)
        instructionsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            instructionsLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            instructionsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
            instructionsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant:  -8),
        ])
    }
    
    private func setupQtyLabel() {
        addSubview(questionHowMany)
        questionHowMany.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionHowMany.topAnchor.constraint(equalTo: instructionsLabel.bottomAnchor, constant: 8),
            questionHowMany.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            questionHowMany.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
    private func setupOneMealButton() {
        addSubview(oneMeal)
        oneMeal.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            oneMeal.topAnchor.constraint(equalTo: questionHowMany.bottomAnchor, constant: 10),
            oneMeal.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        
        ])
    }


}
