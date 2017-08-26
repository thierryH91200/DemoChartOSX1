//
//  MultipleBarChartViewController .swift
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

open class MultipleBarChartViewController: DemoBaseViewController
{
    @IBOutlet var chartView: BarChartView!
    
    @IBOutlet weak var sliderX: NSSlider!
    @IBOutlet weak var sliderY: NSSlider!
    
    @IBOutlet weak var sliderTextX: NSTextField!
    @IBOutlet weak var sliderTextY: NSTextField!
    
    override open func viewDidAppear()
    {
        super.viewDidAppear()
        view.window!.title = "Multiple Bar Chart"
    }
    
    override open func viewWillAppear()
    {
        chartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
    }
    
    override open func viewDidLoad()
    {
        super.viewDidLoad()
        
        // MARK: General
        chartView.delegate = self
        chartView.pinchZoomEnabled = false
        chartView.drawBarShadowEnabled = false
        chartView.drawGridBackgroundEnabled = true
        
        // MARK: xAxis
        let xAxis = chartView.xAxis
        xAxis.labelFont = NSUIFont(name: "HelveticaNeue-Light", size: CGFloat(10.0))!
        xAxis.granularity = 1.0
        xAxis.centerAxisLabelsEnabled = true
        xAxis.labelCount = 20
        xAxis.gridLineWidth = 2.0
        xAxis.labelPosition = .bottom
        
        xAxis.nameAxis = "Name xAxis"
        xAxis.nameAxisEnabled = true
        
        // MARK: leftAxis
        let leftAxis = chartView.leftAxis
        leftAxis.enabled = true
        leftAxis.labelTextColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
        leftAxis.labelFont = NSUIFont(name: "HelveticaNeue-Light", size: CGFloat(10.0))!
        leftAxis.valueFormatter = LargeValueFormatter()
        leftAxis.drawGridLinesEnabled = false
        leftAxis.spaceTop = 0.35
        leftAxis.axisMinimum = 0
        
        leftAxis.nameAxis = "Company A"
        leftAxis.nameAxisEnabled = true
        
        // MARK: leftAxis1
        let leftAxis1 = chartView.leftAxis1
        leftAxis1.valueFormatter = LargeValueFormatter()
        leftAxis1.axisMaximum = 10000000
        leftAxis1.axisMinimum = 0
        leftAxis1.drawGridLinesEnabled = false
        leftAxis1.axisSecondaryEnabled = true
        leftAxis1.labelTextColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        leftAxis1.nameAxis = "Company B"
        leftAxis1.nameAxisEnabled = true
        
        let rightAxis1 = chartView.rightAxis1
        rightAxis1.valueFormatter = LargeValueFormatter()
        rightAxis1.axisMinimum = 0
        rightAxis1.axisMaximum = 10000000
        rightAxis1.drawGridLinesEnabled = false
        rightAxis1.axisSecondaryEnabled = true
        rightAxis1.labelTextColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        
        rightAxis1.nameAxis = "Company 🎲"
        rightAxis1.nameAxisEnabled = true
        
        // MARK: rightAxis
        let rightAxis = chartView.rightAxis
        rightAxis.valueFormatter = LargeValueFormatter()
        rightAxis.axisMinimum = 0
        rightAxis.drawGridLinesEnabled = false
        rightAxis.enabled = true
        rightAxis.labelTextColor = #colorLiteral(red: 1, green: 0.1474981606, blue: 0, alpha: 1)
        
        rightAxis.nameAxis = "Company C😐"
        rightAxis.nameAxisEnabled = true
        
        // MARK: legend
        let legend = chartView.legend
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.orientation = .vertical
        legend.drawInside = true
        legend.font = NSUIFont(name: "HelveticaNeue-Light", size: CGFloat(8.0))!
        legend.xOffset = 10.0
        legend.yEntrySpace = 0.0
        
        // MARK: description
        chartView.chartDescription?.enabled = false
        
        let marker = BalloonMarker(color: NSUIColor(white: CGFloat(180 / 255.0), alpha: 1.0), font: NSUIFont.systemFont(ofSize: CGFloat(12.0)), textColor: NSUIColor.white, insets: NSEdgeInsetsMake(8.0, 8.0, 20.0, 8.0))
        marker.chartView = chartView
        marker.minimumSize = CGSize(width: CGFloat(80.0), height: CGFloat(40.0))
        chartView.marker = marker
        
        sliderX.doubleValue = 10.0
        sliderY.doubleValue = 100.0
        self.slidersValueChanged(sliderX)
    }
    
    override func updateChartData()
    {
        self.setDataCount(Int(sliderX.intValue), range: sliderY.doubleValue)
    }
    
    func setDataCount(_ count: Int, range: Double)
    {
        // MARK: BarChartDataEntry
        let groupSpace = 0.2
        let barSpace = 0.00
        let barWidth = 0.2
        // (0.2 + 0.00) * 4 + 0.2 = 1.00 -> interval per "group"
        
        var yVals1 = [BarChartDataEntry]()
        var yVals2 = [BarChartDataEntry]()
        var yVals3 = [BarChartDataEntry]()
        var yVals4 = [BarChartDataEntry]()
        
        let randomMultiplier = range * 100000.0
        let groupCount = count + 1
        let startYear = 1980
        let endYear = startYear + groupCount
        
        for i in startYear..<endYear
        {
            yVals1.append(BarChartDataEntry(x: Double(i), y: Double(arc4random_uniform(UInt32(randomMultiplier)))))
            yVals2.append(BarChartDataEntry(x: Double(i), y: Double(arc4random_uniform(UInt32(randomMultiplier)))))
            yVals3.append(BarChartDataEntry(x: Double(i), y: Double(arc4random_uniform(UInt32(randomMultiplier)))))
            yVals4.append(BarChartDataEntry(x: Double(i), y: Double(arc4random_uniform(UInt32(randomMultiplier)))))
        }
        
        // MARK: BarChartDataSet
        var set1 = BarChartDataSet()
        var set2 = BarChartDataSet()
        var set3 = BarChartDataSet()
        var set4 = BarChartDataSet()
        
        if chartView.data != nil
        {
            set1 = chartView.data?.dataSets[0] as! BarChartDataSet
            set2 = chartView.data?.dataSets[1] as! BarChartDataSet
            set3 = chartView.data?.dataSets[2] as! BarChartDataSet
            set4 = chartView.data?.dataSets[3] as! BarChartDataSet
            
            set1.values = yVals1
            set2.values = yVals2
            set3.values = yVals3
            set4.values = yVals4
            
            // MARK: BarChartData
            let data = BarChartData(dataSets: [set1, set2, set3, set4])
            
            chartView.xAxis.axisMinimum = Double(startYear)
            chartView.xAxis.axisMaximum = (data.groupWidth(groupSpace: groupSpace, barSpace: barSpace)) * sliderX.doubleValue + Double(startYear)
            
            data.groupBars(fromX: Double(startYear), groupSpace: groupSpace, barSpace: barSpace)
            chartView.data = data
            chartView.data?.notifyDataChanged()
            chartView.notifyDataSetChanged()
        }
        else
        {
            set1 = BarChartDataSet(values: yVals1, label: "Company A")
            set1.colors = [#colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)]
            set1.axisDependency = .left
            
            set2 = BarChartDataSet(values: yVals2, label: "Company B")
            set2.colors = [#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]
            set2.axisDependency = .left1
            
            set3 = BarChartDataSet(values: yVals3, label: "Company C")
            set3.colors = [#colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)]
            set3.axisDependency = .right
            
            set4 = BarChartDataSet(values: yVals4, label: "Company D")
            set4.colors = [#colorLiteral(red: 1, green: 0.1474981606, blue: 0, alpha: 1)]
            set4.axisDependency = .right1
            
            var dataSets = [BarChartDataSet]()
            dataSets.append(set1)
            dataSets.append(set2)
            dataSets.append(set3)
            dataSets.append(set4)
            
            // MARK: BarChartData
            let data = BarChartData(dataSets: dataSets)
            
            data.setValueFont( NSUIFont(name: "HelveticaNeue-Light", size: CGFloat(10.0)))
            data.setValueFormatter(LargeValueFormatter())
            
            // specify the width each bar should have
            data.barWidth = barWidth
            
            // restrict the x-axis range
            chartView.xAxis.axisMinimum = Double(startYear)
            // groupWidthWithGroupSpace(...) is a helper that calculates the width each group needs based on the provided parameters
            chartView.xAxis.axisMaximum = Double(startYear) + data.groupWidth(groupSpace: groupSpace, barSpace: barSpace) * Double(groupCount)
            data.groupBars( fromX: Double(startYear), groupSpace: groupSpace, barSpace: barSpace)
            chartView.data = data
        }
    }
    
    // MARK: - Actions
    @IBAction func slidersValueChanged(_ sender: Any)
    {
        let startYear = 1980
        let endYear = startYear + Int(sliderX.intValue)
        sliderTextX.stringValue = "\(startYear)-\(endYear)"
        sliderTextY.stringValue = sliderY.stringValue
        self.updateChartData()
    }
    
    @IBAction func zoomAll(_ sender: AnyObject)
    {
        chartView.fitScreen()
    }
    
    @IBAction func zoomIn(_ sender: AnyObject)
    {
        chartView.zoomToCenter(scaleX: 1.5, scaleY: 1)
    }
    
    @IBAction func zoomOut(_ sender: AnyObject)
    {
        chartView.zoomToCenter(scaleX: 2/3, scaleY: 1)
    }
    
}

// MARK: - ChartViewDelegate
extension MultipleBarChartViewController: ChartViewDelegate
{
    public func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight)
    {
        print("chartValueSelected : x = \(highlight.x)")
    }
    
    public func chartValueNothingSelected(_ chartView: ChartViewBase)
    {
        print("chartValueNothingSelected")
    }
}

