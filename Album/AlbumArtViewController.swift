//
//  AlbumArtViewController.swift
//  minimalTunes
//
//  Created by John Moody on 12/1/16.
//  Copyright © 2016 John Moody. All rights reserved.
//

import Cocoa

class AlbumArtViewController: NSViewController {
    
    @IBOutlet var albumArtBox: NSBox!
    // @IBOutlet weak var albumArtView: DragAndDropImageView!
    
    @IBOutlet weak var collectionButton: NSButton!
    @IBOutlet weak var outlineButton: NSButton!
    
    @IBOutlet weak var imageView: NSImageView!
    
    var mainWindowController: MainWindowController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        outlineButton.state = NSOnState
        //loadAlbumArtWindow()
    }
    
    func loadAlbumArtWindow() {
        print("loading album art window")
        let image = mainWindowController?.radarChartViewController.view.image()
        imageView.image = image
    }
    
    func toggleHidden(_ artworkToggle: Int)
    {
        if artworkToggle == 1 {
            albumArtBox.isHidden = false
        }
        else
        {
            albumArtBox.isHidden = true
        }
    }
    
    @IBAction func radioButtonChanged(_ sender: AnyObject) {
        mainWindowController?.collection = collectionButton.state
        mainWindowController?.setUpSourceList()
    }
}

extension NSView {
    
    /// Get `NSImage` representation of the view.
    ///
    /// - Returns: `NSImage` of view
    func image() -> NSImage {
        let imageRepresentation = bitmapImageRepForCachingDisplay(in: bounds)!
        cacheDisplay(in: bounds, to: imageRepresentation)
        return NSImage(cgImage: imageRepresentation.cgImage!, size: bounds.size)
    }
}
