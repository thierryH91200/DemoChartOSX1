//
//  HorizontalBarChartViewController.swift
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

open class HorizontalBarChartViewController: DemoBaseViewController
{
    @IBOutlet var chartView: HorizontalBarChartView!
        
    @IBOutlet weak var sliderX: NSSlider!
    @IBOutlet weak var sliderY: NSSlider!
    
    @IBOutlet weak var sliderTextX: NSTextField!
    @IBOutlet weak var sliderTextY: NSTextField!
    
    override open func viewDidAppear()
    {
        super.viewDidAppear()
        view.window!.title = "Horizontal Bar Chart"
    }
    
    override open func viewWillAppear()
    {
        chartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
    }
    
    override open func viewDidLoad()
    {
        super.viewDidLoad()
        
        // MARK: General
        chartView.drawBarShadowEnabled = false
        chartView.drawValueAboveBarEnabled = false
        chartView.maxVisibleCount = 60
        chartView.fitBars = true
        chartView.drawGridBackgroundEnabled = true

        // MARK: xAxis
        let xAxis = chartView.xAxis
        xAxis.enabled = true
        xAxis.labelPosition = .bottom
        xAxis.labelFont = NSUIFont.systemFont(ofSize: CGFloat(10.0))
        xAxis.drawAxisLineEnabled = true
        xAxis.drawGridLinesEnabled = true
        xAxis.granularity = 0.0
        
//        xAxis.nameAxis = "Name Axis X"
//        xAxis.nameAxisEnabled = true
        
        // MARK: leftAxis
        let leftAxis = chartView.leftAxis
        leftAxis.labelFont = NSUIFont.systemFont(ofSize: CGFloat(10.0))
        leftAxis.labelTextColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        leftAxis.drawAxisLineEnabled = true
        leftAxis.drawGridLinesEnabled = true
        leftAxis.axisMinimum = 0.0
        
//        leftAxis.nameAxis = "Left name"
//        leftAxis.nameAxisEnabled = true

        // MARK: rightAxis
        let rightAxis                  = chartView.rightAxis
        rightAxis.enabled              = true
        rightAxis.labelFont            = NSUIFont.systemFont(ofSize: CGFloat(10.0))
        rightAxis.labelTextColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
        rightAxis.drawAxisLineEnabled  = true
        rightAxis.drawGridLinesEnabled = true
        rightAxis.axisMinimum          = 0.0
        
//        rightAxis.nameAxis = "Right Name"
//        rightAxis.nameAxisEnabled = true
        
//        chartView.leftAxis1.axisSecondaryEnabled = false
//        chartView.rightAxis1.axisSecondaryEnabled = false
        
        // MARK: legend
        let legend = chartView.legend
        legend.font = NSUIFont(name: "HelveticaNeue-Light", size: CGFloat(11.0))!
        legend.form = .square
        legend.formSize = 8.0
        legend.drawInside = false
        legend.orientation = .horizontal
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .bottom
        
        // MARK: description
        chartView.chartDescription?.enabled = false
        chartView.chartDescription?.text = "Horizontal Bar Chart"

        sliderX.doubleValue = 12.0
        sliderY.doubleValue = 50.0
        slidersValueChanged(sliderX)
    }
    
    override func updateChartData()
    {
        setDataCount(Int(sliderX.intValue) + 1, range: sliderY.doubleValue)
    }
    
    func setDataCount(_ count: Int, range: Double)
    {
        let barWidth = 9.0
        let spaceForBar = 10.0
        
        // MARK: BarChartDataEntry
        var yVals = [BarChartDataEntry]()
        for i in 0..<count
        {
            let mult = range + 1.0
            let val = Double(arc4random_uniform(UInt32(mult)))
            yVals.append(BarChartDataEntry(x: Double(i) * spaceForBar, y: val))
        }
        
        // MARK: BarChartDataSet
        var set1 = BarChartDataSet()
        if chartView.data != nil
        {
            set1 = ( chartView.data?.dataSets[0] as? BarChartDataSet)!
            set1.values = yVals
            chartView.data?.notifyDataChanged()
            chartView.notifyDataSetChanged()
        }
        else
        {
            set1 = BarChartDataSet(values: yVals, label: "DataSet")
            
            // MARK: BarChartData
            let data            = BarChartData(dataSets: [set1])
            data.setValueFont(NSUIFont(name: "HelveticaNeue-Light", size: CGFloat(10.0)))
            data.barWidth       = barWidth
            chartView.data = data
        }
    }
        
    @IBAction func slidersValueChanged(_ sender: AnyObject)
    {
        sliderTextX.stringValue = String(Int( sliderX.intValue))
        sliderTextY.stringValue = String(Int( sliderY.intValue))
        updateChartData()
    }
}


