//
//  LineChartRealTimeViewController.swift
//  DemoChartOSX
//
//  Created by thierryH24100 on 25/08/2017.
//  Copyright © 2017 thierryH24100. All rights reserved.
//

import Cocoa
import Charts


class LineChartRealTimeViewController: NSViewController {
    
    @IBOutlet var chartView : LineChartView!
    
    @IBOutlet weak var time: NSTextField!
    
    var yEntries = [ChartDataEntry]()
    var currentCount = 0
    
    var timer  : Timer?
    var step = 0
    
    override func viewWillDisappear()
    {
        super.viewWillDisappear()
        if timer != nil {
            timer!.invalidate()
            timer = nil
        }
    }
    
    override public func viewDidAppear() {
        super.viewDidAppear()
        view.window!.title = "Real Time Line"
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        chartView.drawBordersEnabled = true
        chartView.drawGridBackgroundEnabled = true
        chartView.gridBackgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        chartView.chartDescription?.enabled = false
        
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.axisMinimum = 0.0
        xAxis.axisMaximum = 50.0
        
        let leftAxis = chartView.leftAxis
        leftAxis.axisMaximum = 15
        leftAxis.axisMinimum = 0
        
        let rightAxis = chartView.rightAxis
        rightAxis.enabled = false
        
        let marker = RectMarker(color: #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1), font: NSUIFont.systemFont(ofSize: CGFloat(12.0)), insets: EdgeInsets(top: 8.0, left: 8.0, bottom: 4.0, right: 4.0))
        marker.chartView = chartView
        marker.minimumSize = CGSize(width: CGFloat(60.0), height: CGFloat(30.0))
        chartView.marker = marker
        
        currentCount = 10
        time.intValue = Int32(currentCount)

        yEntries = (0..<currentCount).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(UInt32(10))) + 2
            return ChartDataEntry(x: Double(i), y: val)
        }
        
        var set1 = LineChartDataSet()
        set1 = LineChartDataSet(values: yEntries, label: "DataSet 1")
        set1.axisDependency = .left
        set1.setColor(NSColor.blue)
        set1.highlightColor = .black
        set1.highlightLineDashPhase = 1.0
        
        set1.drawCirclesEnabled = false
        set1.drawFilledEnabled = false
        set1.mode = .cubicBezier
        
        var dataSets = [LineChartDataSet]()
        dataSets.append(set1)
        
        let data = LineChartData(dataSets: dataSets)
        data.setValueTextColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        data.setValueFont(NSUIFont(name: "HelveticaNeue-Light", size: CGFloat(9.0)))
        chartView.data = data
    }

    func addValuesToChart()
    {
        let yValue = Double(arc4random_uniform(UInt32(10))) + 2
        
        let chartEntry = ChartDataEntry(x: Double(currentCount), y: yValue)
        yEntries.append(chartEntry)
        if yEntries.count == Int(50 / step)
        {
            chartView.xAxis.resetCustomAxisMax()
            chartView.xAxis.resetCustomAxisMin()
        }

        if yEntries.count >= Int(50 / step)
        {
            yEntries.removeFirst()
        }

        chartView.moveViewToX(Double(currentCount))
        time.intValue = Int32(currentCount)
        currentCount += step
 
        var set1 = LineChartDataSet()
        set1 = (chartView.data?.dataSets[0] as? LineChartDataSet)!
        
        set1.values = yEntries
        chartView.data?.notifyDataChanged()
        chartView.notifyDataSetChanged()
    }
    
    @IBAction func pauseButton(_ sender: Any) {
        
        if timer != nil {
            timer!.invalidate()
            timer = nil
        }
    }
    
    @IBAction func playButton(_ sender: Any) {
        if timer != nil {
            timer!.invalidate()
            timer = nil
        }
        step = 1
        timer = Timer.scheduledTimer(timeInterval: Double(step), target: self, selector: #selector(self.addValuesToChart), userInfo: nil, repeats: true)
    }
}
