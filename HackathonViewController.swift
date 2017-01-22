//
//  HackathonViewController.swift
//  MobileLeagueHacking
//
//  Created by Hayden Blair on 1/21/17.
//  Copyright © 2017 HaydenBlair. All rights reserved.
//

import UIKit
import SwiftyJSON

class HackathonViewController: UITableViewController {
    
    var hackathons = [Hackathon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.separatorStyle = .none
        
        let url = Bundle.main.url(forResource: "mlh", withExtension: "json")
        let data = NSData(contentsOf: url!)
        let events = JSON(data!)
        for rawEvent in events.arrayValue {
            let hackathon = Hackathon()
            let event = rawEvent.dictionaryValue
            hackathon.name = event["name"]!.stringValue
            hackathon.date = event["date"]!.stringValue
            hackathon.imageURL = event["imageURL"]!.stringValue
            hackathon.hackURL = event["hackURL"]!.stringValue
            hackathon.logoURL = event["logoURL"]!.stringValue
            hackathon.location = event["location"]!.stringValue
            
            self.hackathons.append(hackathon)
        }
    }
    
    // MARK : Helpers
    
    func setImageFromURL(view: UIImageView, url: String) {
        let request = URLRequest(url: URL(string: url)!)
        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            if error != nil {
                print("Failed fetching image:", error ?? "")
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Not a proper HTTPURLResponse or statusCode")
                return
            }
            
            DispatchQueue.main.async {
                view.image = UIImage(data: data!)
            }
        }.resume()
    }
    
    // MARK : Table view methods
    
    func eventForIndexPath(indexPath: IndexPath) -> Hackathon {
        return hackathons[indexPath.row]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hackathons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "HackathonTableViewCell"
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! HackathonCell
        
        // Style Cell
        cell.container.layer.cornerRadius = 5
        
        cell.logoImage.layer.masksToBounds = true
        cell.logoImage.layer.cornerRadius = 5
        
        cell.splashImage.layer.masksToBounds = true
        cell.splashImage.layer.cornerRadius = 5
        
        cell.container.layer.shadowOpacity = 0.5
        cell.container.layer.shadowOffset = CGSize(width: 0, height: 5)
        
        // Load data into cell
        let event = eventForIndexPath(indexPath: indexPath)
        cell.nameLabel.text = event.name
        cell.dateLabel.text = event.date
        cell.locationLabel.text = event.location
        
        setImageFromURL(view: cell.logoImage, url: event.logoURL)
        setImageFromURL(view: cell.splashImage, url: event.imageURL)
        
        return cell
    }
}
