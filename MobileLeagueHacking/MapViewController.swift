//
//  MapViewController.swift
//  MobileLeagueHacking
//
//  Created by Hayden Blair on 1/21/17.
//  Copyright © 2017 HaydenBlair. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {
    @IBOutlet var mapWebView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL(string: "https://api.spartahack.com/map")
        let request = NSURLRequest(url: url as! URL)
        mapWebView.loadRequest(request as URLRequest)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
