//
//  ImageInfo.swift
//  DemoChartOSX
//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  Copyright © 2017 thierry Hentic.
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/ios-charts

import Cocoa

class HeaderView: NSView {
    
    @IBOutlet weak var sectionTitle: NSTextField!
    @IBOutlet weak var imageCount: NSTextField!
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        NSColor(calibratedWhite: 0.8 , alpha: 0.8).set()
        NSRectFillUsingOperation(dirtyRect, NSCompositingOperation.sourceOver)
    }
}
