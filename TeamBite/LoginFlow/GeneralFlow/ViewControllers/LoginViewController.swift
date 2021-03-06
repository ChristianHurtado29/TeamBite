//
//  LoginViewController.swift
//  TeamBite
//
//  Created by Cameron Rivera on 4/21/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    private let loginView = LoginView()
    private let options = [NSLocalizedString("patron", comment: ""), NSLocalizedString("vendor", comment: "")]
    
    override func loadView(){
        view = loginView
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp(){
        view.backgroundColor = UIColor.systemBackground
        loginView.loginTableView.dataSource = self
        loginView.loginTableView.delegate = self
        loginView.loginTableView.register(LoginCustomCell.self, forCellReuseIdentifier: "loginCell")
        loginView.loginTableView.separatorStyle = .none
        navigationItem.title = NSLocalizedString("select", comment: "")
    }

}

extension LoginViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let xCell = tableView.dequeueReusableCell(withIdentifier: "loginCell", for: indexPath) as? LoginCustomCell else {
            fatalError("Could not deqeueue reusable LoginCustomCell.")
        }
        
        xCell.configureCell(options[indexPath.row])
        return xCell
    }
}

extension LoginViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row{
        case 0:
            let averageUserSignInVC = AverageUserSignInController()
            navigationController?.pushViewController(averageUserSignInVC, animated: true)
        case 1:
            let venueSignUpVC = VenueSignUpController()
            navigationController?.pushViewController(venueSignUpVC, animated: true)
        default:
            print("Unrecognized Choice")
        }
    }
    
}
