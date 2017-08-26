//
//  BarChartViewController.swift
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

open class BubbleChartViewController: NSViewController, ChartViewDelegate
{
    @IBOutlet var chartView: BubbleChartView!
    
    var mytitle = "Bubble Chart"
    
    override open func viewDidAppear()
    {
        super.viewDidAppear()
        view.window!.title = "Bubble Chart"
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // MARK: General
        chartView.delegate                  = self
        chartView.pinchZoomEnabled          = false
        
        chartView.doubleTapToZoomEnabled    = false
        chartView.drawGridBackgroundEnabled = true
        chartView.drawBordersEnabled = true
        
        // MARK: xAxis
        let xAxis                  = chartView.xAxis
        xAxis.labelPosition        = .bottom
        xAxis.drawGridLinesEnabled = true
        xAxis.granularity          = 1
        xAxis.axisMaximum          = 120.0
        xAxis.axisMinimum          = 0.0
        
//        xAxis.nameAxis = "Impact"
//        xAxis.nameAxisEnabled = true
        
        // MARK: leftAxis
        let leftAxis                  = chartView.leftAxis
        leftAxis.drawGridLinesEnabled = true
        leftAxis.drawZeroLineEnabled  = true
        leftAxis.axisMaximum          = 10.0
        
//        leftAxis.nameAxis = "Probability"
//        leftAxis.nameAxisEnabled = true
        
        // MARK: rightAxis
        let rightAxis                  = chartView.rightAxis
        rightAxis.enabled = false
        
//        chartView.leftAxis1.enabled = false
//        chartView.rightAxis1.enabled = false
        
        // MARK: legend
        let legend = chartView.legend
        legend.enabled = true
        legend.verticalAlignment = .center
        legend.horizontalAlignment = .right
        legend.orientation = .vertical
        legend.form = .line
        
        // MARK: description
        chartView.chartDescription?.enabled = false
        
        self.updateChartData()
    }
    
    func updateChartData()
    {
        setDataCount(7, range: 100.0)
    }
    
    func setDataCount(_ count: Int, range: Double)
    {
        // MARK: BubbleChartDataEntry
        let datas = [[10.0,6.0,60.0],[30.0,8.0,240.0],[90.0,5.0,450.0],[50.0,2.0,100.0]]
        let label = ["Foo", "Baz","Bar", "Spong"]
        
        var entries = [BubbleChartDataEntry]()
        let data = BubbleChartData()
        let colors = [#colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1),#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1),#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1),#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)]
        for index in 0..<4
        {
            entries.removeAll()
            let x = datas[index][0]
            let y = datas[index][1]
            let size = datas[index][2] / 10
            entries.append(BubbleChartDataEntry(x: x, y: y, size: CGFloat(size)))
            
            // MARK: BubbleChartDataSet
            let set = BubbleChartDataSet(values: entries, label: label[index])
            set.setColor(colors[index])
            set.valueTextColor = NSUIColor.black
            set.valueFont = NSUIFont.systemFont(ofSize: CGFloat(10.0))
            set.drawValuesEnabled = true
            set.normalizeSizeEnabled = false
            set.formSize = 30.0
            
            data.addDataSet(set)
        }
        chartView.data = data
    }
    
    
    public func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print("Bubble selected")
    }
}

//// MARK: - ChartViewDelegate
//extension BarChartViewController: ChartViewDelegate
//{
//    public func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight)
//    {
//        print("chartValueSelected : x = \(highlight.x)")
//    }
//
//    public func chartValueNothingSelected(_ chartView: ChartViewBase)
//    {
//        print("chartValueNothingSelected")
//    }
//}

