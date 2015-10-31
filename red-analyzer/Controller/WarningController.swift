//
//  WarningController.swift
//  red-analyzer
//
//  Created by Milvum on 31/10/2015.
//  Copyright © 2015 Arvind Jagesser. All rights reserved.
//

import UIKit
import ChameleonFramework

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
    
    let data = [Warning(severity: .Red, column: "Access to Water"),
        Warning(severity: .Orange, column: "Clean Water Education"),
        Warning(severity: .Yellow, column: "Making Water Safe")]
    
    let deviceData = [Warning(severity: .Red, column: "Temperature at sanitaire is high"),
        Warning(severity: .Green, column: "Temperature at tents is OK")]
    
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.view.backgroundColor = UIColor(red: (81/255.0), green: (166/255.0), blue: (220/255.0), alpha: 1)
        
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0
        {
            return "Warnings from Collected Data"
        } else
        {
            return "Warnings from LoRa Devices"
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            self.index = indexPath.row
            self.performSegueWithIdentifier("chart", sender: self)
        } else if indexPath.section == 1 {
            print("Map")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "chart" {
            let dest = segue.destinationViewController as! ChartController
            dest.index = self.index
        }
    }
}