//
//  CollectRestaurantInfoController.swift
//  TeamBite
//
//  Created by Cameron Rivera on 4/21/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit
import FirebaseAuth

// TODO: SetUp KEYBOARD HANDLING

class CollectVenueInfoController: UIViewController {

    private let collectVenueInfoView = CollectVenueInfoView()
    private let userEmail: String
    private let userPassword: String
    
    init(_ email: String, _ password: String){
        self.userEmail = email
        self.userPassword = password
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(_: coder) has not be implemented.")
    }
    
    override func loadView(){
        view = collectVenueInfoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp(){
        collectVenueInfoView.backgroundColor = UIColor.systemBackground
        collectVenueInfoView.zipTextField.delegate = self
        collectVenueInfoView.cityTextField.delegate = self
        collectVenueInfoView.stateTextField.delegate = self
        collectVenueInfoView.streetNameTextField.delegate = self
        collectVenueInfoView.venueNameTextField.delegate = self
        collectVenueInfoView.venuePhoneTextField.delegate = self
        collectVenueInfoView.startTimeTextField.delegate = self
        collectVenueInfoView.endTimeTextField.delegate = self
        collectVenueInfoView.submitButton.addTarget(self, action: #selector(submitButtonPressed), for: .touchUpInside)
        navigationItem.title = "Venue Information"
    }
    
    @objc
    private func submitButtonPressed(_ sender: UIButton){
        guard let zip = collectVenueInfoView.zipTextField.text, !zip.isEmpty,
            let city = collectVenueInfoView.cityTextField.text,
            !city.isEmpty,
            let state = collectVenueInfoView.stateTextField.text,
            !state.isEmpty,
            let streetName = collectVenueInfoView.streetNameTextField.text,
            !streetName.isEmpty,
            let venueName = collectVenueInfoView.venueNameTextField.text,
            !venueName.isEmpty else {
                showAlert(title: "Missing Fields", message: "One or more required fields are missing. Please complete all required fields.")
                return
        }
        
        var phoneNumber: String? = nil
        var startTime: String? = nil
        var endTime: String? =  nil
        
        if let userPhone = collectVenueInfoView.venuePhoneTextField.text, !userPhone.isEmpty {
            phoneNumber = userPhone
        }
        
        if let begin = collectVenueInfoView.startTimeTextField.text, !begin.isEmpty {
            switch collectVenueInfoView.startTimeSegmentedControl.selectedSegmentIndex {
            case 0:
                startTime = begin + " A.M."
            default:
                startTime = begin + " P.M."
            }
        }
        
        if let end = collectVenueInfoView.startTimeTextField.text, !end.isEmpty {
            switch collectVenueInfoView.endTimeSegmentedControl.selectedSegmentIndex {
            case 0:
                endTime = end + " A.M."
            default:
                endTime = end + " P.M."
            }
        }
        // TODO: Add reverse Geolocation to get lat and long
        let newVenue = Venue(name: venueName, venueId: "", long: 0, lat: 0, phoneNumber: phoneNumber, address: combineAddress(streetName, city, state, zip), startTime: startTime, endTime: endTime)
        createNewVenue(newVenue)
    }
    
    private func createNewVenue(_ venue: Venue){
        FirebaseAuthManager.shared.createNewAccountWithEmail(userEmail, userPassword) { [weak self] result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async{
                    self?.showAlert(title: "Account Creation Error", message: error.localizedDescription)
                }
            case .success:
                let storyboarder = UIStoryboard(name: "Venues", bundle: nil)
                guard let venueVC = storyboarder.instantiateViewController(identifier: "VenueStoryboard") as? UITabBarController else {
                    fatalError("Could not create instance of TabBarController.")
                }
                UIViewController.resetWindow(venueVC)
                break
            }
        }
    }
    
    private func combineAddress(_ streetName: String, _ city: String, _ state: String, _ zip: String) -> String {
        return streetName + " " + city + " " + state + " " + zip
    }
    
    private func areYouANumber(_ string: String) -> Bool{
        
        for char in string{
            if !char.isNumber {
                return false
            }
        }
        return true
    }
    
    private func areYouTimeCompliant(_ string: String) -> Bool {
        
        for char in string {
            if !char.isNumber && char != ":"{
                return false
            }
        }
        
        return true
    }

}

extension CollectVenueInfoController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let fullText = textField.text ?? "" + string
        let char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        if textField == collectVenueInfoView.zipTextField && areYouANumber(string) && fullText.count > 4 && isBackSpace != -92{
            return false
        } else if textField == collectVenueInfoView.stateTextField && fullText.count > 1 && isBackSpace != -92 {
            return false
        } else if textField == collectVenueInfoView.startTimeTextField && !areYouTimeCompliant(string) && isBackSpace != -92 {
            return false
        } else if textField == collectVenueInfoView.endTimeTextField && !areYouTimeCompliant(string) && isBackSpace != -92 {
            return false
        }
        
        return true
    }
}
