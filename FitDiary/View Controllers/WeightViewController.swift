//
//  WeightViewController.swift
//  
//
//  Created by Angy Higgy on 2020-06-25.
//

import UIKit

class WeightViewController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh"), object:nil, userInfo: nil)
    }
    
    //MARK: Properties
    
    @IBOutlet weak var weightField: UITextField!
    
    @IBAction func saveWeight(_ sender: UIButton) {
        guard let weightEntry = weightField?.text else{
            return
        }
        
        if weightEntry.isEmpty || weightField?.text == ""{
            //Create alert here
            return
        }
        
        else{
      let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let newEntry = Weight(context: context)
            
            newEntry.weight = weightEntry
            
            print("Weight: " + weightEntry)
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
            dismiss(animated: true, completion: {
                let underVC = TrackViewController()
                underVC.updateWeight()
            })
            
            
            
            
            
            
            
        }
        
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
