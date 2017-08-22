//
//  TogglePieViewController
//  minimalTunes
//
//  Created by John Moody on 12/1/16.
//  Copyright © 2016 John Moody. All rights reserved.
//

import Cocoa
import Charts

class ToggleRadarViewController: DemoBaseViewController
{
    var chartView : RadarChartView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func toggleButton(_ sender: NSButton) {
        let option = sender.title
        
        switch option {
        case "Toggle X-Labels":
            chartView?.xAxis.drawLabelsEnabled = !(chartView?.xAxis.isDrawLabelsEnabled)!
            chartView?.data?.notifyDataChanged()
            chartView?.notifyDataSetChanged()
            chartView?.needsDisplay = true
            
        case "Toggle Y-Labels":
            chartView?.yAxis.drawLabelsEnabled = !(chartView?.yAxis.drawLabelsEnabled)!
            chartView?.needsDisplay = true
            
        case "Toggle Rotate":
            chartView?.rotationEnabled = !(chartView?.rotationEnabled)!
            chartView?.needsDisplay = true
            
        case "Toggle highlight circle":
            for set in chartView?.data!.dataSets as! [RadarChartDataSet] {
                set.drawHighlightCircleEnabled = !set.drawHighlightCircleEnabled
            }
            chartView?.needsDisplay = true
            
        default:
            super.handleOption(option, forChartView: chartView!)
        }
    }
}
