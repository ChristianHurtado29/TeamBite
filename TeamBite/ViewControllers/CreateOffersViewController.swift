//
//  CreateOffersViewController.swift
//  TeamBite
//
//  Created by David Lin on 4/21/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit
import AVKit

class CreateOffersViewController: UIViewController {
    @IBOutlet weak var offerNameTextField: UITextField!
    @IBOutlet weak var numberOfMealsTextField: UITextField!
    @IBOutlet weak var startTimeDatePicker: UIDatePicker!
    @IBOutlet weak var endTimeDatePicker: UIDatePicker!
    @IBOutlet weak var createButton: UIButton!
    
    //Allergies switch
    @IBOutlet weak var nutFreeSwitch: UISwitch!
    @IBOutlet weak var glutenFreeSwitch: UISwitch!
    @IBOutlet weak var vegetarianSwitch: UISwitch!
    
    let currentDateTime = Date()
    
    var allergies = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSwitchSettings()
        numberOfMealsTextField.keyboardType = .numberPad
        createButton.isEnabled = true
    }
    
    
    private func initialSwitchSettings() {
        nutFreeSwitch.isOn = false
        glutenFreeSwitch.isOn = false
        vegetarianSwitch.isOn = false
    }
    
    @IBAction func nutFreeSwitchPressed(_ sender: UISwitch) {
        
    }
    
    @IBAction func glutenFreeSwitchPressed(_ sender: UISwitch) {
        
    }
    
    @IBAction func vegetarainSwitchPressed(_ sender: UISwitch) {
        
    }
    
    var audioPlayer = AVAudioPlayer()
    
        func playSound(file:String, ext:String) -> Void {
            do {
                let sound = Bundle.main.path(forResource: "FoodReady", ofType: "mp3")
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
                audioPlayer.prepareToPlay()
                audioPlayer.currentTime = 0
                audioPlayer.play()
            } catch {
                fatalError()
    }
    }
    
    
    @IBAction func createOfferButtonPressed(_ sender: UIButton) {
        print("create button clicked")
        if offerNameTextField.text?.isEmpty == true {
            showAlert(title: "name is empty", message: "")
        } else {
            
            if nutFreeSwitch.isOn == true {
                if !allergies.contains("Nut-Free"){
                    allergies.append("Nut-Free")
                }
            }
            print("allergies: \(allergies)")
            if nutFreeSwitch.isOn == false {
                if allergies.contains("Nut-Free"){
                }
            }
            if glutenFreeSwitch.isOn == true {
                if !allergies.contains("Gluten Free"){
                    allergies.append("Gluten Free")
                }
                print("allergies: \(allergies)")
            }
            if vegetarianSwitch.isOn == true {
                if !allergies.contains("Vegetarian"){
                    allergies.append("Vegetarian")
                }
                print("allergies: \(allergies)")
            }
            
            if startTimeDatePicker.date < currentDateTime || endTimeDatePicker.date < startTimeDatePicker.date {
                showAlert(title: "", message: "Please provide a valid start time")
            }
            
            let offerName = offerNameTextField.text ?? "Meals"
            let numberOfMeals = Int(numberOfMealsTextField.text ?? "0")
            let startTime = startTimeDatePicker.date
            let endTime = endTimeDatePicker.date
            let setAllergies = Set(allergies)
            let finalAllergies = Array(setAllergies)
            
            
            let newOffer = Offer(offerId: UUID().uuidString , nameOfOffer: offerName, totalMeals: numberOfMeals!, remainingMeals: numberOfMeals!, createdDate: Date(), startTime: startTime, endTime: endTime, allergyType: finalAllergies)
            
            
            DatabaseService.shared.addToOffers(offer: newOffer) { [weak self, weak sender] (result) in
                print("create button pressed")
                switch result {
                case.failure(let error):
                    DispatchQueue.main.async {
                        self?.showAlert(title: "Error creating item", message: "Sorry something went wrong: \(error.localizedDescription)")
                        sender?.isEnabled = true
                    }
                case .success:
                    sender?.isEnabled = true
                    
                }
            }
            DatabaseService.shared.createAllOffers(offer: newOffer) { [weak self, weak sender] (result) in
                print("create button pressed")
                switch result {
                case.failure(let error):
                    DispatchQueue.main.async {
                        self?.showAlert(title: "Error creating item", message: "Sorry something went wrong: \(error.localizedDescription)")
                        sender?.isEnabled = true
                    }
                case .success:
                    sender?.isEnabled = true
                    
                    
                }
                
            }
            
            playSound(file: "FoodReady", ext: "mp3")
        }
        sleep(1)
        dismiss(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    
}


extension CreateOffersViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
