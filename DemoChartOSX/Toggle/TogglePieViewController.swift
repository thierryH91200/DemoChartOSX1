//
//  TogglePieViewController
//  minimalTunes
//
//  Created by John Moody on 12/1/16.
//  Copyright © 2016 John Moody. All rights reserved.
//

import Cocoa
import Charts

class TogglePieViewController: DemoBaseViewController
{
    var chartView : PieChartView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func toggleButton(_ sender: NSButton) {
        let option = sender.title
        
        switch option {
        case "Toggle X-Values":
            chartView?.drawEntryLabelsEnabled = !(chartView?.drawEntryLabelsEnabled)!
            chartView?.needsDisplay = true
            
        case "Toggle Percent":
            chartView?.usePercentValuesEnabled = !(chartView?.usePercentValuesEnabled)!
            chartView?.needsDisplay = true
            
        case "Toggle Hole":
            chartView?.drawHoleEnabled = !(chartView?.drawHoleEnabled)!
            chartView?.needsDisplay = true
            
        case "Draw CenterText":
            chartView?.drawCenterTextEnabled = !(chartView?.drawCenterTextEnabled)!
            chartView?.needsDisplay = true
            
        case "Spin":
            chartView?.spin(duration: 2,
                            fromAngle: (chartView?.rotationAngle)!,
                            toAngle: (chartView?.rotationAngle)! + 360,
                           easingOption: .easeInCubic)
            chartView?.needsDisplay = true
            
        default:
            super.handleOption(option, forChartView: chartView!)
        }
    }
}
