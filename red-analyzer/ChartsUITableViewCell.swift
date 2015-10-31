//
//  ChartsUITableViewCell.swift
//  red-analyzer
//
//  Created by Arvind Jagesser on 31/10/15.
//  Copyright © 2015 Arvind Jagesser. All rights reserved.
//

import UIKit
import Charts

class ChartsUITableViewCell: UITableViewCell {

    @IBOutlet weak var pieChartView: PieChartView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
