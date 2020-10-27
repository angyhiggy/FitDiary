//
//  UserInfoViewController.swift
//  FitDiary
//
//  Created by Angy Higgy on 2020-06-19.
//  Copyright © 2020 Angy Higgy. All rights reserved.
//

import UIKit

class UserInfoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
        
    var userIndex = 0
    var weightUnits = ["lbs","kg"]
    var activityLevels = ["Sedentary", "Lightly Active", "Moderately Active", "Very Active","Extra Active"]
    var genders = ["Male","Female"]
    var ages = [Int]()
    
    func populateAges(){
        var age = 18
        for _ in 0...81{
            ages.append(age)
            age = age + 1
        }
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == weightUnitPicker{
           return weightUnits.count
        }
        else if pickerView == activityLevelPicker{
            return activityLevels.count
        }
        else if pickerView == genderPicker{return genders.count}
        else if pickerView == agePicker{return ages.count}
            
        else {return 0}
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == weightUnitPicker{return weightUnits[row]}
        else if pickerView == activityLevelPicker{return activityLevels[row]}
        else if pickerView == genderPicker{return genders[row]}
        else if pickerView == agePicker{return String(ages[row])}
            
        else {return ""}
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createButtonOutlet.isEnabled = false
        createButtonOutlet.backgroundColor = UIColor.gray
        
        populateAges()
        agePicker.delegate = self
        agePicker.dataSource = self
        
        weightUnitPicker.delegate = self
        weightUnitPicker.dataSource = self
        weightField.delegate = self
        
        activityLevelPicker.delegate = self
        activityLevelPicker.dataSource = self
        
        genderPicker.delegate = self
        
        genderPicker.dataSource = self
        
        
        
    }
    
    
    
    
    //MARK: Properties
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var users:[User] = []
    
    var emailKey:String?
    
    @IBOutlet weak var agePicker: UIPickerView!
    
    @IBOutlet weak var viewTitle: UILabel!
    
    
    @IBOutlet weak var activityLevelPicker: UIPickerView!
    
    @IBOutlet weak var heightField: UITextField!
    
    @IBOutlet weak var weightField: UITextField!
    
    
    @IBOutlet weak var weightUnitPicker: UIPickerView!
    
    @IBOutlet weak var genderPicker: UIPickerView!
    
    @IBOutlet weak var createButtonOutlet: UIButton!
    
    
    func fetchData(){
        do{
            users = try context.fetch(User.fetchRequest())
            
        }
        catch{
            print("Couldn't fetch data")
        }
    }
    
    //MARK: Actions

    @IBAction func createDiary(_ sender: Any) {
 

        performSegue(withIdentifier: "createDiary", sender: self)
        
    }
    
    
    
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        fetchData()
         
         //Find user with email entered in sign up
         for user in users{
             if (user.email == emailKey){
                 let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                 let foundUser = User(context: context)
                 foundUser.firstName = user.firstName
                 foundUser.lastName = user.lastName
                 foundUser.email = user.email
                
                let height = heightField.text
                let heightNum = Int32(height!)
                
                let weight = weightField.text!
                foundUser.height = heightNum!
                foundUser.weight = Int32(weight)!
                 
                 let genRow = genderPicker.selectedRow(inComponent: 0)
                 foundUser.gender = genders[genRow]
                 
                 let ageRow = agePicker.selectedRow(inComponent: 0)
                 foundUser.age = Int16(ages[ageRow])
                 
                 let actRow = activityLevelPicker.selectedRow(inComponent: 0)
                 foundUser.activityLevel = activityLevels[actRow]
                 
                 (UIApplication.shared.delegate as! AppDelegate).saveContext()
                fetchData()
                
                print(users[userIndex - 1].weight)
                 
                 break
             }
             userIndex += 1
         }
         
         
        
        let destVC = segue.destination as! HomeViewController
        destVC.currentUser = users[userIndex]
    }


}

extension UserInfoViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {

            createButtonOutlet.isEnabled = true
            createButtonOutlet.backgroundColor = UIColor.systemPink

    }
}
