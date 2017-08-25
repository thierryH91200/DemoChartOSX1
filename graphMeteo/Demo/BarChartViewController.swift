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


open class BarChartViewController: DemoBaseViewController, ChartViewDelegate
{
    @IBOutlet var chartView: BarChartView!
    
    @IBOutlet weak var moins: NSButton!
    @IBOutlet weak var home: NSButton!
    @IBOutlet weak var plus: NSButton!
    
    var values = [Double]()
    var mytitle = ""
    var mysection = ""
    
    override open func viewDidAppear()
    {
        super.viewDidAppear()
        view.window!.title = "Bar Chart"
        mytitle = "Candlestick Plot"
        //mysection = "Candlestick"
        //super.registerPlotItem(self)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let months = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        values = [28800.0, 32400.0, 36000.0, 34000.0, 30000.0, 42000.0, 45000.0]
        
        // MARK: General
        chartView.delegate                  = self
        chartView.pinchZoomEnabled          = false
        chartView.doubleTapToZoomEnabled    = false
        chartView.drawBarShadowEnabled      = false
        chartView.drawGridBackgroundEnabled = true
        chartView.fitBars                   = true
        chartView.drawValueAboveBarEnabled = true
        chartView.drawBordersEnabled = true
        
        // MARK: xAxis
        let xAxis                  = chartView.xAxis
        xAxis.labelPosition        = .bottom
        xAxis.drawGridLinesEnabled = true
        xAxis.valueFormatter       = IndexAxisValueFormatter(values:months)
        xAxis.granularity          = 1
        xAxis.labelPosition  = .bottom
        
        xAxis.nameAxis = "Day"
        xAxis.nameAxisEnabled = true
        
        // MARK: leftAxis
        let leftAxis                  = chartView.leftAxis
        leftAxis.drawGridLinesEnabled = true
        leftAxis.drawZeroLineEnabled  = false
        leftAxis.valueFormatter       = HourValueFormatter()
        
        leftAxis.nameAxis = "Hour (s)"
        leftAxis.nameAxisEnabled = true
        
        chartView.leftAxis1.enabled = false
        chartView.rightAxis1.enabled = false
        
        // MARK: rightAxis
        let rightAxis                  = chartView.rightAxis
        rightAxis.drawGridLinesEnabled = true
        rightAxis.valueFormatter       = HourValueFormatter()
        
        rightAxis.nameAxis = "Hour (s)"
        rightAxis.nameAxisEnabled = true
        
        // MARK: legend
        let legend = chartView.legend
        legend.enabled = true
        legend.orientation = .horizontal
        legend.horizontalAlignment = .left
        legend.verticalAlignment = .bottom
        legend.drawInside = false
        
        // MARK: description
        chartView.chartDescription?.enabled = false
        
        self.updateChartData()
    }
    
    override func updateChartData()
    {
        setDataCount(7, range: 100.0)
    }
    
    func setDataCount(_ count: Int, range: Double)
    {
        // MARK: BarChartDataEntry
        var yVals = [BarChartDataEntry]()
        for i in 0..<count
        {
            yVals.append(BarChartDataEntry(x: Double(i), y: Double(values[i])))
        }
        
        // MARK: BarChartDataSet
        var set1 = BarChartDataSet()
        if chartView.data == nil
        {
            set1 = BarChartDataSet(values: yVals, label: "DataSet")
            //set1.colors = ChartColorTemplates.vordiplom()
            set1.colors = [.orange, .orange, .orange, .orange, .orange, .orange, .orange]
            set1.drawValuesEnabled = false
            set1.stackLabels = ["Births"]
            
            var dataSets = [ChartDataSet]()
            
            dataSets.append(set1)
            
            // MARK: marker
            let  marker = YMarkerView( color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), font: NSUIFont.systemFont(ofSize: 12.0),
                                       textColor: NSUIColor.white,
                                       insets: EdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0),
                                       yAxisValueFormatter: HourValueFormatter())
            
            marker.chartView = chartView
            marker.minimumSize = CGSize(width: 80.0, height: 40.0)
            chartView.marker = marker
            
            // MARK: BarChartData
            let data = BarChartData(dataSets: dataSets)
            chartView.fitBars = true
            
            chartView.data = data
        }
        else
        {
            set1 = (chartView.data!.dataSets[0] as! BarChartDataSet )
            set1.values = yVals
            
            chartView.data?.notifyDataChanged()
            chartView.notifyDataSetChanged()
        }
    }
    
    // Zoom Buttons
    @IBAction func zoomAll(_ sender: NSButton) {
        
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
    
    public func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print("chartValueSelected : x = \(highlight.x)")
        
        var set1 = BarChartDataSet()
        set1 = (chartView.data?.dataSets[0] as? BarChartDataSet)!
        var color : [NSUIColor] = [.orange, .orange, .orange, .orange, .orange, .orange, .orange]
        color [Int(highlight.x) ] =  .blue
        set1.colors =  color
        
        chartView.data?.notifyDataChanged()
        chartView.notifyDataSetChanged()
        
    }
    public func chartValueNothingSelected(_ chartView: ChartViewBase)
    {
        print("chartValueNothingSelected")
        var set1 = BarChartDataSet()
        set1 = (chartView.data?.dataSets[0] as? BarChartDataSet)!
        
        set1.colors =  [.orange, .orange, .orange, .orange, .orange, .orange, .orange]
        
        chartView.data?.notifyDataChanged()
        chartView.notifyDataSetChanged()
    }
}

