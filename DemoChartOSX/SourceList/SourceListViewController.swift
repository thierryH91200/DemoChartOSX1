//
//  TrackQueueViewController.swift
//  minimalTunes
//
//  Created by John Moody on 12/1/16.
//  Copyright © 2016 John Moody. All rights reserved.
//

import Cocoa

class SourceListViewController: NSViewController {
        
    var mainWindowController: MainWindowController?

    @IBOutlet weak var outlineView: NSOutlineView!
    
    var feeds = [Feed]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let filePath = Bundle.main.path(forResource: "Feeds", ofType: "plist")
        {
            feeds = Feed.feedList(filePath)
        }
    }
    
    override open func viewDidAppear()
    {
        super.viewDidAppear()
        
        outlineView.reloadData()
        
        outlineView.expandItem(nil, expandChildren: true)
        outlineView.selectionHighlightStyle = .sourceList
        outlineView.scrollRowToVisible(0)
        
        let array = [1]
        outlineView.selectRowIndexes(IndexSet(array), byExtendingSelection: false)
    }
    
    func toggleHidden(_ state: Int) {
        switch state {
        case 1:
            outlineView?.isHidden = false
        default:
            outlineView?.isHidden = true
        }
    }
}

extension SourceListViewController: NSOutlineViewDataSource
{
    //ok-------
    public func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int
    {
        if let feed = item as? Feed {
            return feed.children.count
        }
        //2
        return feeds.count
    }
    
    //ok--------------
    public func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any
    {
        if let feed = item as? Feed
        {
            return feed.children[index]
        }
        return feeds[index]
    }
    
    //ok---------------
    public func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool
    {
        if let feed = item as? Feed
        {
            return feed.children.count > 0
        }
        return false
    }
    
    
    //    Don't show the expander triangle for group items..
    // ok
    public func outlineView(_ outlineView: NSOutlineView, shouldShowOutlineCellForItem item: Any) -> Bool
    {
        return isSourceGroupItem(item)
    }
    
    // ok
    public func outlineView(_ outlineView: NSOutlineView, shouldSelectItem item: Any) -> Bool
    {
        return !self.isSourceGroupItem(item)
    }
    
    // ok
    public func outlineView(_ outlineView: NSOutlineView, isGroupItem item: Any) -> Bool
    {
        return isSourceGroupItem(item)
    }
    
    // ok
    public func outlineView(_ outlineView: NSOutlineView, heightOfRowByItem item: Any) -> CGFloat {
        //    Make the height of Source Group items a little higher
        if self.isSourceGroupItem(item) {
            return outlineView.rowHeight + 5.0
        }
        return outlineView.rowHeight
    }
    
    //    Method to determine if an outline item is a source group
    // ok
    func isSourceGroupItem(_ item: Any) -> Bool
    {
        if let feed = item as? Feed
        {
            return feed.isSourceGroup
        }
        return false
    }
}

extension SourceListViewController: NSOutlineViewDelegate
{
    public func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView?
    {
        var view: NSTableCellView?
        
        if let feed = item as? Feed
        {
            view = outlineView.make(withIdentifier: "FeedCell", owner: self) as? NSTableCellView
            if let textField = view?.textField
            {
                textField.stringValue = feed.name.uppercased()
                //                textField.font = NSFont.boldSystemFont(ofSize: 14.0)
                
            }
        }
        else
        {
            if let feedItem = item as? FeedItem
            {
                view = outlineView.make(withIdentifier: "FeedItemCell", owner: self) as? NSTableCellView
                if let textField = view?.textField
                {
                    textField.stringValue = feedItem.type
                    textField.textColor = NSColor.black
                }
            }
        }
        return view
    }
    
    //NSOutlineViewDelegate
    public func outlineViewSelectionDidChange(_ notification: Notification)
    {
        guard let outlineView = notification.object as? NSOutlineView else {
            return
        }
        
        let selectedIndex = outlineView.selectedRow
        
        if let feedItem = outlineView.item(atRow: selectedIndex) as? FeedItem
        {
            //3
            let name =  feedItem.name
            let id =  feedItem.id
            //4
            mainWindowController?.changeView(name: name, id: id)
        }
    }
}


