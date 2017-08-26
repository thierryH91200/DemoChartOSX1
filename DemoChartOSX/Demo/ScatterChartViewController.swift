//
//  ScatterChartViewController .swift
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

open class ScatterChartViewController: NSViewController
{
    @IBOutlet var chartView: ScatterChartView!
    
    override open func viewDidAppear()
    {
        super.viewDidAppear()
        view.window!.title = "Scatter Chart"
    }
    
    override open func viewWillAppear()
    {
        chartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
    }
    
    override open func viewDidLoad()
    {
        super.viewDidLoad()
        
        // MARK: General
        chartView.drawGridBackgroundEnabled = false
        chartView.setScaleEnabled ( true)
        chartView.maxVisibleCount = 200
        chartView.drawBordersEnabled = true
        
        // MARK: xAxis
        let xAxis = chartView.xAxis
        xAxis.labelFont = NSUIFont(name: "HelveticaNeue-Light", size: 10.0)!
        xAxis.drawGridLinesEnabled = true
        xAxis.labelPosition = .bottom
        
//        xAxis.nameAxis = "Normal Name"
//        xAxis.nameAxisEnabled = true
        
        // MARK: leftAxis
        let leftAxis = chartView.leftAxis
        leftAxis.labelFont = NSUIFont(name: "HelveticaNeue-Light", size: 10.0)!
        leftAxis.axisMinimum = 0.0
        
//        leftAxis.nameAxis = "Left name"
//        leftAxis.nameAxisEnabled = true
        
        // MARK: rightAxis
        chartView.rightAxis.enabled = false
        
        // MARK: legend
        let legend = chartView.legend
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.orientation = .vertical
        legend.drawInside = false
        legend.font = NSUIFont(name: "HelveticaNeue-Light", size: 10.0)!
        legend.xOffset = 5.0
        
        // MARK: description
        chartView.chartDescription?.enabled = false
        
        let marker = BalloonMarker(color: #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1), font: NSUIFont.systemFont(ofSize: CGFloat(12.0)), textColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), insets: EdgeInsets(top: 8.0, left: 8.0, bottom: 4.0, right: 4.0))
        marker.chartView = chartView
        marker.minimumSize = CGSize(width: CGFloat(60.0), height: CGFloat(30.0))
        chartView.marker = marker
        
        setDataCount(45, range: 100.0)
    }
    
    func setDataCount(_ count: Int, range: Double)
    {
        // MARK: ChartDataEntry
        var yVals1 = [ChartDataEntry]()
        var yVals2 = [ChartDataEntry]()
        var yVals3 = [ChartDataEntry]()
        
        for i in 0..<count
        {
            var val = Double(arc4random_uniform(UInt32(range))) + 3
            yVals1.append(ChartDataEntry(x: Double(i), y: val))
            val = Double(arc4random_uniform(UInt32(range))) + 3
            yVals2.append(ChartDataEntry(x: -Double(i) + 0.33, y: val))
            val = Double(arc4random_uniform(UInt32(range))) + 3
            yVals3.append(ChartDataEntry(x: Double(i) + 0.66, y: val))
        }
        
        // MARK: ScatterChartDataSet
        let set1 = ScatterChartDataSet(values: yVals1, label: "DS 1")
        set1.setScatterShape(.square )
        set1.colors =  ChartColorTemplates.liberty()
        set1.scatterShapeSize = 10.0
        
        let set2 = ScatterChartDataSet(values: yVals2, label: "DS 2")
        set2.setScatterShape( .circle)
        set2.scatterShapeHoleColor = NSUIColor.blue
        set2.scatterShapeHoleRadius = 3.5
        set2.colors = ChartColorTemplates.material()
        set2.scatterShapeSize = 10.0
        
        let set3 = ScatterChartDataSet(values: yVals3, label: "DS 3")
        set3.setScatterShape(.triangle)
        set3.colors = [NSUIColor.orange] //ChartColorTemplates.pastel()
        set3.scatterShapeSize = 10.0
        
        var dataSets = [ScatterChartDataSet]()
        dataSets.append(set1)
        dataSets.append(set2)
        dataSets.append(set3)
        
        // MARK: ScatterChartData
        let data = ScatterChartData(dataSets: dataSets)
        data.setValueFont( NSUIFont(name: "HelveticaNeue-Light", size: CGFloat(10.0)))
        chartView.data = data
    }
}

