//
//  RadarChartViewController .swift
//  ChartsDemo-OSX
//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  Copyright © 2017 thierry Hentic.
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/ios-charts

import Foundation
import Cocoa
import Charts

open class RadarChartViewController: DemoBaseViewController
{
    @IBOutlet var chartView: RadarChartView!
    
    @IBOutlet var mainMenu: NSMenu!
    
    let activities = ["Burger", "Steak", "Salad", "Pasta", "Pizza"]
    
    override open func viewDidAppear()
    {
        super.viewDidAppear()
        view.window!.title = "Radar Chart"
    }
    
    override open func viewWillAppear()
    {
        chartView.animate(xAxisDuration: 1.4, yAxisDuration: 1.4, easingOption: .easeInOutBack)
    }
    
    override open func viewDidLoad()
    {
        super.viewDidLoad()
        
//        let options = [["label": "Toggle Values"],
//                       ["label": "Toggle Toggle highlight circle"],
//                       ["label": "Toggle Toggle X-Values"],
//                       ["label": "Toggle Toggle Y-Values"],
//                       ["label": "Toggle Rotate"],
//                       ["label": "Toggle Fill"],
//                       ["label": "Toggle Highlight"],
//                       ["label": "Animate X"],
//                       ["label": "Animate Y"],
//                       ["label": "Animate XY"],
//                       ["label": "Save to Camera Roll"],
//                       ["label": "Spin"],
//                       ["label": "Toggle auto scale min/max"],
//                       ["label": "Toggle Data"]]
//        
//        mainMenu.removeAllItems()
//        for option in options
//        {
//            if option["label"]  == "separator"
//            {
//                mainMenu.addItem(NSMenuItem.separator())
//            }
//            else
//            {
//                mainMenu.addItem(withTitle: option["label"]!, action: #selector(RadarChartViewController.optionTapped(sender:)), keyEquivalent: "")
//            }
//        }
//        for item in mainMenu.items
//        {
//            item.target = self
//        }
        
        // MARK: General
        chartView.backgroundColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        chartView.webLineWidth = 1.0
        chartView.innerWebLineWidth = 1.0
        chartView.webColor = .lightGray
        chartView.innerWebColor = .lightGray
        chartView.webAlpha = 1.0
        
        // MARK: xAxis
        let xAxis = chartView.xAxis
        xAxis.enabled = true
        xAxis.labelFont = NSUIFont(name: "HelveticaNeue-Light", size: CGFloat(9.0))!
        xAxis.xOffset = 0.0
        xAxis.yOffset = 0.0
        xAxis.labelTextColor = .white
        xAxis.valueFormatter = RadarChartXValueFormatter(withLabels: activities)
        xAxis.drawLabelsEnabled = true
        xAxis.labelTextColor = .white
        
        // MARK: yAxis
        let yAxis = chartView.yAxis
        yAxis.labelFont = NSUIFont(name: "HelveticaNeue-Light", size: CGFloat(9.0))!
        yAxis.labelCount = 5
        yAxis.axisMinimum = 0.0
        yAxis.axisMaximum = 80.0
        yAxis.drawLabelsEnabled = true
        yAxis.labelTextColor = .white
        
        // MARK: legend
        let legend = chartView.legend
        legend.horizontalAlignment = .center
        legend.verticalAlignment = .top
        legend.orientation = .horizontal
        legend.drawInside = false
        legend.font = NSUIFont(name: "HelveticaNeue-Light", size: CGFloat(10.0))!
        legend.xEntrySpace = 7.0
        legend.yEntrySpace = 5.0
        legend.textColor = .white
        
        // MARK: description
        chartView.chartDescription?.enabled = true
        chartView.chartDescription?.text = "Radar demo"
        chartView.chartDescription?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        updateChartData()
    }
    
    override func updateChartData()
    {
        setChartData()
    }
    
    func setChartData()
    {
        let mult: UInt32 = 80
        let min: UInt32 = 20
        let cnt = 5
        
        let block: (Int) -> RadarChartDataEntry = { _ in return RadarChartDataEntry(value: Double(arc4random_uniform(mult) + min))}
        let entries1 = (0..<cnt).map(block)
        let entries2 = (0..<cnt).map(block)
        
        // MARK: RadarChartDataSet
        let set1 = RadarChartDataSet(values: entries1, label: "Last Week")
        set1.colors = [NSUIColor(red: CGFloat(103 / 255.0), green: CGFloat(110 / 255.0), blue: CGFloat(129 / 255.0), alpha: 1.0)]
        set1.fillColor = NSUIColor(red: CGFloat(103 / 255.0), green: CGFloat(110 / 255.0), blue: CGFloat(129 / 255.0), alpha: 1.0)
        set1.drawFilledEnabled = true
        set1.fillAlpha = 0.7
        set1.lineWidth = 2.0
        set1.drawHighlightCircleEnabled = true
        set1.setDrawHighlightIndicators(false)
        
        let set2 = RadarChartDataSet(values: entries2, label: "This Week")
        set2.colors = [NSUIColor(red: CGFloat(121 / 255.0), green: CGFloat(162 / 255.0), blue: CGFloat(175 / 255.0), alpha: 1.0)]
        set2.fillColor = NSUIColor(red: CGFloat(121 / 255.0), green: CGFloat(162 / 255.0), blue: CGFloat(175 / 255.0), alpha: 1.0)
        set2.drawFilledEnabled = true
        set2.fillAlpha = 0.7
        set2.lineWidth = 2.0
        set2.drawHighlightCircleEnabled = true
        set2.setDrawHighlightIndicators(false)
        
        // MARK: RadarChartData
        let data = RadarChartData(dataSets: [set1, set2])
        data.setValueFont ( NSUIFont(name: "HelveticaNeue-Light", size: CGFloat(8.0)))
        data.setDrawValues ( false )
        data.setValueTextColor(  NSUIColor.white)
        chartView.data = data
    }
    
//    func optionTapped( sender: NSMenuItem)
//    {
//        switch (sender.title)
//        {
//        case "Toggle Filled":
//            for  i in 0..<chartView.data!.dataSets.count
//            {
//                let set = chartView.data!.dataSets[i] as! RadarChartDataSet
//                set.drawFilledEnabled = !set.isDrawFilledEnabled
//            }
//            chartView.needsDisplay = true
//            
//        case "Toggle highlight circle":
//            for  i in 0..<chartView.data!.dataSets.count
//            {
//                let set = chartView.data!.dataSets[i] as! RadarChartDataSet
//                set.drawHighlightCircleEnabled = !set.drawHighlightCircleEnabled
//            }
//            chartView.needsDisplay = true
//            
//        case "Spin":
//            for  _ in 0..<chartView.data!.dataSets.count
//            {
//                chartView.spin (duration : 2.0, fromAngle: chartView.rotationAngle, toAngle: chartView.rotationAngle + 360.0, easingOption: .easeInCubic)
//                //chartView.spin(duration: <#T##TimeInterval#>, fromAngle: <#T##CGFloat#>, toAngle: <#T##CGFloat#>)
//            }
//            chartView.needsDisplay = true
//            
//        default:
//            super.toggle(sender.title, chartView: chartView)
//        }
//    }
    
    
    // MARK: - IAxisValueFormatter
    func string(forValue value: Double, axis: AxisBase) -> String {
        return activities[Int(value) % activities.count]
    }
    
    
}



class RadarChartXValueFormatter: NSObject, IAxisValueFormatter {
    
    init(withLabels labels: String...) {
        self.labels = labels
        super.init()
    }
    
    init(withLabels labels: [String]) {
        self.labels = labels
        super.init()
    }
    
    var labels: [String]
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let index = Int(value)
        return labels.indices ~= index ? labels[index] : ""
    }
}









