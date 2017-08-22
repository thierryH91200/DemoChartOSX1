//
//  AppDelegate.swift
//  graphMeteo
//
//  Created by thierryH24100 on 22/08/2017.
//  Copyright © 2017 thierryH24100. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var mainWindowController: MainWindowController?


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        initializeLibraryAndShowMainWindow()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    
    func applicationShouldTerminateAfterLastWindowClosed (_ sender: NSApplication) -> Bool
    {
        return true
    }

    func initializeLibraryAndShowMainWindow() {
        
        mainWindowController = MainWindowController(windowNibName: "MainWindowController")
        mainWindowController?.delegate = self
        mainWindowController?.showWindow(self)
    }

}

