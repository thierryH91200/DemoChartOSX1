//
//  DemoBaseViewController
//  ChartsDemo-OSX
//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  Copyright © 2017 thierry Hentic.
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/ios-charts

import Cocoa
import Charts


open class DemoBaseViewController: NSViewController
{
    var parties = [String]()
    
    var shouldHideData: Bool = false
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        parties = ["Party A", "Party B", "Party C", "Party D", "Party E", "Party F", "Party G", "Party H", "Party I", "Party J", "Party K", "Party L", "Party M", "Party N", "Party O", "Party P", "Party Q", "Party R", "Party S", "Party T", "Party U", "Party V", "Party W", "Party X", "Party Y", "Party Z"]
     }
    
    func handleOption(_ option: String, forChartView chartView: ChartViewBase) {
        switch option {
        case "Toggle Values":
            for set in chartView.data!.dataSets {
                set.drawValuesEnabled = !set.drawValuesEnabled
            }
            chartView.needsDisplay = true
            
        case "Toggle Icons":
            for set in chartView.data!.dataSets {
                set.drawIconsEnabled = !set.drawIconsEnabled
            }
            chartView.needsDisplay = true
            
        case "Toggle Highlight":
            chartView.data!.highlightEnabled = !chartView.data!.isHighlightEnabled
            chartView.needsDisplay = true
            
        case "Animate X":
            chartView.animate(xAxisDuration: 3)
            
        case "Animate Y":
            chartView.animate(yAxisDuration: 3)
            
        case "Animate XY":
            chartView.animate(xAxisDuration: 3, yAxisDuration: 3)
            
        case "Save to Camera Roll":
            let myAlert:NSAlert = NSAlert()
            myAlert.messageText = "Save To Gallery not implemented on macOS."
            myAlert.runModal()
            
        case "Toggle PinchZoom":
            let barLineChart = chartView as! BarLineChartViewBase
            barLineChart.pinchZoomEnabled = !barLineChart.pinchZoomEnabled
            chartView.needsDisplay = true
            
        case "Toggle auto scale min/max":
            let barLineChart = chartView as! BarLineChartViewBase
            barLineChart.autoScaleMinMaxEnabled = !barLineChart.isAutoScaleMinMaxEnabled
            chartView.notifyDataSetChanged()
            
        case "Toggle Data":
            shouldHideData = !shouldHideData
            updateChartData()
            
        case "Toggle Bar Borders":
            for set in chartView.data!.dataSets {
                if let set = set as? BarChartDataSet {
                    set.barBorderWidth = set.barBorderWidth == 1.0 ? 0.0 : 1.0
                }
            }
            chartView.needsDisplay = true
        default:
            break
        }
    }

    func updateChartData() {
        fatalError("updateChartData not overridden")
    }

    func setupPieChartView(_ chartView: PieChartView)
    {
        chartView.usePercentValuesEnabled = true
        chartView.drawSlicesUnderHoleEnabled = false
        chartView.holeRadiusPercent = 0.58
        chartView.transparentCircleRadiusPercent = 0.61
        chartView.chartDescription?.enabled = false
        //        chartView.setExtraOffsetsWithLeft(5.0, top: 10.0, right: 5.0, bottom: 5.0)
        chartView.drawCenterTextEnabled = true
        
        let paragraphStyle: NSMutableParagraphStyle = NSParagraphStyle.default().mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.alignment = .center
        
        let centerText: NSMutableAttributedString = NSMutableAttributedString(string: "Charts\nby Daniel Cohen Gindi")
        centerText.setAttributes([NSFontAttributeName: NSFont(name: "HelveticaNeue-Light", size: 15.0)!, NSParagraphStyleAttributeName: paragraphStyle], range: NSMakeRange(0, centerText.length))
        
        centerText.addAttributes([NSFontAttributeName: NSFont(name: "HelveticaNeue-Light", size: 13.0)!, NSForegroundColorAttributeName: NSColor.gray], range: NSMakeRange(10, centerText.length - 10))
        
        centerText.addAttributes([NSFontAttributeName: NSFont(name: "HelveticaNeue-LightItalic", size: 13.0)!, NSForegroundColorAttributeName: NSColor(red: 51 / 255.0, green: 181 / 255.0, blue: 229 / 255.0, alpha: 1.0)], range: NSMakeRange(centerText.length - 19, 19))
        
        chartView.centerAttributedText = centerText
        
        chartView.drawHoleEnabled = true
        chartView.rotationAngle = 0.0
        chartView.rotationEnabled = true
        chartView.highlightPerTapEnabled = true
        
        let l = chartView.legend
        l.horizontalAlignment = .right
        l.verticalAlignment = .top
        l.orientation = .vertical
        l.drawInside = false
        l.xEntrySpace = 7.0
        l.yEntrySpace = 0.0
        l.yOffset = 0.0
    }
    
    func setup(barLineChartView chartView: BarLineChartViewBase) {
        chartView.chartDescription?.enabled = false
        
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.pinchZoomEnabled = false
        
        // ChartYAxis *leftAxis = chartView.leftAxis;
        
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        
        chartView.rightAxis.enabled = false
    }

    func setup(radarChartView chartView: RadarChartView) {
        chartView.chartDescription?.enabled = false
    }
}













