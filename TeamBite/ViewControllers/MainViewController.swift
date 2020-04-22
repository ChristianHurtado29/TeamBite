//
//  MainViewViewController.swift
//  TeamBite
//
//  Created by Margiett Gil on 4/22/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

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

    }
    


}
