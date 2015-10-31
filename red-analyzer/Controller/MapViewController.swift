//
//  MapViewController.swift
//  red-analyzer
//
//  Created by Arvind Jagesser on 31/10/15.
//  Copyright © 2015 Arvind Jagesser. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    var lattitude :Double?
    var longtitude :Double?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let _ = lattitude {
            self.lattitude = 52.371567
        }
        
        if let _ = longtitude {
            self.longtitude = 4.910287
        }
        
        let initialLocation = CLLocation(latitude: lattitude!, longitude: longtitude!)
        centerMapOnLocation(initialLocation)

        // Do any additional setup after loading the view.
    }
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
