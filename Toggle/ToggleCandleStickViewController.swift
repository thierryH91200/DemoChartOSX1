//
//  TogglePieViewController
//  minimalTunes
//
//  Created by John Moody on 12/1/16.
//  Copyright © 2016 John Moody. All rights reserved.
//

import Cocoa
import Charts

class ToggleCandleStickViewController: DemoBaseViewController
{
    var chartView : CandleStickChartView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func toggleButton(_ sender: NSButton) {
        let option = sender.title
        
        switch option {
        case "Toggle Shadow Color":
            for set in chartView?.data!.dataSets as! [CandleChartDataSet] {
                set.shadowColorSameAsCandle = !set.shadowColorSameAsCandle
            }

            chartView?.data?.notifyDataChanged()
            chartView?.notifyDataSetChanged()
            chartView?.needsDisplay = true
            
        default:
            super.handleOption(option, forChartView: chartView!)
        }
    }
}
