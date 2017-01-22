//
//  ScheduleViewController.swift
//  MobileLeagueHacking
//
//  Created by Hayden Blair on 1/22/17.
//  Copyright © 2017 HaydenBlair. All rights reserved.
//

import UIKit
import SwiftyJSON

class ScheduleViewController: UITableViewController {
    var schedules = [Schedule]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let url = Bundle.main.url(forResource: "events", withExtension: "json")
        let data = NSData(contentsOf: url!)
        let jadata = JSON(data!)
        for rawData in jadata.arrayValue {
            let schedule = Schedule()
            let json = rawData.dictionaryValue
            schedule.name = json["name"]!.stringValue
            schedule.time = json["time"]!.stringValue
            schedule.location = json["location"]!.stringValue
            
            self.schedules.append(schedule)
            self.tableView.setNeedsLayout()
            self.tableView.layoutIfNeeded()
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK : Table view methods
    
    func scheduleForIndexPath(indexPath: IndexPath) -> Schedule {
        return schedules[indexPath.row]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedules.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "ScheduleTableViewCell"
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ScheduleCell
        
        
        // Load data into cell
        let schedule = scheduleForIndexPath(indexPath: indexPath)
        cell.name.text = schedule.name
        
        cell.time.text = schedule.time
        //
        cell.location.text = schedule.location
        return cell
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
