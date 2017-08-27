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

struct ImageInfo
{
    fileprivate(set) var thumbnail: NSImage?
    fileprivate(set) var nameController: String
    fileprivate(set) var name: String
    fileprivate(set) var type : TypeOfChart
    
    init(thumbnail : NSImage, nameController: String, name: String, type: TypeOfChart )
    {
        self.thumbnail = thumbnail
        self.nameController = nameController
        self.name = name
        self.type = type
    }
}

