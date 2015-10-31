//
//  WarningController.swift
//  red-analyzer
//
//  Created by Milvum on 31/10/2015.
//  Copyright © 2015 Arvind Jagesser. All rights reserved.
//

import UIKit
import ChameleonFramework
import AFNetworking
import SwiftyJSON

extension UIImage {
    class func imageWithColor(color: UIColor) -> UIImage {
        let rect: CGRect = CGRectMake(0, 0, 20, 20)
        let path = UIBezierPath(ovalInRect: rect)
        
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(20, 20), false, 0)
        color.setFill()
        path.fill()
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

enum Severity {
    case Yellow, Orange, Red, Green
    
    static func image(severity: Severity) -> UIImage {
        switch(severity) {
        case Yellow:
            return UIImage.imageWithColor(FlatYellow())
        case Orange:
            return UIImage.imageWithColor(FlatOrange())
        case Red:
            return UIImage.imageWithColor(FlatRed())
        case Green:
            return UIImage.imageWithColor(FlatGreen())
        }
    }
}

class Warning {
    let severity: Severity
    let column: String
    
    init(severity: Severity, column: String) {
        self.severity = severity
        self.column = column
    }
}

class WarningController: UITableViewController {
    var lattitude :Double?
    var longtitude :Double?
    
    
    
    let data = [Warning(severity: .Red, column: "Distance to water"),
        Warning(severity: .Orange, column: "Clean water education"),
        Warning(severity: .Yellow, column: "Hygenic facilities")]
    
    let deviceData = [Warning(severity: .Red, column: "Temperature at sanitaire is high"),
        Warning(severity: .Green, column: "Temperature at tents is OK")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.view.backgroundColor = UIColor(red: (81/255.0), green: (166/255.0), blue: (220/255.0), alpha: 1)
        
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        
        let manager = AFHTTPRequestOperationManager()
        manager.requestSerializer.setAuthorizationHeaderFieldWithUsername("hackathon", password: "Hackathon2015")
        
        manager.GET( "http://145.128.2.100:8042/v1/search?options=all&format=json&pageLength=1&collection=KPNlora&q=F03D291000001146%20results:raw%20sort:time",
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                print("JSON: " + responseObject.description)
                let json = JSON(responseObject)
                if let lat = json["results"][0]["content"]["DevEUI_uplink"]["LrrLAT"].string {
                    self.lattitude = Double(lat)
                }
                if let lon = json["results"][0]["content"]["DevEUI_uplink"]["LrrLON"].string {
                    self.longtitude = Double(lon)
                }
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                print("Error: " + error.localizedDescription)
        })
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0
        {
            return "Warnings from collected data"
        } else
        {
            return "Warnings from LoRa devices"
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0
        {
            return data.count
        } else {
            return deviceData.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("warning", forIndexPath: indexPath)
        
        var warning : Warning?
        if indexPath.section == 0 {
            warning = data[indexPath.row]
        } else if indexPath.section == 1 {
            warning = deviceData[indexPath.row]
        }
        
        cell.imageView?.image = Severity.image(warning!.severity)
        cell.textLabel?.text = "\(warning!.column)"
        
        return cell
    }
}