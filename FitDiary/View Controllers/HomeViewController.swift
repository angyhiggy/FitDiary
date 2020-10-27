//
//  HomeViewController.swift
//  FitDiary
//
//  Created by Angy Higgy on 2020-06-19.
//  Copyright © 2020 Angy Higgy. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var currentUser:User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(currentUser?.weight!)
        welcomeMessage.text = "Welcome, " + (currentUser?.firstName)!

        // Do any additional setup after loading the view.
    }
    
    //MARK: Properties
    
    @IBOutlet weak var welcomeMessage: UILabel!
    
    @IBAction func tapTrack(_ sender: Any) {
        performSegue(withIdentifier: "goToTrack", sender: self)
    }
    @IBAction func tapWorkout(_ sender: Any) {
        performSegue(withIdentifier: "goToWorkout", sender: self)
    }
    @IBAction func tapFriends(_ sender: Any) {
        performSegue(withIdentifier: "goToFriends", sender: self)
    }
    @IBAction func tapSchedule(_ sender: Any) {
        performSegue(withIdentifier: "goToSchedule", sender: self)

    }
    @IBAction func tapProgress(_ sender: Any) {
        performSegue(withIdentifier: "goToProgress", sender: self)
    }
    @IBAction func tapSettings(_ sender: Any) {
        performSegue(withIdentifier: "tapSettings", sender: self)
    }
    
    
    
    
    
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Pass user info
        switch(segue.identifier){
        case "goToTrack":
            let destVC = segue.destination as! TrackViewController
            destVC.currentUser = currentUser
            break
        default: break
        }
        

    }
    

}
