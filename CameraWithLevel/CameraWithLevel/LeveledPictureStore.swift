//
//  LeveledPictureStore.swift
//  CameraWithLevel
//
//  Created by Bryan Gough on 2017-04-27.
//  Copyright © 2017 Bryan Gough. All rights reserved.
//

//
//  ItemStore.swift
//  Homepwner
//
//  Created by Bryan Gough on 2017-04-04.
//  Copyright © 2017 Bryan Gough. All rights reserved.
//

import UIKit

class LeveledPictureStore {
    
    var allLeveledPictures = [LeveledPicture]()
    
    
    let itemArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("items.archive")
    }()
    
    func saveChanges() -> Bool {
        print("Saving items to: \(itemArchiveURL.path)")
        return NSKeyedArchiver.archiveRootObject(allLeveledPictures, toFile: itemArchiveURL.path)
    }
    
    init()
    {
        if let archivedItems =
            NSKeyedUnarchiver.unarchiveObject(withFile: itemArchiveURL.path) as? [LeveledPicture] {
            allLeveledPictures = archivedItems
        }
    }
    @discardableResult func createItem() -> LeveledPicture {
        let newItem = LeveledPicture()
        
        //allLeveledPictures.append(newItem)
        allLeveledPictures.insert(newItem, at: allLeveledPictures.count)
        
        return newItem
    }
    func addItem(_ newItem: LeveledPicture) {
        allLeveledPictures.insert(newItem, at: allLeveledPictures.count)
    }
    func removeItem(_ item: LeveledPicture) {
        if let index = allLeveledPictures.index(of: item) {
            allLeveledPictures.remove(at: index)
        }
    }
    
    func moveItem(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        if(fromIndex==allLeveledPictures.count)
        {
            return;
        }
        
        // Get reference to object being moved so you can reinsert it
        let movedItem = allLeveledPictures[fromIndex]
        
        // Remove item from array
        allLeveledPictures.remove(at: fromIndex)
        
        // Insert item in array at new location
        allLeveledPictures.insert(movedItem, at: toIndex)
    }
    
    
}

