//
//  TogglePieViewController
//  minimalTunes
//
//  Created by John Moody on 12/1/16.
//  Copyright © 2016 John Moody. All rights reserved.
//

import Cocoa
import Charts

class ToggleCombinedViewController: DemoBaseViewController
{
    var chartView : CombinedChartView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func toggleButton(_ sender: NSButton) {
        let option = sender.title
        
        switch option {
        case "Toggle Line Values":
            for set in (chartView?.data!.dataSets)! {
                if let set = set as? LineChartDataSet {
                    set.drawValuesEnabled = !set .drawValuesEnabled
                    
                }
            }
            chartView?.needsDisplay = true
            
        case "Toggle Bar Values":
            for set in (chartView?.data!.dataSets)! {
                if let set = set as? BarChartDataSet {
                    set.drawValuesEnabled = !set .drawValuesEnabled
                }
            }
            chartView?.needsDisplay = true
            
        default:
            super.handleOption(option, forChartView: chartView!)
        }
    }
}
