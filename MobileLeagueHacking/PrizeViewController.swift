//
//  PrizeViewController.swift
//  MobileLeagueHacking
//
//  Created by Hayden Blair on 1/22/17.
//  Copyright © 2017 HaydenBlair. All rights reserved.
//

import UIKit
import SwiftyJSON

class PrizeViewController: UITableViewController {
    var prizes = [Prize]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let url = Bundle.main.url(forResource: "prizes", withExtension: "json")
        let data = NSData(contentsOf: url!)
        let jsdata = JSON(data!)
        for rawData in jsdata.arrayValue {
            let prize = Prize()
            let json = rawData.dictionaryValue
            prize.title = json["title"]!.stringValue
            prize.sponsor = json["sponsor"]!.stringValue
            prize.value = json["value"]!.stringValue
            
            self.prizes.append(prize)
            self.tableView.setNeedsLayout()
            self.tableView.layoutIfNeeded()
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK : Table view methods
    
    func prizeForIndexPath(indexPath: IndexPath) -> Prize {
        return prizes[indexPath.row]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prizes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "PrizesTableViewCell"
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PrizesCell
        
        
        // Load data into cell
        let prize = prizeForIndexPath(indexPath: indexPath)
        cell.title.text = prize.title
        cell.value.text = prize.value
        cell.sponsor.text = prize.sponsor
        
        
        
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
