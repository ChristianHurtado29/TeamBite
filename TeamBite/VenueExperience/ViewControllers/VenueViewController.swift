//
//  VenueViewController.swift
//  TeamBite
//
//  Created by David Lin on 4/21/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import Kingfisher

class VenueViewController: UIViewController {
    private let db = Firestore.firestore()
    private var listener: ListenerRegistration?
    
    private var editState = 0
    private var venue: Venue?
    private var arrayOffers = [Offer]() {
        didSet {
            DispatchQueue.main.async {
                self.offersTableView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var venueImage: UIImageView!
    @IBOutlet weak var venueAddressLabel: UILabel!
    @IBOutlet weak var venueContactLabel: UILabel!
    @IBOutlet weak var offersTableView: UITableView!
    @IBOutlet weak var fakeNavBar: UINavigationBar!
    
    private lazy var imagePickerController: UIImagePickerController = {
        let ip = UIImagePickerController()
        ip.delegate = self
        return ip
    }()
    
    private var selectedImage: UIImage? {
        didSet {
            venueImage.image = selectedImage
            
            guard let user = Auth.auth().currentUser else { return }
            let resizedImage = UIImage.resizeImage(originalImage: self.selectedImage!, rect: self.venueImage.bounds)
            self.storageService.uploadPhoto(userId: user.uid, image: resizedImage) { [weak self] (result) in
                switch result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.showAlert(title: "Error uploading photo", message: "\(error.localizedDescription)")
                    }
                case .success(let url):
                    let request = Auth.auth().currentUser?.createProfileChangeRequest()
                    request?.photoURL = url
                    request?.commitChanges(completion: { [unowned self] (error) in
                        if let error = error {
                            DispatchQueue.main.async {
                                self?.showAlert(title: "Error updating profile", message: "Error changing profile: \(error.localizedDescription).")
                            }
                        } else {
                            DispatchQueue.main.async {
                                self?.showAlert(title: "Profile Update", message: "Profile successfully updated 🥳.")
                            }
                        }
                    })
                }
            }
        }
    }
    
    private let storageService = StorageService()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchOffers()
        venueData()
        setUp()
        offersTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        listener = db.collection(DatabaseService.venuesOwnerCollection).document(Auth.auth().currentUser?.uid ?? "").collection(DatabaseService.offersCollection).addSnapshotListener({ [weak self] (snapshot, error) in
            if let error = error {
                print("\(error)")
            } else if let snapshot = snapshot {
                let ss = snapshot.documents.compactMap{Offer($0.data())}
                self?.arrayOffers = ss
            }
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        listener?.remove()
    }
    
    private func setUp() {
        guard let user = Auth.auth().currentUser else { return }
        venueImage.kf.setImage(with: user.photoURL)
//        var userPhoto = user.photoURL?.absoluteString
        if venueImage.image == UIImage(named: ""){
            venueImage.image = UIImage(systemName: "person")
        }
        venueImage.layer.cornerRadius = 30
        offersTableView.delegate = self
        offersTableView.dataSource = self
        navigationItem.leftBarButtonItem?.target = self
        navigationItem.leftBarButtonItem?.action = #selector(scanQRCodeButtonPressed(_:))
    }
    
    private func fetchOffers(){
        guard let user = Auth.auth().currentUser else { return }
        DatabaseService.shared.fetchVenueOffers(user.uid) { [weak self] (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Failed to get offers", message: "oops! \(error)")
                }
            case .success(let offers):
                DispatchQueue.main.async {
                    self?.arrayOffers = offers
                    print(offers)
                }
            }
        }
    }
    
    private func venueData() {
        DatabaseService.shared.fetchVenue() { [weak self] (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Failed to get offers", message: "oops! \(error)")
                }
            case .success(let venue):
                DispatchQueue.main.async {
                    self?.venue = venue
                    self?.venueAddressLabel.text = venue.address
                    self?.venueContactLabel.text = venue.phoneNumber
                    self?.navigationItem.title = venue.name
                }
            }
        }
    }
    
    private func updateDatabaseUser(address: String, phoneNumber: String) {
        
        DatabaseService.shared.updateVenue(address: address, phoneNumber: phoneNumber) { (result) in
            switch result {
            case .failure(let error):
                print("failed to update db user: \(error.localizedDescription)")
            case .success:
                print("successfully updated db user")
            }
        }
    }
    
    private func deleteOffer(offer: Offer){
        DatabaseService.shared.deleteOffer(offer: offer) { (result) in
            switch result {
            case .failure(let error):
                print("failed to delete offer: \(error.localizedDescription)")
            case .success(true):
                self.showAlert(title: "Offer deleted", message: nil)
            case .success(false):
                print("why is this an option?")
            }
        }
    }
    
    @IBAction func addImageButton(_ sender: UIButton) {
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
    
    
    @IBAction func scanQRCodeButtonPressed(_ sender: UIBarButtonItem) {
        let scanQRVC = ScanQRCodeController()
        present(scanQRVC, animated: true, completion: nil)
    }
    
    
    @IBAction func createOfferButtonPressed(_ sender: UIBarButtonItem) {
        let storyboard =  UIStoryboard(name: "Venues", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "CreateOffersViewController") as? CreateOffersViewController else { fatalError()}
        self.present(vc, animated: true, completion: nil)
    }
}


extension VenueViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension VenueViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOffers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell  = tableView.dequeueReusableCell(withIdentifier: "offersCell", for: indexPath) as? OffersCell else {
            fatalError( "could not downcast to OfferCell")
        }
        let offer =  arrayOffers[indexPath.row]
        cell.delegate = self
        cell.configureCell(for: offer)
        return cell
    }
}

extension VenueViewController: OffersCellSelDelegate{
    func cellSelected(_ cell: OffersCell) {
        showAct(for: cell)
        print("selected!!!!")
    }
    
    
    private func showAct(for cell: OffersCell) {
        guard let indexPath = offersTableView.indexPath(for: cell) else {
            return
        }
        let alertAct = UIAlertController(title: "Action Sheet", message: "What would you like to do?", preferredStyle: .actionSheet)
        let delete = UIAlertAction(title: "Delete", style: .destructive) { [weak self] (action) in
            self?.deleteOffer(offer: self!.arrayOffers[indexPath.row])
            self?.venueData()
            self?.offersTableView.reloadData()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { [weak self] (action) in
            self?.dismiss(animated: true)
        }
        alertAct.addAction(delete)
        alertAct.addAction(cancel)
        present(alertAct, animated: true)
    }
}

extension VenueViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        selectedImage = image
        dismiss(animated: true)
    }
}

