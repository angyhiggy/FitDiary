//
//  ViewController.swift
//  FitDiary
//
//  Created by Angy Higgy on 2020-06-18.
//  Copyright © 2020 Angy Higgy. All rights reserved.
//

import UIKit
import FirebaseUI
import FirebaseAuth
import FirebaseDatabase

class ViewController: UIViewController {
    
    //MARK: Private Methods
    private func updateLoginButton(){
        let emailTextField = usernameField.text ?? ""
        let passwordTextField = passwordField.text ?? ""
        if(emailTextField.isEmpty || passwordTextField.isEmpty){
            loginButtonOutlet.backgroundColor = UIColor(red: 127, green: 140, blue: 114, alpha: 1)
        }
    }
    
    var email = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        usernameField.delegate = self
        passwordField.delegate = self
        loginButtonOutlet.isEnabled = false
        loginButtonOutlet.backgroundColor = UIColor.gray
    }
    
    @IBOutlet weak var usernameField: UITextField!
    
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var emailErrorLabel: UILabel!
    
    @IBOutlet weak var loginButtonOutlet: UIButton!
    
    
    @IBAction func loginButton(_ sender: UIButton) {
        //THE BELOW CODE IS FOR SIGNING UP - MOVE ACCORDINGLY

        //THE BELOW CODE IS FOR LOGGING IN (EXISTING USER)
        Auth.auth().signIn(withEmail: usernameField.text ?? "", password: passwordField.text ?? "") {(result,error) in
        if let _eror = error{
            print(_eror.localizedDescription)
            switch(_eror.localizedDescription){
            case "There is no user record corresponding to this identifier. The user may have been deleted.":
                self.emailErrorLabel.text = "Invalid email or password."
            case "The password is invalid or the user does not have a password.":
                self.emailErrorLabel.text = "Invalid email or password."
            case "The email address is badly formatted.":
            self.emailErrorLabel.text = "Please enter a valid email address."
            default: self.emailErrorLabel.text = ""
                
            }
            
            return
        }else{
            print("Successful login")
            self.performSegue(withIdentifier:"logIn", sender: Any?.self)
        }
        }
    }
    
    @IBAction func signupButton(_ sender: UIButton) {
        
    }
    
    

}

extension ViewController: FUIAuthDelegate{
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        print("handle user signup / login")
    }
}

extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(textField == passwordField){
            loginButtonOutlet.isEnabled = true
            loginButtonOutlet.backgroundColor = UIColor.systemPink
        }
    }
}

