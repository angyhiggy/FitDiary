//
//  AddFoodViewController.swift
//  FitDiary
//
//  Created by Angy Higgy on 2020-06-29.
//  Copyright © 2020 Angy Higgy. All rights reserved.
//

import UIKit

class AddFoodViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh"), object:nil, userInfo: nil)
    }
    
    //MARK: Properties
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var calsField: UITextField!
    
    @IBAction func saveFood(_ sender: UIButton) {
        guard let nameEntry = nameField.text else{
            return
        }
            guard let calsEntry = calsField.text else{
                return
            }
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let newEntry = FoodEntry(context: context)
        
        newEntry.foodName = nameEntry
        newEntry.calories = Int32(calsEntry)!
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        dismiss(animated: true, completion: {
            let underVC = TrackViewController()
            underVC.updateFood()
        })
    }
        
        
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
