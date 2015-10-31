//
//  ChartController.swift
//  red-analyzer
//
//  Created by Milvum on 31/10/2015.
//  Copyright © 2015 Arvind Jagesser. All rights reserved.
//

import UIKit
import Charts

class ChartController : UIViewController {
    var index = 0
    
    @IBOutlet weak var chart: PieChartView!
    
    let data = [MockChartData(name: "Access to Water", xVals: ["<1km", "<2km", "<5km", "+5km"], yVals: [25, 35, 10, 30]),
        MockChartData(name: "Clean Water Education", xVals: ["Yes", "No"], yVals: [65, 35]),
        MockChartData(name: "Making Water Safe", xVals: ["Boil", "Cloth", "Solar", "Chlorine", "Settle", "Other"], yVals: [16, 16, 16, 16, 16, 20])]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = data[index].name
        
        chart.usePercentValuesEnabled = true
        chart.holeTransparent = true
        chart.holeRadiusPercent = 0.4
        chart.transparentCircleRadiusPercent = 0.4
        chart.descriptionText = ""
        
        chart.rotationAngle = 0.0
        chart.data = data[index].pieChart()
        chart.highlightValues(nil)
        chart.drawSliceTextEnabled = false
    }
}