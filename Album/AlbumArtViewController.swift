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
    
    
    var mainWindowController: MainWindowController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        outlineButton.state = NSOnState
    }
    
    func loadAlbumArtWindow() {
        print("loading album art window")
        //        self.artWindow = AlbumArtWindowController(windowNibName: "AlbumArtWindowController")
        //        self.artWindow?.track = self.currentTrack
        //        self.mainWindow?.window?.addChildWindow(self.artWindow!.window!, ordered: .above)
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
