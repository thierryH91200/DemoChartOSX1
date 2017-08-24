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
        
        imageDirectoryLoader.loadDataForFolderWithUrl()
        configureCollectionView()
    }
    
    func registerPlotItem(thumbnail : NSImage, fileName : String)
    {
        imageDirectoryLoader.createRegister(thumbnail: thumbnail, fileName: fileName)
        imageDirectoryLoader.loadDataForFolderWithUrl()
    }
        
    fileprivate func configureCollectionView() {
        let flowLayout = NSCollectionViewFlowLayout()
        flowLayout.itemSize = NSSize(width: 140.0, height: 120.0)
        flowLayout.sectionInset = EdgeInsets(top: 30.0, left: 20.0, bottom: 30.0, right: 20.0)
        flowLayout.minimumInteritemSpacing = 10.0
        flowLayout.minimumLineSpacing = 10.0
        flowLayout.sectionHeadersPinToVisibleBounds = true
        collectionView.collectionViewLayout = flowLayout
        view.wantsLayer = true
        collectionView.layer?.backgroundColor = NSColor.black.cgColor
        print("flowLayout ", flowLayout)
    }
    
    @IBAction func showHideSections(_ sender: NSButton) {
        let show = sender.state
        imageDirectoryLoader.singleSectionMode = (show == NSOffState)
        imageDirectoryLoader.setupData()
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
        let name = item.textField!.stringValue
        
        let array = Array(indexPaths)
        print("Allows multiple selection:", collectionView.allowsMultipleSelection)
        print("Number of selected items:", collectionView.selectionIndexPaths.count)
        print(indexPaths)
        print(array[0])
        print("")
        mainWindowController?.changeView(name: name, id: name)
    }
    
    func highlightItems( selected: Bool, atIndexPaths: Set<IndexPath>) {
        for indexPath in atIndexPaths {
            guard let item = collectionView.item(at: indexPath as IndexPath) else {continue}
            (item as! CollectionViewItem).setHighlight(selected: selected)
        }
//        addSlideButton.enabled = collectionView.selectionIndexPaths.count == 1
//        removeSlideButton.enabled = !collectionView.selectionIndexPaths.isEmpty
    }

}
extension SourceCollectionController : NSCollectionViewDataSource {
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return imageDirectoryLoader.numberOfSections
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        print ("numberOfItemsInSection : ", imageDirectoryLoader.numberOfItemsInSection(section))
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

