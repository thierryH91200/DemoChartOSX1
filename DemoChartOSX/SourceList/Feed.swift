//
//  Feed.swift
//  ChartsDemo-OSX
//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  Copyright © 2017 thierry Hentic.
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/ios-charts

import Cocoa

class Feed: NSObject
{
    let name: String
    let isSourceGroup :Bool
    var children = [FeedItem]()
    
    class func feedList(_ fileName: String) -> [Feed]
    {
        var feeds = [Feed]()
        
        if let feedList = NSArray(contentsOfFile: fileName) as? [NSDictionary]
        {
            for feedItems in feedList
            {
                let feed = Feed(name: feedItems.object(forKey: "name") as! String, isSourceGroup: feedItems.object(forKey: "isSourceGroup") as! Bool)
                let items = feedItems.object(forKey: "items") as! [NSDictionary]
                
                for dict in items
                {
                    let item = FeedItem(dictionary: dict)
                    feed.children.append(item)
                }
                feed.children.sort { $0.type < $1.type }
                feeds.append(feed)
            }
        }
        feeds.sort { $0.name < $1.name }
        return feeds
    }
    
    init(name: String, isSourceGroup: Bool) {
        self.name = name
        self.isSourceGroup = isSourceGroup
    }
}


//class Tests {
//    static func runTests() {
//        measure("class (1 field)") {
//            var x = IntClass(0)
//            for i in 1...10000000 {
//                x = x + IntClass(i)
//            }
//        }
//        
//        measure("struct (1 field)") {
//            var x = IntStruct(0)
//            for i in 1...10000000 {
//                x = x + IntStruct(i)
//            }
//        }
//        
//        measure("class (10 fields)") {
//            var x = Int10Class(0)
//            for i in 1...10000000 {
//                x = x + Int10Class(i)
//            }
//        }
//        
//        measure("struct (10 fields)") {
//            var x = Int10Struct(0)
//            for i in 1...10000000 {
//                x = x + Int10Struct(i)
//            }
//        }
//    }
//    
//    static fileprivate func measure(_ name: String, block: () -> ()) {
//        let t0 = CACurrentMediaTime()
//        
//        block()
//        
//        let dt = CACurrentMediaTime() - t0
//        print("\(name) -> \(dt)")
//    }
//}
//
//
//
//
//// 1 field
//class IntClass {
//    var value: Int
//    init(_ val: Int) { self.value = val }
//}
//
//struct IntStruct {
//    var value: Int
//    init(_ val: Int) { self.value = val }
//}
//
//func + (x: IntClass, y: IntClass) -> IntClass {
//    return IntClass(x.value + y.value)
//}
//
//func + (x: IntStruct, y: IntStruct) -> IntStruct {
//    return IntStruct(x.value + y.value)
//}
//
//// 10 fields
//class Int10Class {
//    var value1, value2, value3, value4, value5, value6, value7, value8, value9, value10: Int
//    
//    init(_ val: Int) {
//        self.value1 = val
//        self.value2 = val
//        self.value3 = val
//        self.value4 = val
//        self.value5 = val
//        self.value6 = val
//        self.value7 = val
//        self.value8 = val
//        self.value9 = val
//        self.value10 = val
//    }
//}
//
//struct Int10Struct {
//    var value1, value2, value3, value4, value5, value6, value7, value8, value9, value10: Int
//    
//    init(_ val: Int) {
//        self.value1 = val
//        self.value2 = val
//        self.value3 = val
//        self.value4 = val
//        self.value5 = val
//        self.value6 = val
//        self.value7 = val
//        self.value8 = val
//        self.value9 = val
//        self.value10 = val
//    }
//}
//
//func + (x: Int10Struct, y: Int10Struct) -> Int10Struct {
//    return Int10Struct(x.value1 + y.value1)
//}
//
//func + (x: Int10Class, y: Int10Class) -> Int10Class {
//    return Int10Class(x.value1 + y.value1)
//}
