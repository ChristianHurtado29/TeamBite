//
//  MainViewViewController.swift
//  TeamBite
//
//  Created by Margiett Gil on 4/22/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit
import FirebaseFirestore



class MainViewController: UIViewController {
    
    private let db = DatabaseService()
    
    private var savedVenues = [Venue]() {
        didSet {
            mainView.collectionView.reloadData()
        }
    }
    
    private let mainView = MainView()
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
        mainView.collectionView.register(MainViewCell.self, forCellWithReuseIdentifier: "mainViewCell")
        navigationItem.title = "BITE"
        fetchVenues()
    }
    
    

    private func fetchVenues() {
        db.fetchVenues() { [weak self] (result) in
            switch result {
            case.failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Unable to load Venues", message: error.localizedDescription)
                }
            case .success(let item):
                self?.savedVenues = item
            }
        }
    }
    


}

//MARK: UICollection Delegate Extension
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("main vc # of venues:\(savedVenues.count)")
        return savedVenues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainViewCell", for: indexPath) as? MainViewCell else {
            fatalError("Could not downcast to MainViewCell")
        }
        let savedActivities = savedVenues[indexPath.row]
      //  cell.configureCell(for: savedVenues)
        return cell
    }
}

//MARK: UICollectionView Delegate Extenstion
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize = UIScreen.main.bounds
        let width = maxSize.width * 0.45
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let rest = savedVenues[indexPath.row]
        let detailVC = UserDetailViewController()
        
        detailVC.selectedVenue = rest
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
