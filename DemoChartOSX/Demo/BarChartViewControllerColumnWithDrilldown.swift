//
//  BarChartViewControllerColumnWithDrilldown.swift
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

open class BarChartViewControllerColumnWithDrilldown: DemoBaseViewController
{
    @IBOutlet var chartView: BarChartView!
    @IBOutlet weak var backToBrands: NSButton!
    
    lazy var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        formatter.negativeSuffix = " $"
        formatter.positiveSuffix = " $"
        
        return formatter
    }()

    
    var label  = [String]()
    var dataWebIE = [String]()
    let colors = [NSUIColor.blue, NSUIColor.black, NSUIColor.green, NSUIColor.orange, NSUIColor.purple, NSUIColor.gray]
    
    var browsers = [Browser]()
    
    override open func viewDidAppear() {
        super.viewDidAppear()
        view.window!.title = "Bar Chart Column with drilldown"
    }
    
    override open func viewWillAppear()
    {
        chartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
    }
    
    override open func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let filePath = Bundle.main.path(forResource: "drillDown", ofType: "plist")
        {
            browsers = Browser.browserList(filePath)
        }
        
        for browser in browsers
        {
            label.append(browser.name)
            dataWebIE.append(browser.y)
        }
        
        backToBrands.isEnabled = false
        
          // MARK: General
        chartView.delegate = self
        chartView.drawBarShadowEnabled = false
        chartView.drawValueAboveBarEnabled = true
        chartView.maxVisibleCount = 60
        chartView.drawGridBackgroundEnabled = true
        chartView.gridBackgroundColor = NSUIColor.yellow
        
        chartView.highlightPerTapEnabled = true
        chartView.pinchZoomEnabled = false
        chartView.dragEnabled = false
        chartView.setScaleEnabled(false)
        
        // MARK: xAxis
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = NSUIFont(name: "HelveticaNeue-Light", size: CGFloat(10.0))!
        xAxis.drawGridLinesEnabled = false
        xAxis.enabled = true
        
        // MARK: leftAxis
        let leftAxis = chartView.leftAxis
        leftAxis.labelFont = NSUIFont(name: "HelveticaNeue-Light", size: CGFloat(10.0))!
        leftAxis.labelCount = 6
        leftAxis.axisMinimum = 0
        leftAxis.granularityEnabled = true
        leftAxis.granularity = 0.1
        leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter : formatter)
        
        // MARK: rightAxis
        chartView.rightAxis.enabled = false
        
        // MARK: legend
        let legend = chartView.legend
        legend.horizontalAlignment = .left
        legend.verticalAlignment = .bottom
        legend.orientation = .horizontal
        legend.drawInside = false
        legend.form = .square
        legend.formSize = 9.0
        legend.font = NSUIFont.systemFont(ofSize: CGFloat(11.0))
        legend.xEntrySpace = 4.0
        
        // MARK: description
        let bounds = chartView.bounds
        let point = CGPoint( x:bounds.width / 2, y:bounds.height * 0.25)
        chartView.chartDescription?.enabled = true
        chartView.chartDescription?.text = "Browsers"
        chartView.chartDescription?.position = point
        chartView.chartDescription?.font = NSUIFont(name: "HelveticaNeue-Light", size: CGFloat(24.0))!
        
        setData(data : dataWebIE, label: label, colors: colors)
    }
    
    override func updateChartData()
    {
    }
    
    func setData(data : [String], label : [String], colors : [NSUIColor])
    {
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: label)
        
        // MARK: BarChartDataEntry
        var entries = [BarChartDataEntry]()
        for i in 0..<data.count
        {
            entries.append(BarChartDataEntry(x: Double(i), y: Double(data[i] )!))
        }
        
        // MARK: BarChartDataSet
        var set = BarChartDataSet()
        if chartView.data != nil
        {
            set = (chartView.data?.dataSets[0] as? BarChartDataSet)!
            set.values = entries
            set.colors = colors
            
            chartView.data?.notifyDataChanged()
            chartView.notifyDataSetChanged()
        }
        else
        {
            set = BarChartDataSet(values: entries, label: "Browser market shares")
            set.colors = colors
        }
        
        set.valueFont = NSUIFont(name: "HelveticaNeue-Light", size: CGFloat(10.0))!
        set.drawValuesEnabled = true
        set.barBorderWidth = 0.1
        set.valueFormatter = DefaultValueFormatter(formatter : formatter)
        
        // MARK: BarChartData
        let data = BarChartData(dataSet: set)
        chartView.data = data
    }
    
    @IBAction func actionBack(_ sender: Any) {
        
        backToBrands.isEnabled = false
        chartView.chartDescription?.text = "Browsers"
        setData(data : dataWebIE, label: label, colors: colors)
    }
 }

extension BarChartViewControllerColumnWithDrilldown: ChartViewDelegate
{
    public func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight)
    {
        guard chartView.chartDescription?.text == "Browsers" else { return }
        
        let index = Int(highlight.x)
        var label = [String]()
        var dataW = [String]()
        
        for browser in browsers[index].drillDown
        {
            label.append(browser.version )
            dataW.append(browser.pdm )
        }
        
        if dataW.count == 0
        {
            return
        }
        backToBrands.isEnabled = true
        chartView.chartDescription?.text = browsers[index].name
        setData(data : dataW, label : label, colors : [colors[index]])
        
        chartView.animate(xAxisDuration: 1.0, easingOption : .linear)
    }
    
    public func chartValueNothingSelected(_ chartView: ChartViewBase)
    {
        print("chartValueNothingSelected")
    }
    
}

