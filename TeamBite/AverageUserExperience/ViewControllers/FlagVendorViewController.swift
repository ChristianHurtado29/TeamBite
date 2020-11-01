//
//  FlagVendorViewController.swift
//  TeamBite
//
//  Created by Cameron Rivera on 10/4/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

class FlagVendorViewController: UIViewController {

    private let flagView = FlagVendorView()
    private var currentVenue: Venue
    private let reasonsForFlagging: [String] = ["Was not able to receive meal", "Meal was cold", "Other"]
    private var keyboardIsHidden = true
    
    private var pickerView = UIPickerView()
    private var datePicker = UIDatePicker() // Set up a way to add date and time without using a date picker because they are ugly.
    
    override func loadView() {
        view = flagView
    }
    
    init(_ venue: Venue) {
        self.currentVenue = venue
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("required init(_:) was not implemented.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePickerView()
        configureUI()
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unregisterForKeyboardNotifications()
    }
    
    private func configurePickerView() {
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    private func configureUI() {
        navigationItem.title = "Flag Vendor"
        flagView.submitButton.addTarget(self, action: #selector(submitButtonPressed(_:)), for: .touchUpInside)
        flagView.venueNameTextField.text = currentVenue.name
        flagView.reasonForFlagTextField.inputView = pickerView
        flagView.timeOfFlagTextField.inputView = datePicker
        flagView.tapGesture.addTarget(self, action: #selector(screenTapped))
    }
    
    @objc
    private func screenTapped() {
        flagView.reasonForFlagTextField.resignFirstResponder()
        flagView.reasonForFlagTextView.resignFirstResponder()
        flagView.timeOfFlagTextField.resignFirstResponder()
    }
    
    @objc
    private func submitButtonPressed(_ sender: UIButton) {
        // Check that a valid reason for flagging exists.
        guard let reasonText = flagView.reasonForFlagTextField.text, !reasonText.isEmpty else {
            showAlert(title: "Invalid Flag", message: "Please select a reason for flagging this restaurant.")
            return
        }
        
        // Check that if other is selected as a reason, there is an explanation associated with that reason.
        if reasonText == reasonsForFlagging[reasonsForFlagging.count - 1] && flagView.reasonForFlagTextView.text.isEmpty {
            showAlert(title: "Invalid Flag", message: "Please write an explanation into the textbox below.")
            return
        }
        
        // Check that a valid date and time are given.

    }

}

extension FlagVendorViewController {
    
    public func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDismiss), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    public func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    public func keyboardWillShow() {
        if keyboardIsHidden && flagView.reasonForFlagTextView.isFirstResponder {
            flagView.shiftUp(UIScreen.main.bounds.height * 0.25)
            keyboardIsHidden = false
        } else if !keyboardIsHidden && !flagView.reasonForFlagTextView.isFirstResponder {
            keyboardWillDismiss()
        }
    }
    
    @objc
    public func keyboardWillDismiss() {
        if !keyboardIsHidden {
            flagView.shiftBack()
            keyboardIsHidden = true
        }
    }
    
}

extension FlagVendorViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return reasonsForFlagging.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return reasonsForFlagging[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        flagView.reasonForFlagTextField.text = reasonsForFlagging[row]
        
        if row == reasonsForFlagging.count - 1{
            flagView.showTextView(1.0)
        } else {
            flagView.hideTextView(1.0)
        }
    }
    
}
