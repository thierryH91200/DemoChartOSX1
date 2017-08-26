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
    
    var mainWindowController: MainWindowController?
    
    fileprivate var imageInfos = [ImageInfo]()
    fileprivate(set) var numberOfSections = 1
    var singleSectionMode = false
    
    fileprivate struct SectionAttributes {
        var sectionOffset: Int  // the index of the first image of this section in the imageFiles array
        var sectionLength: Int  // number of images in the section
        var sectionName  : String
    }
    
    // sectionLengthArray - An array of picked integers.
    // sectionLengthArray[0] is 8, i.e. put the first 7 images from the imageFiles array into section 0
    // sectionLengthArray[1] is 1, i.e. put the next 5 images from the imageFiles array into section 1
    // and so on...
    fileprivate var sectionLengthArray = [8, 1, 1, 1, 6, 3, 1, 1, 1, 25, 10, 3, 30, 25, 40]
    fileprivate var sectionsAttributesArray = [SectionAttributes]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        configureCollectionView()
    }
    
    func registerPlotItem( imageInfo : [ImageInfo])
    {
        if imageInfos.count > 0 {   // When not initial folder
            imageInfos.removeAll()
        }
        
        imageInfos = imageInfo
        setupData()
    }
    
    fileprivate func configureCollectionView() {
        let flowLayout = NSCollectionViewFlowLayout()
        flowLayout.itemSize = NSSize(width: 140.0, height: 120.0)
        flowLayout.sectionInset = EdgeInsets(top: 30.0, left: 20.0, bottom: 30.0, right: 20.0)
        flowLayout.minimumInteritemSpacing = 5.0
        flowLayout.minimumLineSpacing = 5.0
        flowLayout.sectionHeadersPinToVisibleBounds = true
        collectionView.collectionViewLayout = flowLayout
        view.wantsLayer = true
        collectionView.layer?.backgroundColor = NSColor.black.cgColor
        print("flowLayout ", flowLayout)
    }
    
    func setupData()
    {
        if sectionsAttributesArray.count > 0 {  // If not first time, clean old sectionsAttributesArray
            sectionsAttributesArray.removeAll()
        }
        
        numberOfSections = 1
        
        if singleSectionMode {
            setupDataForSingleSectionMode()
        } else {
            setupDataForMultiSectionMode()
        }
    }
    
    fileprivate func setupDataForSingleSectionMode() {
        let sectionAttributes = SectionAttributes(sectionOffset: 0, sectionLength: imageInfos.count, sectionName: "")
        sectionsAttributesArray.append(sectionAttributes) // sets up attributes for first section
    }
    
    fileprivate func setupDataForMultiSectionMode() {
        
        let haveOneSection = singleSectionMode || sectionLengthArray.count < 2 || imageInfos.count <= sectionLengthArray[0]
        var realSectionLength = haveOneSection ? imageInfos.count : sectionLengthArray[0]
        var sectionAttributes = SectionAttributes(sectionOffset: 0, sectionLength: realSectionLength, sectionName: imageInfos[0].type.label)
        sectionsAttributesArray.append(sectionAttributes) // sets up attributes for first section
        
        guard !haveOneSection else {return}

        let arrayFromDic = Array(imageInfos.map{ $0.type.label })
        
        var counts: [String: Int] = [:]
        for item in arrayFromDic {
            counts[item] = (counts[item] ?? 0) + 1
        }
        let countsSorted = counts.sorted(by: { $0.0 < $1.0 })
        sectionLengthArray.removeAll()
        
        for countSorted in countsSorted
        {
            sectionLengthArray.append(countSorted.value)
        }
        
        var offset: Int
        var nextOffset: Int
        let maxNumberOfSections = sectionLengthArray.count
        for i in 1..<maxNumberOfSections {
            numberOfSections += 1
            offset = sectionsAttributesArray[i-1].sectionOffset + sectionsAttributesArray[i-1].sectionLength
            nextOffset = offset + sectionLengthArray[i]
            if imageInfos.count <= nextOffset {
                realSectionLength = imageInfos.count - offset
                nextOffset = -1 // signal this is last section for this collection
            } else {
                realSectionLength = sectionLengthArray[i]
            }
            let sectionName = imageInfos[offset].type.label
            sectionAttributes = SectionAttributes(sectionOffset: offset, sectionLength: realSectionLength, sectionName: sectionName)
            sectionsAttributesArray.append(sectionAttributes)
            if nextOffset < 0 {
                break
            }
        }
    }
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        print("sectionsAttributesArray[section].sectionLength ", sectionsAttributesArray[section].sectionLength)
        return sectionsAttributesArray[section].sectionLength
    }
    
    func imageFileForIndexPath(_ indexPath: IndexPath) -> ImageInfo {
        let imageIndexInImageFiles = sectionsAttributesArray[indexPath.section].sectionOffset + indexPath.item
        let imageInfo = imageInfos[imageIndexInImageFiles]
        return imageInfo
    }
    
    @IBAction func showHideSections(_ sender: NSButton) {
        let show = sender.state
        singleSectionMode = (show == NSOffState)
        setupData()
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
        print(item)
        
        let nameController = (item as! CollectionViewItem).imageInfo?.nameController
        
        let array = Array(indexPaths)
        print("Allows multiple selection:", collectionView.allowsMultipleSelection)
        print("Number of selected items:", collectionView.selectionIndexPaths.count)
        print(indexPaths)
        print(array[0])
        print("")
        mainWindowController?.changeView(name: nameController!)
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
        return numberOfSections
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        print ("numberOfItemsInSection : ", numberOfItemsInSection(section))
        return numberOfItemsInSection(section)
    }
    
    func collectionView(_ itemForRepresentedObjectAtcollectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        let item = collectionView.makeItem(withIdentifier: "CollectionViewItem", for: indexPath)
        guard let collectionViewItem = item as? CollectionViewItem else {return item}
        
        let imageInfo = imageFileForIndexPath(indexPath)
        collectionViewItem.imageInfo = imageInfo
        
        return item
    }
    
    func collectionView(_ collectionView: NSCollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> NSView {
        let view = collectionView.makeSupplementaryView(ofKind: NSCollectionElementKindSectionHeader, withIdentifier: "HeaderView", for: indexPath) as! HeaderView
        view.sectionTitle.stringValue = "\(sectionsAttributesArray[indexPath.section].sectionName)"
        let nbOfItemsInSection = self.numberOfItemsInSection(indexPath.section)
        view.imageCount.stringValue = "\(nbOfItemsInSection) chart(s)"
        return view
    }
}

extension SourceCollectionController : NSCollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> NSSize {
        return singleSectionMode ? NSZeroSize : NSSize(width: 1000, height: 40)
    }
}

