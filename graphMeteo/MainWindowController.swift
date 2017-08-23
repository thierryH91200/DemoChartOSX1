//
//  MainWindowController.swift
//  graphMeteo
//
//  Created by thierryH24100 on 22/08/2017.
//  Copyright © 2017 thierryH24100. All rights reserved.
//

import Cocoa
import Charts

let DEFAULTS_SHOWS_ARTWORK_STRING = "showsArtwork"

enum TypeOfChart {
    case Line
    case Pie
    case Radar
    case Combined
    case Bar
    case Bubble
    case Scatter
    case CandleStick
    case None
}

struct imageInfo {
    var thumbnail: NSImage?
    var fileName: String
}

class MainWindowController: NSWindowController , NSWindowDelegate {
    
    
    @IBOutlet weak var chartTargetView: NSView!
    @IBOutlet weak var sourceListTargetView1: NSView!
    @IBOutlet weak var trackQueueView: NSView!
    @IBOutlet weak var albumArtView : NSView!
    
    @IBOutlet weak var artToggle: NSButton!
    @IBOutlet weak var queueButton: NSButton!
    
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
    
    var barChartView                    : BarChartView?
    var bubbleChartView                 : BubbleChartView?
    var candleStickChartView            : CandleStickChartView?
    var combinedChartView               : CombinedChartView?
    var lineChartView                   : LineChartView?
    var pieChartView                    : PieChartView?
    var radarChartView                  : RadarChartView?
    var scatterChartView                : ScatterChartView?
    
    var collection : NSControlStateValue = NSOffState
    
    var typeOfChart : TypeOfChart = .None
    
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
    
    func changeView(name: String, id : String)
    {
        var  vc = NSView()
        
        switch name
        {
        case "BarChartViewController":
            vc = barChartViewController.view
            barChartView = barChartViewController.chartView
            typeOfChart = .Bar
            
        case "BarChartViewControllerColumnWithDrilldown":
            vc = barChartViewControllerColumnWithDrilldown.view
            barChartView = barChartViewControllerColumnWithDrilldown.chartView
            typeOfChart = .Bar
            
        case "PositiveNegativeBarChartViewController":
            vc = positiveNegativeBarChartViewController.view
            barChartView = positiveNegativeBarChartViewController.chartView
            typeOfChart = .Bar
            
        case "MultipleBarChartViewController":
            vc = multipleBarChartViewController.view
            barChartView = multipleBarChartViewController.chartView
            typeOfChart = .Bar
            
        case "NegativeStackedBarChartViewController":
            vc = negativeStackedBarChartViewController.view
            barChartView = negativeStackedBarChartViewController.chartView
            typeOfChart = .Bar
            
        case "HorizontalBarChartViewController":
            vc = horizontalBarChartViewController.view
            barChartView = horizontalBarChartViewController.chartView
            typeOfChart = .Bar
            
        case "SinusBarChartViewController":
            vc = sinusBarChartViewController.view
            barChartView = sinusBarChartViewController.chartView
            typeOfChart = .Bar
            
        case "StackedBarChartViewController":
            vc = stackedBarChartViewController.view
            barChartView = stackedBarChartViewController.chartView
            typeOfChart = .Bar
            
        case "BubbleChartViewController":
            vc = bubbleChartViewController.view
            bubbleChartView = bubbleChartViewController.chartView
            typeOfChart = .Bubble
            
        case "CandleStickChartViewController":
            vc = candleStickChartViewController.view
            candleStickChartView = candleStickChartViewController.chartView
            typeOfChart = .CandleStick
            
        case "ColoredLineChartViewController":
            vc = coloredLineChartViewController.view
            //lineChartView = coloredLineChartViewController.chartView
            typeOfChart = .Line
            
        case "CubicLineChartViewController":
            vc = cubicLineChartViewController.view
            lineChartView = cubicLineChartViewController.chartView
            typeOfChart = .Line
            
        case "LineChart1ViewController":
            vc = lineChart1ViewController.view
            lineChartView = lineChart1ViewController.chartView
            typeOfChart = .Line
            
        case "LineChart2ViewController":
            vc = lineChart2ViewController.view
            lineChartView = lineChart2ViewController.chartView
            typeOfChart = .Line
            
        case "LineChartFilledViewController":
            vc = lineChartFilledViewController.view
            lineChartView = lineChartFilledViewController.chartView
            typeOfChart = .Line
            
        case "LineChartTimeViewController":
            vc = lineChartTimeViewController.view
            lineChartView = lineChartTimeViewController.chartView
            typeOfChart = .Line
            
        case "CombinedChartViewController":
            vc = combinedChartViewController.view
            combinedChartView = combinedChartViewController.chartView
            typeOfChart = .Combined
            
        case "HalfPieChartViewController":
            vc = halfPieChartViewController.view
            pieChartView = halfPieChartViewController.chartView
            typeOfChart = .Pie
            
        case "PieChartViewController":
            vc = pieChartViewController.view
            pieChartView = pieChartViewController.chartView
            typeOfChart = .Pie
            
        case "PiePolylineChartViewController":
            vc = piePolylineChartViewController.view
            pieChartView = piePolylineChartViewController.chartView
            typeOfChart = .Pie
            
        case "RadarChartViewController":
            vc = radarChartViewController.view
            radarChartView = radarChartViewController.chartView
            typeOfChart = .Radar
            
        case "ScatterChartViewController":
            vc = scatterChartViewController.view
            scatterChartView = scatterChartViewController.chartView
            typeOfChart = .Scatter
            
        default:
            vc = barChartViewController.view
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
        switch typeOfChart
        {
        case .Line:
            let toggleViewController = self.toggleLineViewController
            
            toggleViewController.chartView = lineChartView
            addSubview(subView: toggleViewController.view, toView: self.trackQueueView)
            setUpLayoutConstraints(item: toggleViewController.view, toItem: trackQueueView)
            toggleViewController.view.frame = trackQueueView.bounds
            
        case .Pie:
            let toggleViewController = self.togglePieViewController
            
            toggleViewController.chartView = pieChartView
            addSubview(subView: toggleViewController.view, toView: self.trackQueueView)
            setUpLayoutConstraints(item: toggleViewController.view, toItem: trackQueueView)
            toggleViewController.view.frame = trackQueueView.bounds
            
        case .Radar:
            let toggleViewController = self.toggleRadarViewController
            
            toggleViewController.chartView = radarChartView
            addSubview(subView: toggleViewController.view, toView: self.trackQueueView)
            setUpLayoutConstraints(item: toggleViewController.view, toItem: trackQueueView)
            toggleViewController.view.frame = trackQueueView.bounds
            
        case .Combined:
            let toggleViewController = self.toggleCombinedViewController
            
            toggleViewController.chartView = combinedChartView
            addSubview(subView: toggleViewController.view, toView: self.trackQueueView)
            setUpLayoutConstraints(item: toggleViewController.view, toItem: trackQueueView)
            toggleViewController.view.frame = trackQueueView.bounds
            
        case .Bar:
            let toggleViewController = self.toggleBarViewController
            
            toggleViewController.chartView = barChartView
            addSubview(subView: toggleViewController.view, toView: self.trackQueueView)
            setUpLayoutConstraints(item: toggleViewController.view, toItem: trackQueueView)
            toggleViewController.view.frame = trackQueueView.bounds
            
        case .Bubble:
            let toggleViewController = self.toggleBubbleViewController
            
            toggleViewController.chartView = bubbleChartView
            addSubview(subView: toggleViewController.view, toView: self.trackQueueView)
            setUpLayoutConstraints(item: toggleViewController.view, toItem: trackQueueView)
            toggleViewController.view.frame = trackQueueView.bounds
            
        case .Scatter:
            let toggleViewController = self.toggleScatterViewController
            
            toggleViewController.chartView = scatterChartView
            addSubview(subView: toggleViewController.view, toView: self.trackQueueView)
            setUpLayoutConstraints(item: toggleViewController.view, toItem: trackQueueView)
            toggleViewController.view.frame = trackQueueView.bounds
            
        case .CandleStick:
            let toggleViewController = self.toggleCandleStickViewController
            
            toggleViewController.chartView = candleStickChartView
            addSubview(subView: toggleViewController.view, toView: self.trackQueueView)
            setUpLayoutConstraints(item: toggleViewController.view, toItem: trackQueueView)
            toggleViewController.view.frame = trackQueueView.bounds
            
        case .None:
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
    
    
    func setUpSourceList()
    {
        if collection == NSOnState
        {
            addSubview(subView: (sourceCollectionController?.view)!, toView: sourceListTargetView1)
            
            setUpLayoutConstraints(item: sourceCollectionController!.view, toItem: sourceListTargetView1)
            self.sourceCollectionController!.view.frame = sourceListTargetView1.bounds
            
//            sourceCollectionController?.registerPlotItem(thumbnail: radarChartViewController.view.image(), fileName: "radarChartViewController")
//            sourceCollectionController?.registerPlotItem(thumbnail: pieChartViewController.view.image(), fileName: "pieChartViewController")
//            sourceCollectionController?.registerPlotItem(thumbnail: halfPieChartViewController.view.image(), fileName: "halfPieChartViewController")
//
//            sourceCollectionController?.registerPlotItem(thumbnail: radarChartViewController.view.image(), fileName: "radarChartViewController")
//            sourceCollectionController?.registerPlotItem(thumbnail: pieChartViewController.view.image(), fileName: "pieChartViewController")
//            sourceCollectionController?.registerPlotItem(thumbnail: halfPieChartViewController.view.image(), fileName: "halfPieChartViewController")
//
//            sourceCollectionController?.registerPlotItem(thumbnail: radarChartViewController.view.image(), fileName: "radarChartViewController")
//            sourceCollectionController?.registerPlotItem(thumbnail: pieChartViewController.view.image(), fileName: "pieChartViewController")
//            sourceCollectionController?.registerPlotItem(thumbnail: halfPieChartViewController.view.image(), fileName: "halfPieChartViewController")
//
//            sourceCollectionController?.registerPlotItem(thumbnail: radarChartViewController.view.image(), fileName: "radarChartViewController")
//            sourceCollectionController?.registerPlotItem(thumbnail: pieChartViewController.view.image(), fileName: "pieChartViewController")
//            sourceCollectionController?.registerPlotItem(thumbnail: halfPieChartViewController.view.image(), fileName: "halfPieChartViewController")
//
//            sourceCollectionController?.collectionView.reloadData()
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
            UserDefaults.standard.set(false, forKey: DEFAULTS_SHOWS_ARTWORK_STRING)
            self.albumArtView.isHidden = true
        } else {
            artToggle.state = NSOnState
            UserDefaults.standard.set(true, forKey: DEFAULTS_SHOWS_ARTWORK_STRING)
            self.albumArtView.isHidden = false
        }
    }
    
    //track queue, source logic
    @IBAction func toggleExpandQueue(_ sender: AnyObject) {
        //trackQueueViewController!.toggleHidden(queueButton.state)
        switch queueButton.state {
        case NSOnState:
            trackQueueView.isHidden = false
            UserDefaults.standard.set(false, forKey: "queueHidden")
        default:
            trackQueueView.isHidden = true
            UserDefaults.standard.set(true, forKey: "queueHidden")
        }
    }

}

extension NSView {
    
    override open var description: String {
        let id = identifier //?? ""
        return "id: \(String(describing: id))" //\(self.description)" //you may print whatever you want here
    }
}

