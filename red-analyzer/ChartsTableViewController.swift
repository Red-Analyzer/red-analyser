//
//  ChartsTableViewController.swift
//  red-analyzer
//
//  Created by Arvind Jagesser on 31/10/15.
//  Copyright © 2015 Arvind Jagesser. All rights reserved.
//

import UIKit
import Charts
import ChameleonFramework

class MockChartData {
    let name: String
    let xVals: [String]
    let yVals: [Int]
    
    init(name: String, xVals: [String], yVals: [Int]) {
        self.name = name
        self.xVals = xVals
        self.yVals = yVals
    }
    
    func pieChart() -> PieChartData {
        let pyVals = processYVals()
        
        var dataSet : [ChartDataSet] = []
        let dataPie = PieChartDataSet(yVals: pyVals, label: "")
        dataPie.sliceSpace = 2.0
        dataPie.colors = [FlatRed(), FlatOrange(), FlatYellow(), FlatGreen(), FlatBlue(), FlatPurple()]
        dataSet.append(dataPie)
        
        let pieChartData = PieChartData(xVals: xVals, dataSets: dataSet)
        
        let pFormatter: NSNumberFormatter = NSNumberFormatter()
        pFormatter.numberStyle = NSNumberFormatterStyle.PercentStyle
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1.0
        pFormatter.percentSymbol = "%"
        pieChartData.setValueFormatter(pFormatter)
        
        pieChartData.setValueTextColor(UIColor.blackColor())
        
        return pieChartData
    }
    
    private func processYVals() -> [ChartDataEntry] {
        var pyVals: [ChartDataEntry] = []
        
        for i in 0 ..< xVals.count
        {
            pyVals.append(ChartDataEntry.init(value: Double(self.yVals[i]), xIndex: i))
        }
        
        return pyVals
    }
}

class ChartsTableViewController: UITableViewController {
    
    let data = [MockChartData(name: "Access to Water", xVals: ["<1km", "<2km", "<5km", "+5km"], yVals: [25, 35, 10, 30]),
        MockChartData(name: "Clean Water Education", xVals: ["Yes", "No"], yVals: [65, 35]),
        MockChartData(name: "Data 3", xVals: ["A", "B", "C", "D", "E", "F"], yVals: [16, 16, 16, 16, 16, 20])]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifierLabel", forIndexPath: indexPath)

        let dataChart = self.data[indexPath.row]
        
        let chartView: PieChartView = cell.contentView.viewWithTag(99) as! PieChartView
        let titleView: UILabel = cell.contentView.viewWithTag(98) as! UILabel
        
        titleView.text = dataChart.name
        
        chartView.usePercentValuesEnabled = true
        chartView.holeTransparent = true
        chartView.holeRadiusPercent = 0.4
        chartView.transparentCircleRadiusPercent = 0.4
        chartView.descriptionText = ""
        
        chartView.rotationAngle = 0.0
        chartView.data = dataChart.pieChart()
        chartView.highlightValues(nil)
        chartView.drawSliceTextEnabled = false

        return cell
    }
}