//
//  TogglePieViewController
//  minimalTunes
//
//  Created by John Moody on 12/1/16.
//  Copyright © 2016 John Moody. All rights reserved.
//

import Cocoa
import Charts

class ToggleBubbleViewController: DemoBaseViewController
{
     var chartView : BubbleChartView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func toggleButton(_ sender: NSButton) {
        let option = sender.title
        
        switch option {
        default:
            super.handleOption(option, forChartView: chartView!)
        }
    }
}
