//
//  LoginViewController.swift
//  MyVK
//
//  Created by itisioslab on 07.11.17.
//  Copyright © 2017 itisioslab. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var emailUser = ""
    var passwordUser = ""
    var userManager: UserManager!
    let currentUserKey = "currentUserKey"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userManager = UserManager()
    }

    @IBAction func pressedButtonComeIn(_ sender: Any) {
        guard checkInputData() == true else { return }
        
        if let user = userManager.checkUser(email: emailUser, password: passwordUser) {
            UserManager.currentUser = user
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let pageNVC = storyboard.instantiateViewController(withIdentifier: "mainNVC") as! UINavigationController
            guard let pageVC = pageNVC.viewControllers.first as? NewViewController else { return }
            let userWithRegistration = UserWithRegistration(from: user)
            pageVC.currentUser = userWithRegistration
            UserDefaults.standard.set(userWithRegistration.id, forKey: currentUserKey)
            present(pageNVC, animated: true, completion: nil)
        }
    }
    
    func checkInputData() -> Bool {
        var check = true
        
        if let email = emailTextField.text, email.contains("@") {
            emailUser = email
            emailTextField.setClearBorder()
        } else {
            check = false
            emailTextField.setRedBorder()
        }
        
        if let password = passwordTextField.text, !password.isEmpty {
            passwordUser = password
            passwordTextField.setClearBorder()
        } else {
            check = false
            passwordTextField.setRedBorder()
        }
        return check
    }
    
}
