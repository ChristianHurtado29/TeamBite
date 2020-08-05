//
//  MainViewViewController.swift
//  TeamBite
//
//  Created by Margiett Gil on 4/22/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit
import FirebaseFirestore

enum AppState: String {
    case offerClaimed = "claimed"
    case offerUnclaimed = "unclaimed"
}


class MainViewController: UIViewController {

    private var savedVenues = [Venue]() {
        didSet {
            mainView.collectionView.reloadData()
        }
    }
    
    private let mainView = MainView()
    private var currentState: AppState
    
    init(_ state: AppState) {
        self.currentState = state
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("required init(coder: ) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
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
        DatabaseService.shared.fetchVenues() { [weak self] (result) in
            switch result {
            case.failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Unable to load Venues", message: error.localizedDescription)
                }
            case .success(let item):
                self?.savedVenues = item
                dump(item)
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
        let venue = savedVenues[indexPath.row]
        cell.configureCell(savedVenue: venue)
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
        let detailVC = UserDetailViewController(currentState)
        detailVC.delegate = self
        detailVC.selectedVenue = rest
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

extension MainViewController: UserDetailViewControllerDelegate {
    func stateChanged(_ userDetailViewController: UserDetailViewController, _ newState: AppState) {
        currentState = newState
    }
}
