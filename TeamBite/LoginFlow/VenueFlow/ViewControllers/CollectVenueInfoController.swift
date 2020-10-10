//
//  CollectRestaurantInfoController.swift
//  TeamBite
//
//  Created by Cameron Rivera on 4/21/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit
import FirebaseAuth

class CollectVenueInfoController: UIViewController {
    
    private let collectVenueInfoView = CollectVenueInfoView()
    private let userEmail: String
    private let userPassword: String
    private let coreLocation = CoreLocationManager()
    private var yAnchorConstant: CGFloat = 0
    private var keyboardIsVisible = false
    private let pickupInstructions = ["Call store", "Walk-in", "Side entrance"]
    
    public lazy var instructionPicker: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
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
        collectVenueInfoView.tapGesture.addTarget(self, action: #selector(dismissKeyboard))
        registerForKeyboardNotifications()
        collectVenueInfoView.instructionTextfield.inputView = instructionPicker
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unregisterForKeyboardNotifications()
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
        collectVenueInfoView.instructionTextfield.delegate = self
        collectVenueInfoView.submitButton.addTarget(self, action: #selector(submitButtonPressed), for: .touchUpInside)
        instructionPicker.dataSource = self
        instructionPicker.delegate = self
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
        let pickup = collectVenueInfoView.instructionTextfield.text
        
        if let userPhone = collectVenueInfoView.venuePhoneTextField.text, !userPhone.isEmpty {
            phoneNumber = userPhone
        }
        
        let combinedAddress = combineAddress(streetName, city, state, zip)
        
        coreLocation.convertPlacenameIntoCoordinates(combinedAddress) { [weak self] result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async{
                    self?.showAlert(title: "Placename Error", message: "Could not convert a placename into coordinate: \(error.localizedDescription)")
                }
            case.success(let coordinate):
                let newVenue = Venue(name: venueName, venueId: "", long: coordinate.longitude, lat: coordinate.latitude, phoneNumber: phoneNumber, address: combinedAddress, pickupInstructions: pickup, venueImage: "", vetted: false)
                self?.createNewVenue(newVenue)
            }
        }
    }
    
    private func createNewVenue(_ venue: Venue){
        FirebaseAuthManager.shared.createNewAccountWithEmail(userEmail, userPassword) { [weak self] result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async{
                    self?.showAlert(title: "Account Creation Error", message: error.localizedDescription)
                }
            case .success(let authData):
                DatabaseService.shared.createVenue(venue: venue, authDataResult: authData) { [weak self] result in
                    switch result {
                    case .failure(let error):
                        DispatchQueue.main.async{
                            self?.showAlert(title: "Venue Creation Error", message: "Could not create venue: \(error)")
                        }
                    case .success:
                        UIViewController.showTabController(storyboardName: "Venues", viewControllerId: "VenueStoryboard", viewController: nil)
                    }
                }
            }
        }
    }
    
    private func combineAddress(_ streetName: String, _ city: String, _ state: String, _ zip: String) -> String {
        return streetName + " " + city + " " + state + " " + zip
    }
    
    private func areYouANumber(_ string: String) -> Bool {
        
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
    
    @objc
    private func dismissKeyboard(_ gesture: UITapGestureRecognizer) {
        
        collectVenueInfoView.zipTextField.resignFirstResponder()
        collectVenueInfoView.cityTextField.resignFirstResponder()
        collectVenueInfoView.stateTextField.resignFirstResponder()
        collectVenueInfoView.streetNameTextField.resignFirstResponder()
        collectVenueInfoView.venueNameTextField.resignFirstResponder()
        collectVenueInfoView.venuePhoneTextField.resignFirstResponder()
        collectVenueInfoView.startTimeTextField.resignFirstResponder()
        collectVenueInfoView.endTimeTextField.resignFirstResponder()
        collectVenueInfoView.instructionTextfield.resignFirstResponder()
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

extension CollectVenueInfoController {
    
    private func registerForKeyboardNotifications(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func unregisterForKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    private func keyboardWillShow(_ notification: NSNotification){
        
        guard let _ = notification.userInfo?["UIKeyboardFrameBeginUserInfoKey"] as? CGRect else {
            return
        }
        
        shiftUIUp(80)
    }
    
    @objc
    private func keyboardWillHide(_ notification: NSNotification){
        resetUI()
    }
    
    private func shiftUIUp(_ offset: CGFloat){
        
        if keyboardIsVisible { return }
        yAnchorConstant = collectVenueInfoView.yAnchor.constant
        
        collectVenueInfoView.yAnchor.constant -= offset
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
        
        keyboardIsVisible = true
    }
    
    private func resetUI(){
        keyboardIsVisible = false
        
        collectVenueInfoView.yAnchor.constant = yAnchorConstant
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
}

extension CollectVenueInfoController: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickupInstructions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickupInstructions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        collectVenueInfoView.instructionTextfield.text = pickupInstructions[row]
    }
    
}
