//
//  StackedBarChartViewController .swift
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

open class StackedBarChartViewController: NSViewController
{
    @IBOutlet var chartView: BarChartView!
    
    lazy var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        formatter.negativeSuffix = " $"
        formatter.positiveSuffix = " $"
        
        return formatter
    }()
    
    override open func viewDidAppear()
    {
        super.viewDidAppear()
        view.window!.title = "Stacked Bar Chart"
    }
    
    override open func viewWillAppear()
    {
        chartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
    }
    
    override open func viewDidLoad()
    {
        super.viewDidLoad()
        
        // MARK: General
        chartView.maxVisibleCount = 40
        chartView.pinchZoomEnabled = false
        chartView.drawGridBackgroundEnabled = true
        chartView.drawBarShadowEnabled = false
        chartView.drawValueAboveBarEnabled = false
        chartView.highlightFullBarEnabled = false
        
        // MARK: xAxis
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .top
        xAxis.drawGridLinesEnabled = true
        
         // MARK: leftAxis
        let leftAxis = chartView.leftAxis
        leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: formatter)
        leftAxis.axisMinimum = 0.0
        leftAxis.drawGridLinesEnabled = true
        
        // MARK: rightAxis
        chartView.rightAxis.enabled = false
        
        // MARK: legend
        let legend = chartView.legend
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .bottom
        legend.orientation = .horizontal
        legend.drawInside = false
        legend.form = .square
        legend.formSize = 8.0
        legend.formToTextSpace = 4.0
        legend.xEntrySpace = 6.0
        
        // MARK: description
        chartView.chartDescription?.enabled = false
        
        let marker = RectMarker(color: #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), font: NSUIFont.systemFont(ofSize: CGFloat(12.0)), insets: EdgeInsets(top: 8.0, left: 8.0, bottom: 20.0, right: 8.0))
        marker.chartView = chartView
        marker.minimumSize = CGSize(width: CGFloat(60.0), height: CGFloat(30.0))
        chartView.marker = marker

        setDataCount(12, range: UInt32(100.0))
    }
    
    func setDataCount(_ count: Int, range: UInt32)
    {
        // MARK: BarChartDataEntry
        let yVals = (0..<count).map { (i) -> BarChartDataEntry in
            let mult = range + 1
            let val1 = Double(arc4random_uniform(mult) + mult / 3)
            let val2 = Double(arc4random_uniform(mult) + mult / 3)
            let val3 = Double(arc4random_uniform(mult) + mult / 3)
            
            return BarChartDataEntry(x: Double(i), yValues: [val1, val2, val3])
        }
        
        // MARK: BarChartDataSet
        var set1 =  BarChartDataSet()
        if chartView.data != nil
        {
            set1 = chartView.data!.dataSets[0] as! BarChartDataSet
            set1.values = yVals
            chartView.data?.notifyDataChanged()
            chartView.notifyDataSetChanged()
        }
        else
        {
             set1 = BarChartDataSet(values: yVals, label: "Statistics Vienna 2014")
            set1.colors = [#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)]
            set1.stackLabels = ["data1", "data2"]
            set1.valueFont = NSUIFont(name: "HelveticaNeue-Light", size: CGFloat(10.0))!
            set1.valueFormatter = DefaultValueFormatter(formatter: formatter )
            set1.valueTextColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            set1.stackLabels = ["Births", "Divorces", "Marriages"]
            
            // MARK: BarChartData
            let data = BarChartData()
            data.addDataSet(set1)
            data.setValueFormatter(DefaultValueFormatter(formatter: formatter))
            data.setValueTextColor(.white)
            chartView.fitBars = true
            chartView.data = data
        }
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


