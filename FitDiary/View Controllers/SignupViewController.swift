//
//  SignupViewController.swift
//  FitDiary
//
//  Created by Angy Higgy on 2020-06-18.
//  Copyright © 2020 Angy Higgy. All rights reserved.
//

import UIKit
import FirebaseUI
import FirebaseAuth
import FirebaseDatabase

class SignupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        firstnameField.delegate = self
        lastnameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        
        nextButtonOutlet.isEnabled = false
        nextButtonOutlet.backgroundColor = UIColor.gray
    }
    
    
    //MARK: Properties
    @IBOutlet weak var firstnameField: UITextField!
    
    @IBOutlet weak var lastnameField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var nextButtonOutlet: UIButton!
    
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    var savedEmail:String?
    
    
    //MARK: Actions
    @IBAction func nextButton(_ sender: UIButton) {
        //User will be created here
        Auth.auth().createUser(withEmail: emailField.text ?? "", password: (passwordField.text ?? "")) {(result,error) in
            if let _eror = error{
                print(_eror.localizedDescription)
                switch(_eror.localizedDescription){
                case "The email address is already in use by another account.":
                    self.errorMessageLabel.text = "A user with this email address already exists."
                default: self.errorMessageLabel.text = ""
                }
                return
            }
            else{
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                let newUser = User(context: context)
                newUser.email = self.emailField.text
                newUser.firstName = self.firstnameField.text
                newUser.lastName = self.lastnameField.text
                
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
                
                
                self.performSegue(withIdentifier:"goToUserInfo",sender: Any?.self)
                print("Successful sign up")
            }
        }
        
    }
    

    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        savedEmail = emailField.text
        let destVC = segue.destination as! UserInfoViewController
        destVC.emailKey = savedEmail
    }
    
    

}

extension SignupViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(textField==passwordField){
            nextButtonOutlet.isEnabled = true
            nextButtonOutlet.backgroundColor = UIColor.systemPink
        }
    }
}
