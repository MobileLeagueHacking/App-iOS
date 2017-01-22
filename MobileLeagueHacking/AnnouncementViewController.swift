//
//  AnnouncementViewController.swift
//  MobileLeagueHacking
//
//  Created by Hayden Blair on 1/21/17.
//  Copyright © 2017 HaydenBlair. All rights reserved.
//

import UIKit
import SwiftyJSON

class AnnouncementViewController: UITableViewController {
    var annoucements = [Annoucement]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let url = Bundle.main.url(forResource: "annoucements", withExtension: "json")
        let data = NSData(contentsOf: url!)
        let jdata = JSON(data!)
        for rawData in jdata.arrayValue {
            let announcement = Annoucement()
            let json = rawData.dictionaryValue
            announcement.title = json["title"]!.stringValue
            announcement.body = json["body"]!.stringValue
            
            self.annoucements.append(announcement)
            self.tableView.setNeedsLayout()
            self.tableView.layoutIfNeeded()
            
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK : Table view methods
    
    func annoucementForIndexPath(indexPath: IndexPath) -> Annoucement {
        return annoucements[indexPath.row]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return annoucements.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "AnnouncementTableViewCell"
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AnnouncementCell
        
        
        // Load data into cell
        let annoucement = annoucementForIndexPath(indexPath: indexPath)
        cell.title.text = annoucement.title
        cell.body.text = annoucement.body
        
        
      
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
