//
//  FlagDataSource.swift
//  SailingFlags
//
//  Created by Bryan Gough on 2017-04-15.
//  Copyright © 2017 Bryan Gough. All rights reserved.
//

import UIKit

class FlagDataSource: NSObject, UICollectionViewDataSource {
    
    var flags = [Flag]()
    var allFlags = [Flag]()
    var searchFlags = [Flag]()
    override init()
    {
        super.init()
        allFlags.append(Flag(title: "A", photoID: "A", image:"Flag_A"))
        allFlags.append(Flag(title: "B", photoID: "B", image:"Flag_B"))
        allFlags.append(Flag(title: "C", photoID: "C", image:"Flag_C"))
        allFlags.append(Flag(title: "D", photoID: "D", image:"Flag_D"))
        allFlags.append(Flag(title: "E", photoID: "E", image:"Flag_E"))
        allFlags.append(Flag(title: "F", photoID: "F", image:"Flag_F"))
        allFlags.append(Flag(title: "G", photoID: "G", image:"Flag_G"))
        allFlags.append(Flag(title: "H", photoID: "H", image:"Flag_H"))
        
        flags = allFlags;
        
    }
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return flags.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier = "FlagCollectionViewCell"
        let cell =
            collectionView.dequeueReusableCell(withReuseIdentifier: identifier,
                                               for: indexPath)
        
        return cell
    }
    
    func search(value:String){
        if value.isEmpty
        {
            flags = allFlags;
            return;
        }
        searchFlags = flags.filter { (flag:Flag) -> Bool in
            return flag.flagID.contains(value)
        }
        flags = searchFlags
    }
}

