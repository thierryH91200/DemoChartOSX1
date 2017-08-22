//
//  SourceCollectionController.swift
//  subView2
//
//  Created by thierryH24A on 16/08/2017.
//  Copyright © 2017 thierryH24A. All rights reserved.
//



import Cocoa

class SourceCollectionController: NSViewController {
    
    @IBOutlet weak var collectionView: NSCollectionView!
    
    let imageDirectoryLoader = ImageDirectoryLoader()
    var mainWindowController: MainWindowController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        let initialFolderUrl = URL(fileURLWithPath: "/Library/Desktop Pictures", isDirectory: true)
        imageDirectoryLoader.loadDataForFolderWithUrl(initialFolderUrl)
        configureCollectionView()
    }
    
    func loadDataForNewFolderWithUrl(_ folderURL: URL) {
        imageDirectoryLoader.loadDataForFolderWithUrl(folderURL)
        collectionView.reloadData()
    }
    
    fileprivate func configureCollectionView() {
        let flowLayout = NSCollectionViewFlowLayout()
        flowLayout.itemSize = NSSize(width: 120.0, height: 100.0)
        flowLayout.sectionInset = EdgeInsets(top: 30.0, left: 20.0, bottom: 30.0, right: 20.0)
        flowLayout.minimumInteritemSpacing = 20.0
        flowLayout.minimumLineSpacing = 20.0
        flowLayout.sectionHeadersPinToVisibleBounds = true
        collectionView.collectionViewLayout = flowLayout
        view.wantsLayer = true
        collectionView.layer?.backgroundColor = NSColor.black.cgColor
    }
    
    @IBAction func showHideSections(_ sender: NSButton) {
        let show = sender.state
        imageDirectoryLoader.singleSectionMode = (show == NSOffState)
        imageDirectoryLoader.setupDataForUrls(nil)
        collectionView.reloadData()
        
    }
}
extension SourceCollectionController : NSCollectionViewDelegate
{
    func collectionView (_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>)
    {
        guard let indexPath = indexPaths.first else {
            return
        }
        // 3
        guard let item = collectionView.item(at: indexPath) else {
            return
        }
        (item as! CollectionViewItem).setHighlight(selected: true)
        print(item.textField!.stringValue)
        
        let array = Array(indexPaths)
        print("Allows multiple selection:", collectionView.allowsMultipleSelection)
        print("Number of selected items:", collectionView.selectionIndexPaths.count)
        print(indexPaths)
        print(array[0])
        print("")
    }
}
extension SourceCollectionController : NSCollectionViewDataSource {
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return imageDirectoryLoader.numberOfSections
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageDirectoryLoader.numberOfItemsInSection(section)
    }
    
    func collectionView(_ itemForRepresentedObjectAtcollectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        let item = collectionView.makeItem(withIdentifier: "CollectionViewItem", for: indexPath)
        guard let collectionViewItem = item as? CollectionViewItem else {return item}
        
        let imageFile = imageDirectoryLoader.imageFileForIndexPath(indexPath)
        collectionViewItem.imageFile = imageFile
        
        return item
    }
    
    func collectionView(_ collectionView: NSCollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> NSView {
        let view = collectionView.makeSupplementaryView(ofKind: NSCollectionElementKindSectionHeader, withIdentifier: "HeaderView", for: indexPath) as! HeaderView
        view.sectionTitle.stringValue = "Section \(indexPath.section)"
        let numberOfItemsInSection = imageDirectoryLoader.numberOfItemsInSection(indexPath.section)
        view.imageCount.stringValue = "\(numberOfItemsInSection) image files"
        return view
    }
}

extension SourceCollectionController : NSCollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> NSSize {
        return imageDirectoryLoader.singleSectionMode ? NSZeroSize : NSSize(width: 1000, height: 40)
    }
}

