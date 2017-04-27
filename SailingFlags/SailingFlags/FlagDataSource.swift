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
    var flagLetters = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","0","1","2","3","4","5","6","7","8","9"]
    override init()
    {
        super.init()
        for letter in flagLetters
        {
            allFlags.append(Flag(title: letter, photoID: letter, image:("Flag_"+letter) ))
        }
        /*allFlags.append(Flag(title: "A", photoID: "A", image:"Flag_A"))
        allFlags.append(Flag(title: "B", photoID: "B", image:"Flag_B"))
        allFlags.append(Flag(title: "C", photoID: "C", image:"Flag_C"))
        allFlags.append(Flag(title: "D", photoID: "D", image:"Flag_D"))
        allFlags.append(Flag(title: "E", photoID: "E", image:"Flag_E"))
        allFlags.append(Flag(title: "F", photoID: "F", image:"Flag_F"))
        allFlags.append(Flag(title: "G", photoID: "G", image:"Flag_G"))
        allFlags.append(Flag(title: "H", photoID: "H", image:"Flag_H"))*/
        //allFlags.append(Flag(title: "", photoID: "", image:"Flag_"))
        
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

