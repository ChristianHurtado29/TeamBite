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
    private let reasonsForFlagging: [String] = ["Was not able to receive meal", "Meal was cold", "other"]
    
    private var pickerView = UIPickerView()
    
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
        flagView.tapGesture.addTarget(self, action: #selector(screenTapped))
    }
    
    @objc
    private func screenTapped() {
        flagView.reasonForFlagTextField.resignFirstResponder()
    }
    
    @objc
    private func submitButtonPressed(_ sender: UIButton) {
        print("Submitted")
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
        
    }
    
    @objc
    public func keyboardWillDismiss() {
        
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
            flagView.reasonForFlagTextView.alpha = 1.0
            flagView.expandOnReasonLabel.alpha = 1.0
            flagView.submitButton.alpha = 0.0
        } else {
            flagView.reasonForFlagTextView.alpha = 0.0
            flagView.expandOnReasonLabel.alpha = 0.0
            flagView.submitButton.alpha = 1.0
        }
    }
    
}
