//
//  SourceCollectionController
//  DemoChartOSX
//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  Copyright © 2017 thierry Hentic.
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/ios-charts



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
    fileprivate var sectionLengthArray = [Int]()
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

        
        let haveOneSection = singleSectionMode || sectionLengthArray.count < 2 || imageInfos.count <= sectionLengthArray[0]
        var realSectionLength = haveOneSection ? imageInfos.count : sectionLengthArray[0]
        var sectionAttributes = SectionAttributes(sectionOffset: 0, sectionLength: realSectionLength, sectionName: imageInfos[0].type.label)
        sectionsAttributesArray.append(sectionAttributes) // sets up attributes for first section
        
        guard !haveOneSection else {return}

        
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

