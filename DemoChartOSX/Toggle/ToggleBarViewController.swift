//
//  TogglePieViewController
//  minimalTunes
//
//  Created by John Moody on 12/1/16.
//  Copyright © 2016 John Moody. All rights reserved.
//

import Cocoa
import Charts

class ToggleBarViewController: DemoBaseViewController
{
    var chartView : BarChartView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func toggleButton(_ sender: NSButton) {
        let option = sender.title
        
        switch option {
        case "Toggle BarBorders":
            for set in (chartView?.data!.dataSets)! {
                if let set = set as? BarChartDataSet {
                    set.barBorderWidth = set.barBorderWidth == 2.0 ? 0.0 : 2.0
                }
            }
            chartView?.needsDisplay = true

        default:
            super.handleOption(option, forChartView: chartView!)
        }
    }
}
