//
//  TrackQueueViewController.swift
//  minimalTunes
//
//  Created by John Moody on 12/1/16.
//  Copyright © 2016 John Moody. All rights reserved.
//

import Cocoa
import Charts

class ToggleLineViewController: DemoBaseViewController
{
    var chartView : LineChartView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func toggleButton(_ sender: NSButton) {
        let option = sender.title
        
        switch option {
        case "Toggle Filled":
            for set in chartView?.data!.dataSets as! [LineChartDataSet] {
                set.drawFilledEnabled = !set.drawFilledEnabled
            }
            chartView?.needsDisplay = true
            
        case "Toggle Circles":
            for set in chartView?.data!.dataSets as! [LineChartDataSet] {
                set.drawCirclesEnabled = !set.drawCirclesEnabled
            }
            chartView?.needsDisplay = true
            
        case "Toggle Cubic":
            for set in chartView?.data!.dataSets as! [LineChartDataSet] {
                set.mode = (set.mode == .cubicBezier) ? .linear : .cubicBezier
            }
            chartView?.needsDisplay = true
            
        case "Toggle Stepped":
            for set in chartView?.data!.dataSets as! [LineChartDataSet] {
                set.mode = (set.mode == .stepped) ? .linear : .stepped
            }
            chartView?.needsDisplay = true
            
        case "Toggle Horizontal Cubic":
            for set in chartView?.data!.dataSets as! [LineChartDataSet] {
                set.mode = (set.mode == .cubicBezier) ? .horizontalBezier : .cubicBezier
            }
            chartView?.needsDisplay = true
            
        default:
            super.handleOption(option, forChartView: chartView!)
        }
    }

    
    
    
}
