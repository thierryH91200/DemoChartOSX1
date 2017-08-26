//
//  TrackQueueViewController.swift
//  minimalTunes
//
//  Created by John Moody on 12/1/16.
//  Copyright © 2016 John Moody. All rights reserved.
//

import Cocoa
import Charts
import Foundation


class LineChart2ViewController: NSViewController, ChartViewDelegate
{
    @IBOutlet var chartView: LineChartView!
    
    @IBOutlet weak var sliderX: NSSlider!
    @IBOutlet weak var sliderY: NSSlider!
    
    @IBOutlet weak var sliderTextX: NSTextField!
    @IBOutlet weak var sliderTextY: NSTextField!
    
//    var barLineChartViewBase : BarLineChartViewBase = BarLineChartViewBase()
    
    override public func viewDidAppear() {
        super.viewDidAppear()
        view.window!.title = "Line Chart 2 (Dual YAxis)"
    }
    
    override public func viewWillAppear()
    {
        chartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
    }
    
    override open func viewDidLoad()
    {
        super.viewDidLoad()
        
 //       barLineChartViewBase = chartView
        
        // MARK: General
        chartView.delegate = self
        chartView.dragEnabled = true
        chartView.setScaleEnabled ( true)
        chartView.drawGridBackgroundEnabled = true
        chartView.pinchZoomEnabled = true
        chartView.drawBordersEnabled = true
        chartView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        chartView.gridBackgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        chartView.autoScaleMinMaxEnabled = true
        
        chartView.scaleYEnabled = false
        chartView.scaleXEnabled = true
//        chartView.dragYEnabled = false
//        chartView.dragXEnabled = true
        
        // MARK: xAxis
        let xAxis = chartView.xAxis
        xAxis.labelFont = NSUIFont.systemFont(ofSize: CGFloat(12.0))
        xAxis.labelTextColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        xAxis.drawGridLinesEnabled = false
        xAxis.drawAxisLineEnabled = false
        xAxis.labelPosition = .bottom
        xAxis.labelRotationAngle = 0
        
//        xAxis.nameAxis = "Name xAxis"
//        xAxis.nameAxisEnabled = true
        
        // MARK: leftAxis
        let leftAxis = chartView.leftAxis
        leftAxis.enabled = true
        
        leftAxis.labelTextColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
        leftAxis.axisMaximum = 400.0
        leftAxis.axisMinimum = -40.0
        leftAxis.drawGridLinesEnabled = true
        leftAxis.drawZeroLineEnabled = false
        leftAxis.granularityEnabled = false
        
//        leftAxis.nameAxis = "Name Principal"
//        leftAxis.nameAxisEnabled = true
        
        // MARK: leftAxis1
        let leftAxis1 = chartView.leftAxis
//        leftAxis1.axisSecondaryEnabled = true

        leftAxis1.labelTextColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        leftAxis1.axisMaximum = 1200
        leftAxis1.axisMinimum = 100
        leftAxis1.drawGridLinesEnabled = false
        leftAxis1.drawZeroLineEnabled = false
        leftAxis1.granularityEnabled = false

//        leftAxis1.nameAxis = "Name Secondaire"
//        leftAxis1.nameAxisEnabled = true
        
        // MARK: rightAxis
        let rightAxis = chartView.rightAxis
        rightAxis.enabled = true
        
        rightAxis.labelTextColor = #colorLiteral(red: 1, green: 0.1474981606, blue: 0, alpha: 1)
        rightAxis.axisMaximum = 100
        rightAxis.axisMinimum = -100.0
        rightAxis.drawGridLinesEnabled = false
        rightAxis.granularityEnabled = false
        
//        rightAxis.nameAxis = "Name Principal"
//        rightAxis.nameAxisEnabled = true
        
        // MARK: rightAxis1
        let rightAxis1 = chartView.rightAxis
//        rightAxis1.axisSecondaryEnabled = true

        rightAxis1.labelTextColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        rightAxis1.axisMaximum = 500.0
        rightAxis1.axisMinimum = 0
        rightAxis1.drawGridLinesEnabled = false
        rightAxis1.granularityEnabled = false
        
//        rightAxis1.nameAxis = "Name Secondaire"
//        rightAxis1.nameAxisEnabled = true
        
        //        self.chartView.leftAxis.resetCustomAxisMin()
        //        self.chartView.leftAxis.resetCustomAxisMax()
        //        self.chartView.rightAxis.resetCustomAxisMin()
        //        self.chartView.rightAxis.resetCustomAxisMax()
        //
        //        self.chartView.leftAxis1.resetCustomAxisMin()
        //        self.chartView.leftAxis1.resetCustomAxisMax()
        //        self.chartView.rightAxis1.resetCustomAxisMin()
        //        self.chartView.rightAxis1.resetCustomAxisMax()
        
        // MARK: legend
        let legend = chartView.legend
        legend.font = NSUIFont(name: "HelveticaNeue-Light", size: CGFloat(14.0))!
        legend.textColor = NSUIColor.black
        legend.form = .square
        legend.drawInside = false
        legend.orientation = .horizontal
        legend.horizontalAlignment = .left
        legend.verticalAlignment = .bottom
        
        // MARK: description
        chartView.chartDescription?.enabled = false
        
        let marker = RectMarker(color: #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1), font: NSUIFont.systemFont(ofSize: CGFloat(12.0)), insets: EdgeInsets(top: 8.0, left: 8.0, bottom: 4.0, right: 4.0))
        marker.chartView = chartView
        marker.minimumSize = CGSize(width: CGFloat(60.0), height: CGFloat(30.0))
        chartView.marker = marker

        sliderX.doubleValue = 40.0
        sliderY.doubleValue = 30.0
        slidersValueChanged(sliderX)
    }
    
    func updateChartData() {
        setDataCount(Int(sliderX.intValue) + 1, range: UInt32(sliderY.doubleValue))
    }
    
    func setDataCount(_ count: Int, range: UInt32)
    {
        let yVals1 = (0..<count).map { (i) -> ChartDataEntry in
            let mult : UInt32 = range / 2
            let val = Double(arc4random_uniform(mult)) - 30.0
            return ChartDataEntry(x: Double(i), y: val)
        }
        let yVals2 = (0..<count).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(range) + 950)
            return ChartDataEntry(x: Double(i), y: val)
        }
        let yVals3 = (0..<count).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(range)) - 30.0
            return ChartDataEntry(x: Double(i), y: val)
        }
        
        let yVals4 = (0..<count).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(range) + 450)
            return ChartDataEntry(x: Double(i), y: val)
        }
        
        // MARK: LineChartDataSet
        var set1 = LineChartDataSet()
        var set2 = LineChartDataSet()
        var set3 = LineChartDataSet()
        var set4 = LineChartDataSet()
        if chartView.data != nil
        {
            set1 = (chartView.data?.dataSets[0] as? LineChartDataSet)!
            set2 = (chartView.data?.dataSets[1] as? LineChartDataSet)!
            set3 = (chartView.data?.dataSets[2] as? LineChartDataSet)!
            set4 = (chartView.data?.dataSets[3] as? LineChartDataSet)!
            
            set1.values = yVals1
            set2.values = yVals2
            set3.values = yVals3
            set4.values = yVals4
            chartView.data?.notifyDataChanged()
            chartView.notifyDataSetChanged()
        }
        else
        {
            set1 = LineChartDataSet(values: yVals1, label: "DataSet 1")
            set1.axisDependency = .left
            set1.colors = [#colorLiteral(red: 0.215686274509804, green: 0.709803921568627, blue: 0.898039215686275, alpha: 1.0)]
            set1.circleColors = [NSUIColor.white]
            set1.lineWidth = 2.0
            set1.circleRadius = 3.0
            set1.fillAlpha = 65 / 255.0
            set1.fillColor = #colorLiteral(red: 0.215686274509804, green: 0.709803921568627, blue: 0.898039215686275, alpha: 1.0)
            set1.drawCircleHoleEnabled = false
            set1.drawCirclesEnabled = false
            set1.mode = .cubicBezier
            set1.highlightLineWidth = 2.0
            set1.highlightColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            set1.highlightEnabled = true
            
            set2 = LineChartDataSet(values: yVals2, label: "DataSet 2")
            set2.axisDependency = .left
            set2.colors = [#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]
            set2.circleColors = [NSUIColor.white]
            set2.lineWidth = 2.0
            set2.circleRadius = 3.0
            set2.fillAlpha = 65 / 255.0
            set2.fillColor = NSUIColor.red
            set2.drawCircleHoleEnabled = false
            set2.drawCirclesEnabled = false
            set2.mode = .cubicBezier
            set2.highlightColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            set2.highlightEnabled = true
            set2.highlightLineWidth = 2.0
            
            set3 = LineChartDataSet(values: yVals3, label: "DataSet 3")
            set3.axisDependency = .right
            set3.colors = [#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)]
            set3.circleColors = [NSUIColor.white]
            set3.lineWidth = 2.0
            set3.circleRadius = 3.0
            set3.fillAlpha = 65 / 255.0
            set3.fillColor = NSUIColor.yellow.withAlphaComponent(200 / 255.0)
            set3.drawCircleHoleEnabled = false
            set3.drawCirclesEnabled = false
            set3.mode = .cubicBezier
            set3.highlightColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            set3.highlightEnabled = true
            set3.highlightLineWidth = 2.0
            set3.drawHorizontalHighlightIndicatorEnabled = false
            
            set4 = LineChartDataSet(values: yVals4, label: "DataSet 4")
            set4.axisDependency = .right
            set4.colors = [#colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)]
            set4.circleColors = [NSUIColor.white]
            set4.lineWidth = 2.0
            set4.circleRadius = 3.0
            set4.fillAlpha = 65 / 255.0
            set4.fillColor = NSUIColor.yellow.withAlphaComponent(200 / 255.0)
            set4.drawCircleHoleEnabled = false
            set4.drawCirclesEnabled = false
            set4.mode = .cubicBezier
            set4.highlightColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            set4.highlightEnabled = true
            set4.highlightLineWidth = 2.0
            set4.drawHorizontalHighlightIndicatorEnabled = false
            
            var dataSets = [LineChartDataSet]()
            dataSets.append(set1)
            dataSets.append(set2)
            dataSets.append(set3)
            dataSets.append(set4)
            
            // MARK: LineChartData
            let data = LineChartData(dataSets: dataSets)
            data.setValueTextColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
            data.setValueFont(NSUIFont(name: "HelveticaNeue-Light", size: CGFloat(9.0)))
            chartView.data = data
        }
    }
    
    @IBAction func slidersValueChanged(_ sender: AnyObject)
    {
        sliderTextX.stringValue =  String(Int( sliderX.intValue))
        sliderTextY.stringValue =  String(Int( sliderY.intValue))
        updateChartData()
    }

    @IBAction func toggleDrag(_ sender: Any) {
    }
    
    public func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry.x)
        print(highlight)
    }
}




