//
//  TrackViewController.swift
//  FitDiary
//
//  Created by Angy Higgy on 2020-06-25.
//  Copyright © 2020 Angy Higgy. All rights reserved.
//

import UIKit

class TrackViewController: UIViewController {
    
    var currentUser:User?

    override func viewDidLoad() {
        super.viewDidLoad()
        print(currentUser!.weight)
        //updateWeight()
        //updateBMR()
        //updateFood()
        //updateActivity()
        
        NotificationCenter.default.addObserver(self, selector: #selector(TrackViewController.updateWeight), name: NSNotification.Name(rawValue: "refresh"), object: nil)
        
                NotificationCenter.default.addObserver(self, selector: #selector(TrackViewController.updateBMR), name: NSNotification.Name(rawValue: "refresh"), object: nil)
        
                 NotificationCenter.default.addObserver(self, selector: #selector(TrackViewController.updateFood), name: NSNotification.Name(rawValue: "refresh"), object: nil)
        
                 NotificationCenter.default.addObserver(self, selector: #selector(TrackViewController.updateActivity), name: NSNotification.Name(rawValue: "refresh"), object: nil)

        // Do any additional setup after loading the view.
    }
    
    
    //MARK: Properties
    
    
    @IBAction func logWeight(_ sender: Any) {
        
    }
    
    @IBOutlet weak var currWeight: UILabel!
    @IBOutlet weak var currBMR: UILabel!
    @IBOutlet weak var calsEaten: UILabel!
    @IBOutlet weak var calsLeft: UILabel!
    @IBOutlet weak var calsBurned: UILabel!
    @IBOutlet weak var activeTime: UILabel!
    
    
    
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //Store logged all logged data in arrays
    var weights: [Weight] = []
    var foods: [FoodEntry] = []
    var exercises: [ExerciseEntry] = []
    
    
    //MARK: Updating Functions
    @objc func updateWeight(){
        fetchData()
        currWeight?.text = "Current Weight: " + String(currentUser!.weight)
    }
    
    @objc func updateBMR(){
        let weight_lb = Double(weights[weights.count - 1].weight!)
        let weight_kg = Int32(weight_lb!/2.2)

        
        let newBMR = calcBMR(gender: (currentUser!.gender)!, weight_kg: (currentUser!.weight), height_cm: currentUser!.height, age: Int32(currentUser!.age))
        currBMR.text = "Resting BMR: " + String(newBMR)
    }
    
    
    @objc func updateFood(){
        fetchData()
        let weight_lb = Double(weights[weights.count - 1].weight!)
        let weight_kg = Int32(weight_lb!/2.2)
        
        let currentBMR = calcBMR(gender: "Female",weight_kg: weight_kg, height_cm: 160, age:20)
       
        let eaten = calsEaten(list: foods)
        let burned = calsBurned(list: exercises)
        let left = Int(currentBMR) - eaten + burned
        
        calsEaten?.text = "Calories Eaten: " + String(eaten)
        calsLeft?.text = "Calories Left: " + String(left)
        
    }
    
    @objc func updateActivity(){
        fetchData()
        let burned = calsBurned(list: exercises)
        let minutes = activeMins()
        
        calsBurned?.text = "Calories Burned: " + String(burned)
        activeTime?.text = "Active Minutes: " + String(minutes)
        
    }
    //MARK: Data Functions
    func fetchData(){
        do{
            weights = try context.fetch(Weight.fetchRequest())
            
            foods = try context.fetch(FoodEntry.fetchRequest())
            
            exercises = try context.fetch(ExerciseEntry.fetchRequest())
        }
        catch{
            print("Couldn't fetch data")
        }
    }
    
    //MARK: Calculation Functions
    func calcBMR(gender: String, weight_kg: Int32, height_cm: Int32, age: Int32)->Int32{
        
        var userBMR:Int32 = 0
        
        //Calculation for males
        if(gender=="Male"){
            let weightfactor = 13.7
            let heightfactor = 5
            let agefactor = 6.8
            userBMR += 66
            userBMR += Int32(weightfactor)*weight_kg
            userBMR += Int32(heightfactor)*height_cm
            userBMR -= Int32(agefactor)*age
        }
        //Calculation for female
        else if(gender=="Female"){
            let weightfactor = 9.6
            let heightfactor = 1.8
            let agefactor = 4.7
            userBMR += 655
            userBMR += Int32(weightfactor)*weight_kg
            userBMR += Int32(heightfactor)*height_cm
            userBMR -= Int32(agefactor)*age
        }
        
        return userBMR
    }
    
    func calsEaten(list: [FoodEntry])->Int{
        var sum = 0
        for entry in foods{
            sum += Int(entry.calories)
        }
        return sum
        
    }
    
    func calsBurned(list: [ExerciseEntry])->Int{
        var sum = 0
        for entry in exercises
        {
            sum += Int(entry.calories)
        }
        return sum
    }
    
    func activeMins()->Int{
        var sum = 0
        for entry in exercises{
            sum += Int(entry.activeMins)
        }
        return sum
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

