//
//  MainViewViewController.swift
//  TeamBite
//
//  Created by Margiett Gil on 4/22/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

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
    private let userId: String
    
    init(_ state: AppState) {
        self.currentState = state
        userId = Auth.auth().currentUser?.uid ?? "sdknaZ8oYlPI4w4XEQGOwUgIsXw2"
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
        configureUI()
        fetchVenues()
        fetchAppState(userId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DatabaseService.shared.checkForClaimReset(userId) { [weak self] (result) in
            switch result {
            case .failure(let error):
                self?.showAlert(title: "Error", message: "Could not access claim time. Error: \(error.localizedDescription)")
            case .success(let succeeded):
                if succeeded {
                    self?.fetchAppState(self?.userId ?? "")
                }
            }
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
        mainView.collectionView.register(MainViewCell.self, forCellWithReuseIdentifier: "mainViewCell")
        
        navigationItem.title = "BITE"
    }
    
    private func fetchVenues() {
        DatabaseService.shared.fetchVenues() { [weak self] (result) in
            switch result {
            case.failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Unable to load Venues", message: error.localizedDescription)
                }
            case .success(let item):
                self?.savedVenues = item.filter { $0.vetted }
            }
        }
    }
    
    private func fetchAppState(_ uid: String) {
        DatabaseService.shared.fetchUserStatus(uid) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.showAlert(title: "Error", message: "Error fetching user status: \(error.localizedDescription)")
            case .success(let status):
                
                if let state = AppState(rawValue: status) {
                    self?.currentState = state
                    if state == AppState.offerUnclaimed {
                        UserDefaultsHandler.resetOfferName()
                    }
                }
            }
        }
    }
}

//MARK: UICollection Delegate Extension
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
        let detailVC = UserDetailViewController(currentState, rest)
        detailVC.delegate = self
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
