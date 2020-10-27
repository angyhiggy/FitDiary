//
//  LogTableViewController.swift
//  FitDiary
//
//  Created by Angy Higgy on 2020-06-30.
//  Copyright © 2020 Angy Higgy. All rights reserved.
//

import UIKit

class LogTableViewController: UITableViewController {
    
    var trackVC = TrackViewController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        trackVC.fetchData()
        print(trackVC.foods.count)
        print(trackVC.exercises.count)
        tableView.delegate = self
        tableView.dataSource = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(section==0){
            return trackVC.foods.count
        }
        else if(section==1){
            return trackVC.exercises.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section==0){
            return "Food Entries"
        }
        
        else{
           return "Activity Entries"
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("TABLE INFO")
        //Food entries
        if(indexPath.section == 0){
         let cell = tableView.dequeueReusableCell(withIdentifier: "LogTableViewCell", for: indexPath) as! LogTableViewCell
        
            let food = trackVC.foods[indexPath.row]
            
            cell.foodName.text = food.foodName
            cell.foodCals.text = String(food.calories)
            
            return cell
        }
        
        //Exercise entries
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExLogTableViewCell", for: indexPath) as! ExLogTableViewCell
            
            let activity = trackVC.exercises[indexPath.row]
            
            cell.activityName.text = activity.exerciseName
            cell.activeCals.text = String(activity.calories)
            cell.activeTime.text = String(activity.activeMins)
            
            return cell
        }
        
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
