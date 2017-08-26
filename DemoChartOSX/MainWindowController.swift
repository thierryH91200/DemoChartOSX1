//
//  MainWindowController.swift
//  DemoChartOSX
//
//  Created by thierryH24100 on 22/08/2017.
//  Copyright © 2017 thierryH24100. All rights reserved.
//

import Cocoa
import Charts

enum TypeOfChart {
    case bar
    case bubble
    case candleStick
    case combined
    case line
    case pie
    case radar
    case scatter
    case none
    var label: String
    {
        switch self {
        case .bar: return "Bar"
        case .bubble: return "Bubble"
        case .candleStick: return "CandleStick"
        case .combined: return "Combined"
        case .line: return "Line"
        case .pie: return "Pie"
        case .radar: return "Radar"
        case .scatter: return "Scatter"
        case .none: return "None"
        }
    }
}

class MainWindowController: NSWindowController , NSWindowDelegate {
    
    enum TypeOfChart {
        case bar
        case bubble
        case candleStick
        case combined
        case line
        case pie
        case radar
        case scatter
        case none
        var label: String
        {
            switch self {
            case .bar: return "Bar"
            case .bubble: return "Bubble"
            case .candleStick: return "CandleStick"
            case .combined: return "Combined"
            case .line: return "Line"
            case .pie: return "Pie"
            case .radar: return "Radar"
            case .scatter: return "Scatter"
            case .none: return "None"
            }
        }
    }
    
    @IBOutlet weak var chartTargetView: NSView!
    @IBOutlet weak var sourceListTargetView1: NSView!
    @IBOutlet weak var trackQueueView: NSView!
    @IBOutlet weak var albumArtView : NSView!
    
    @IBOutlet weak var artToggle: NSButton!
    @IBOutlet weak var queueButton: NSButton!
    @IBOutlet weak var collectionButton: NSButton!
    
    @IBOutlet weak var stackZoom: NSStackView!
    
    
    // all the sub controllers
    var barChartViewController                    = BarChartViewController()
    var barChartViewControllerColumnWithDrilldown = BarChartViewControllerColumnWithDrilldown()
    var bubbleChartViewController                 = BubbleChartViewController()
    var candleStickChartViewController            = CandleStickChartViewController()
    var coloredLineChartViewController            = ColoredLineChartViewController()
    var combinedChartViewController               = CombinedChartViewController()
    var cubicLineChartViewController              = CubicLineChartViewController()
    var halfPieChartViewController                = HalfPieChartViewController()
    var horizontalBarChartViewController          = HorizontalBarChartViewController()
    var lineChart1ViewController                  = LineChart1ViewController()
    var lineChart2ViewController                  = LineChart2ViewController()
    var lineChartFilledViewController             = LineChartFilledViewController()
    var lineChartTimeViewController               = LineChartTimeViewController()
    var multipleBarChartViewController            = MultipleBarChartViewController()
    var negativeStackedBarChartViewController     = NegativeStackedBarChartViewController()
    var pieChartViewController                    = PieChartViewController()
    var piePolylineChartViewController            = PiePolylineChartViewController()
    var positiveNegativeBarChartViewController    = PositiveNegativeBarChartViewController()
    var radarChartViewController                  = RadarChartViewController()
    var scatterChartViewController                = ScatterChartViewController()
    var sinusBarChartViewController               = SinusBarChartViewController()
    var stackedBarChartViewController             = StackedBarChartViewController()
    var lineChartRealTimeViewController           = LineChartRealTimeViewController()
    
    var sourceCollectionController      : SourceCollectionController?
    var sourceListViewController        : SourceListViewController?
    var albumArtViewController          : AlbumArtViewController?
    
    let toggleBarViewController         = ToggleBarViewController()
    let toggleBubbleViewController      = ToggleBubbleViewController()
    let toggleCandleStickViewController = ToggleCandleStickViewController()
    let toggleCombinedViewController    = ToggleCombinedViewController()
    let toggleLineViewController        = ToggleLineViewController()
    let togglePieViewController         = TogglePieViewController()
    let toggleRadarViewController       = ToggleRadarViewController()
    let toggleScatterViewController     = ToggleScatterViewController()
    
    // all the type of chart
    var barChartView                    : BarChartView?
    var bubbleChartView                 : BubbleChartView?
    var candleStickChartView            : CandleStickChartView?
    var combinedChartView               : CombinedChartView?
    var lineChartView                   : LineChartView?
    var pieChartView                    : PieChartView?
    var radarChartView                  : RadarChartView?
    var scatterChartView                : ScatterChartView?
    
    var barLineChartViewBase            : BarLineChartViewBase?
    
    var collection : NSControlStateValue = NSOffState
    
    var typeOfChart : TypeOfChart = .none
    var imageInfo   = [ImageInfo]()
    
    var delegate: AppDelegate?
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        
        self.sourceCollectionController = SourceCollectionController()
        self.sourceCollectionController?.mainWindowController = self
        
        self.sourceListViewController = SourceListViewController()
        self.sourceListViewController?.mainWindowController = self
        
        setUpSourceList()
        setUpAlbumArt()
    }
    
    func changeView(name: String)
    {
        var  vc = NSView()
        
        switch name
        {
        case "BarChartViewController":
            vc = barChartViewController.view
            barChartView = barChartViewController.chartView
            typeOfChart = .bar
            
        case "BarChartViewControllerColumnWithDrilldown":
            vc = barChartViewControllerColumnWithDrilldown.view
            barChartView = barChartViewControllerColumnWithDrilldown.chartView
            typeOfChart = .bar
            
        case "PositiveNegativeBarChartViewController":
            vc = positiveNegativeBarChartViewController.view
            barChartView = positiveNegativeBarChartViewController.chartView
            typeOfChart = .bar
            
        case "MultipleBarChartViewController":
            vc = multipleBarChartViewController.view
            barChartView = multipleBarChartViewController.chartView
            typeOfChart = .bar
            
        case "NegativeStackedBarChartViewController":
            vc = negativeStackedBarChartViewController.view
            barChartView = negativeStackedBarChartViewController.chartView
            typeOfChart = .bar
            
        case "HorizontalBarChartViewController":
            vc = horizontalBarChartViewController.view
            barChartView = horizontalBarChartViewController.chartView
            typeOfChart = .bar
            
        case "SinusBarChartViewController":
            vc = sinusBarChartViewController.view
            barChartView = sinusBarChartViewController.chartView
            typeOfChart = .bar
            
        case "StackedBarChartViewController":
            vc = stackedBarChartViewController.view
            barChartView = stackedBarChartViewController.chartView
            typeOfChart = .bar
            
        case "BubbleChartViewController":
            vc = bubbleChartViewController.view
            bubbleChartView = bubbleChartViewController.chartView
            typeOfChart = .bubble
            
        case "CandleStickChartViewController":
            vc = candleStickChartViewController.view
            candleStickChartView = candleStickChartViewController.chartView
            typeOfChart = .candleStick
            
        case "ColoredLineChartViewController":
            vc = coloredLineChartViewController.view
            //lineChartView = coloredLineChartViewController.chartView
            typeOfChart = .line
            
        case "CubicLineChartViewController":
            vc = cubicLineChartViewController.view
            lineChartView = cubicLineChartViewController.chartView
            typeOfChart = .line
            
        case "LineChart1ViewController":
            vc = lineChart1ViewController.view
            lineChartView = lineChart1ViewController.chartView
            typeOfChart = .line
            
        case "LineChart2ViewController":
            vc = lineChart2ViewController.view
            lineChartView = lineChart2ViewController.chartView
            typeOfChart = .line
            
        case "LineChartFilledViewController":
            vc = lineChartFilledViewController.view
            lineChartView = lineChartFilledViewController.chartView
            typeOfChart = .line
            
        case "LineChartTimeViewController":
            vc = lineChartTimeViewController.view
            lineChartView = lineChartTimeViewController.chartView
            typeOfChart = .line
            
        case "CombinedChartViewController":
            vc = combinedChartViewController.view
            combinedChartView = combinedChartViewController.chartView
            typeOfChart = .combined
            
        case "HalfPieChartViewController":
            vc = halfPieChartViewController.view
            pieChartView = halfPieChartViewController.chartView
            typeOfChart = .pie
            
        case "PieChartViewController":
            vc = pieChartViewController.view
            pieChartView = pieChartViewController.chartView
            typeOfChart = .pie
            
        case "PiePolylineChartViewController":
            vc = piePolylineChartViewController.view
            pieChartView = piePolylineChartViewController.chartView
            typeOfChart = .pie
            
        case "RadarChartViewController":
            vc = radarChartViewController.view
            radarChartView = radarChartViewController.chartView
            typeOfChart = .radar
            
        case "ScatterChartViewController":
            vc = scatterChartViewController.view
            scatterChartView = scatterChartViewController.chartView
            typeOfChart = .scatter
            
        case "LineChartRealTimeViewController":
            vc = lineChartRealTimeViewController.view
            lineChartView = lineChartRealTimeViewController.chartView
            typeOfChart = .line
            
        default:
            vc = barChartViewController.view
            barChartView = barChartViewController.chartView
            typeOfChart = .bar
        }
        
        addSubview(subView: vc, toView: chartTargetView)
        
        vc.translatesAutoresizingMaskIntoConstraints = false
        
        var viewBindingsDict = [String: AnyObject]()
        viewBindingsDict["vc"] = vc
        chartTargetView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[vc]|", options: [], metrics: nil, views: viewBindingsDict))
        chartTargetView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[vc]|", options: [], metrics: nil, views: viewBindingsDict))
        
        setUpTrackQueue()
    }
    
    func setUpTrackQueue()
    {
        stackZoom.isHidden = true
        switch typeOfChart
        {
        case .line:
            let toggleViewController = self.toggleLineViewController
            
            toggleViewController.chartView = lineChartView
            addSubview(subView: toggleViewController.view, toView: self.trackQueueView)
            setUpLayoutConstraints(item: toggleViewController.view, toItem: trackQueueView)
            toggleViewController.view.frame = trackQueueView.bounds
            
            stackZoom.isHidden = false
            barLineChartViewBase = lineChartView
            
        case .pie:
            let toggleViewController = self.togglePieViewController
            
            toggleViewController.chartView = pieChartView
            addSubview(subView: toggleViewController.view, toView: self.trackQueueView)
            setUpLayoutConstraints(item: toggleViewController.view, toItem: trackQueueView)
            toggleViewController.view.frame = trackQueueView.bounds
            
        case .radar:
            let toggleViewController = self.toggleRadarViewController
            
            toggleViewController.chartView = radarChartView
            addSubview(subView: toggleViewController.view, toView: self.trackQueueView)
            setUpLayoutConstraints(item: toggleViewController.view, toItem: trackQueueView)
            toggleViewController.view.frame = trackQueueView.bounds
            
        case .combined:
            let toggleViewController = self.toggleCombinedViewController
            
            toggleViewController.chartView = combinedChartView
            addSubview(subView: toggleViewController.view, toView: self.trackQueueView)
            setUpLayoutConstraints(item: toggleViewController.view, toItem: trackQueueView)
            toggleViewController.view.frame = trackQueueView.bounds
            
            stackZoom.isHidden = false
            barLineChartViewBase = combinedChartView

        case .bar:
            let toggleViewController = self.toggleBarViewController
            
            toggleViewController.chartView = barChartView
            addSubview(subView: toggleViewController.view, toView: self.trackQueueView)
            setUpLayoutConstraints(item: toggleViewController.view, toItem: trackQueueView)
            toggleViewController.view.frame = trackQueueView.bounds
            
            stackZoom.isHidden = false
            barLineChartViewBase = barChartView
            
        case .bubble:
            let toggleViewController = self.toggleBubbleViewController
            
            toggleViewController.chartView = bubbleChartView
            addSubview(subView: toggleViewController.view, toView: self.trackQueueView)
            setUpLayoutConstraints(item: toggleViewController.view, toItem: trackQueueView)
            toggleViewController.view.frame = trackQueueView.bounds
            
            stackZoom.isHidden = false
            barLineChartViewBase = bubbleChartView
            
        case .scatter:
            let toggleViewController = self.toggleScatterViewController
            
            toggleViewController.chartView = scatterChartView
            addSubview(subView: toggleViewController.view, toView: self.trackQueueView)
            setUpLayoutConstraints(item: toggleViewController.view, toItem: trackQueueView)
            toggleViewController.view.frame = trackQueueView.bounds
            
            stackZoom.isHidden = false
            barLineChartViewBase = scatterChartView
            
        case .candleStick:
            let toggleViewController = self.toggleCandleStickViewController
            
            toggleViewController.chartView = candleStickChartView
            addSubview(subView: toggleViewController.view, toView: self.trackQueueView)
            setUpLayoutConstraints(item: toggleViewController.view, toItem: trackQueueView)
            toggleViewController.view.frame = trackQueueView.bounds
            
            stackZoom.isHidden = false
            barLineChartViewBase = candleStickChartView
            
        case .none:
            break
        }
    }
    
    func setUpLayoutConstraints(item : NSView, toItem: NSView)
    {
        item.translatesAutoresizingMaskIntoConstraints = false
        let sourceListLayoutConstraints = [
            NSLayoutConstraint(item: item, attribute: .left, relatedBy: .equal, toItem: toItem, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: item, attribute: .right, relatedBy: .equal, toItem: toItem, attribute: .right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: item, attribute: .top, relatedBy: .equal, toItem: toItem, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: item, attribute: .bottom, relatedBy: .equal, toItem: toItem, attribute: .bottom, multiplier: 1, constant: 0)]
        NSLayoutConstraint.activate(sourceListLayoutConstraints)
    }
    
    func setUpCollectionController()
    {
        imageInfo.removeAll()
        imageInfo.append(ImageInfo(thumbnail: radarChartViewController.view.image(), nameController: "RadarChartViewController", name: "Radar Chart", type: .radar))
        imageInfo.append(ImageInfo(thumbnail: barChartViewControllerColumnWithDrilldown.view.image(), nameController: "BarChartViewControllerColumnWithDrilldown", name: "Bar Chart with DrillDown", type: .bar))
        imageInfo.append(ImageInfo(thumbnail: barChartViewController.view.image(), nameController: "BarChartViewController", name: "Bar Chart", type: .bar))
        imageInfo.append(ImageInfo(thumbnail: positiveNegativeBarChartViewController.view.image(), nameController: "PositiveNegativeBarChartViewController", name: "Positive Negative Bar Chart", type: .bar))
        imageInfo.append(ImageInfo(thumbnail: multipleBarChartViewController.view.image(), nameController: "MultipleBarChartViewController", name: "Multiple Bar Chart", type: .bar))
        imageInfo.append(ImageInfo(thumbnail: negativeStackedBarChartViewController.view.image(), nameController: "NegativeStackedBarChartViewController", name: "Negative Stacked Bar Chart", type: .bar))
        imageInfo.append(ImageInfo(thumbnail: horizontalBarChartViewController.view.image(), nameController: "HorizontalBarChartViewController", name: "Horizontal Bar Chart", type: .bar))
        imageInfo.append(ImageInfo(thumbnail: sinusBarChartViewController.view.image(), nameController: "SinusBarChartViewController", name: "Sinus Bar Chart", type: .bar))
        imageInfo.append(ImageInfo(thumbnail: stackedBarChartViewController.view.image(), nameController: "StackedBarChartViewController", name: "Stacked Bar Chart", type: .bar))
        imageInfo.append(ImageInfo(thumbnail: bubbleChartViewController.view.image(), nameController: "BubbleChartViewController", name: "Bubble Chart", type: .bubble))
        imageInfo.append(ImageInfo(thumbnail: candleStickChartViewController.view.image(), nameController: "CandleStickChartViewController", name: "CandleStick Chart", type: .candleStick))
        imageInfo.append(ImageInfo(thumbnail: coloredLineChartViewController.view.image(), nameController: "ColoredLineChartViewController", name: "Colored Line Chart", type: .line))
        imageInfo.append(ImageInfo(thumbnail: cubicLineChartViewController.view.image(), nameController: "CubicLineChartViewController", name: "Cubic Line Chart", type: .line))
        imageInfo.append(ImageInfo(thumbnail: lineChart1ViewController.view.image(), nameController: "LineChart1ViewController", name: "Line Chart1", type: .line))
        imageInfo.append(ImageInfo(thumbnail: lineChart2ViewController.view.image(), nameController: "LineChart2ViewController", name: "Line Chart2", type: .line))
        imageInfo.append(ImageInfo(thumbnail: lineChartFilledViewController.view.image(), nameController: "LineChartFilledViewController", name: "Line Chart Filled", type: .line))
        imageInfo.append(ImageInfo(thumbnail: lineChartTimeViewController.view.image(), nameController: "LineChartTimeViewController", name: "Line Chart Time", type: .line))
        imageInfo.append(ImageInfo(thumbnail: combinedChartViewController.view.image(), nameController: "CombinedChartViewController", name: "Combined Chart", type: .combined))
        imageInfo.append(ImageInfo(thumbnail: halfPieChartViewController.view.image(), nameController: "HalfPieChartViewController", name: "Half Pie Chart", type: .pie))
        imageInfo.append(ImageInfo(thumbnail: pieChartViewController.view.image(), nameController: "PieChartViewController", name: "Pie Chart", type: .pie))
        imageInfo.append(ImageInfo(thumbnail: piePolylineChartViewController.view.image(), nameController: "PiePolylineChartViewController", name: "Pie Polyline Chart", type: .pie))
        imageInfo.append(ImageInfo(thumbnail: scatterChartViewController.view.image(), nameController: "ScatterChartViewController", name: "Scatter Chart", type: .scatter))
        imageInfo.append(ImageInfo(thumbnail: lineChartRealTimeViewController.view.image(), nameController: "LineChartRealTimeViewController", name: "Line Real Time Chart", type: .line))
        
        // not very good the sort
        imageInfo = imageInfo.sorted (by: { $0.name < $1.name })
        imageInfo = imageInfo.sorted (by: { $0.type.label < $1.type.label })
    }
    
    func setUpSourceList()
    {
        if collection == NSOnState
        {
            addSubview(subView: (sourceCollectionController?.view)!, toView: sourceListTargetView1)
            
            setUpLayoutConstraints(item: sourceCollectionController!.view, toItem: sourceListTargetView1)
            self.sourceCollectionController!.view.frame = sourceListTargetView1.bounds
            
            setUpCollectionController()
            
            sourceCollectionController?.registerPlotItem(imageInfo: imageInfo)
            sourceCollectionController?.collectionView.reloadData()
        }
        else
        {
            addSubview(subView: (sourceListViewController?.view)!, toView: sourceListTargetView1)
            
            setUpLayoutConstraints(item: sourceListViewController!.view, toItem: sourceListTargetView1)
            self.sourceListViewController!.view.frame = sourceListTargetView1.bounds
        }
    }
    
    func setUpAlbumArt()
    {
        self.albumArtViewController = AlbumArtViewController()
        addSubview(subView: (albumArtViewController?.view)!, toView: albumArtView)
        
        albumArtView.translatesAutoresizingMaskIntoConstraints = true
        setUpLayoutConstraints(item: albumArtViewController!.view, toItem: albumArtView)
        self.albumArtViewController!.view.frame = albumArtView.bounds
        albumArtViewController?.mainWindowController = self
        albumArtViewController?.loadAlbumArtWindow()
        
        UserDefaults.standard.set(false, forKey: "showsArtwork")
        self.albumArtView.isHidden = true
    }
    
    func addSubview(subView:NSView, toView parentView : NSView)
    {
        let myView = parentView.subviews
        if myView.count > 0
        {
            parentView.replaceSubview(myView[0], with: subView)
            print("replace View : ", subView)
        }
        else
        {
            parentView.addSubview(subView)
            print("add View : ", subView)
        }
    }
    
    @IBAction func toggleArtwork(_ sender: AnyObject) {
        if self.albumArtView.isHidden == false {
            artToggle.state = NSOffState
            UserDefaults.standard.set(false, forKey: "showsArtwork")
            self.albumArtView.isHidden = true
        } else {
            artToggle.state = NSOnState
            UserDefaults.standard.set(true, forKey: "showsArtwork")
            self.albumArtView.isHidden = false
        }
    }
    
    //track queue, source logic
    @IBAction func toggleExpandQueue(_ sender: AnyObject) {
        switch queueButton.state {
        case NSOnState, NSMixedState:
            trackQueueView.isHidden = false
            UserDefaults.standard.set(false, forKey: "queueHidden")
        case NSOffState:
            trackQueueView.isHidden = true
            UserDefaults.standard.set(true, forKey: "queueHidden")
        default:
            break
        }
    }
    
    @IBAction func toggleCollection(_ sender: Any) {
        
        collection = collectionButton.state
        setUpSourceList()
    }
    
    @IBAction func zoomAll(_ sender: AnyObject)
    {
        barLineChartViewBase?.fitScreen()
        barLineChartViewBase?.data?.notifyDataChanged()
        barLineChartViewBase?.notifyDataSetChanged()
    }
    
    @IBAction func zoomIn(_ sender: AnyObject)
    {
        barLineChartViewBase?.zoomToCenter(scaleX: 1.5, scaleY: 1.5) //, x: view.frame.width, y: 0)
        barLineChartViewBase?.data?.notifyDataChanged()
        barLineChartViewBase?.notifyDataSetChanged()
    }
    
    @IBAction func zoomOut(_ sender: AnyObject)
    {
        barLineChartViewBase?.zoomToCenter(scaleX: 2/3, scaleY: 2/3)
        barLineChartViewBase?.data?.notifyDataChanged()
        barLineChartViewBase?.notifyDataSetChanged()
    }
    

}

// just for the debug
extension NSView {
    
    override open var description: String {
        let id = identifier //?? ""
        return "id: \(String(describing: id))"
    }
}

