//
//  CreateOffersViewController.swift
//  TeamBite
//
//  Created by David Lin on 4/21/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit
import AVKit
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

class CreateOffersViewController: UIViewController {
    @IBOutlet weak var offerNameTextField: UITextField!
    @IBOutlet weak var numberOfMealsTextField: UITextField!
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var endTimeTextField: UITextField!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var offerImage: UIImageView!
    
    //Allergies switch
    @IBOutlet weak var nutFreeSwitch: UISwitch!
    @IBOutlet weak var glutenFreeSwitch: UISwitch!
    @IBOutlet weak var vegetarianSwitch: UISwitch!
    
    private let storageService = StorageService()
    private let dbService = DatabaseService()
    
    private lazy var imagePickerController: UIImagePickerController = {
        let ip = UIImagePickerController()
        ip.delegate = self
        return ip
    }()
    
    var imgURL = ""
    
    private var selectedImage: UIImage? {
        didSet{
            offerImage.image = selectedImage
            let resizedImage = UIImage.resizeImage(originalImage: self.selectedImage!, rect: self.offerImage.bounds)
            storageService.uploadPhoto(image: resizedImage) { [weak self](result) in
                switch result{
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.showAlert(title: "error uploading photo", message: "error: \(error.localizedDescription)")
                    }
                case .success(let url):
                    self!.imgURL = url.absoluteString
                    print(url.absoluteString)
                }
            }
        }
    }
    
    let currentDateTime = Date()
    let startPicker = UIDatePicker()

    let endPicker = UIDatePicker()
    var allergies = [String]()
    
    override func viewWillLayoutSubviews() {
        createButton.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        createButton.layer.cornerRadius = 5.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSwitchSettings()
        numberOfMealsTextField.keyboardType = .numberPad
        createButton.isEnabled = true
        configureTextPickers()
        offerImage.layer.cornerRadius = 30
    }
    
    private func initialSwitchSettings() {
        nutFreeSwitch.isOn = false
        glutenFreeSwitch.isOn = false
        vegetarianSwitch.isOn = false
    }
    
    private func configureTextPickers(){
        startTimeTextField.inputView = startPicker
        endTimeTextField.inputView = endPicker
        startPicker.addTarget(self, action: #selector(startPickValueChange), for: UIControl.Event.valueChanged)
        endPicker.addTarget(self, action: #selector(endPickValueChange), for: UIControl.Event.valueChanged)
    }
    
    @objc
    private func startPickValueChange(sender: UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.long
        formatter.timeStyle = DateFormatter.Style.short
        startTimeTextField.text = formatter.string(from: sender.date)
    }
    
    @objc
    private func endPickValueChange(sender: UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.long
        formatter.timeStyle = DateFormatter.Style.short
        endTimeTextField.text = formatter.string(from: sender.date)
    }
    
    @IBAction func updatePhotoPressed(_ sender: UIButton) {
             let alertController = UIAlertController(title: "Choose Photo Option", message: nil, preferredStyle: .actionSheet)
             let cameraAction = UIAlertAction(title: "Camera", style: .default) { alertAction in
               self.imagePickerController.sourceType = .camera
               self.present(self.imagePickerController, animated: true)
             }
             let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { alertAction in
               self.imagePickerController.sourceType = .photoLibrary
               self.present(self.imagePickerController, animated: true)
             }
             let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
             if UIImagePickerController.isSourceTypeAvailable(.camera) {
               alertController.addAction(cameraAction)
             }
             alertController.addAction(photoLibraryAction)
             alertController.addAction(cancelAction)
             present(alertController, animated: true)
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
            
            if startPicker.date < currentDateTime || endPicker.date < startPicker.date {
                showAlert(title: "", message: "Please provide a valid start time")
            }
            
            let offerName = offerNameTextField.text ?? "Meals"
            let numberOfMeals = Int(numberOfMealsTextField.text ?? "0")
            let startTime = startPicker.date
            let endTime = endPicker.date
            let setAllergies = Set(allergies)
            let finalAllergies = Array(setAllergies)
            let urlImage = imgURL
            let newOffer = Offer(offerId: UUID().uuidString , nameOfOffer: offerName, totalMeals: numberOfMeals ?? 0, remainingMeals: numberOfMeals ?? 0, createdDate: Date(), startTime: Timestamp(date: startTime), endTime: Timestamp(date: endTime), allergyType: finalAllergies, status: "unclaimed", offerImage: urlImage, expectedIds: [])
            
            
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

extension CreateOffersViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        selectedImage = image
        dismiss(animated: true)
    }
}
