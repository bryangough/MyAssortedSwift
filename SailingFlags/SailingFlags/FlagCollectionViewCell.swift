//
//  FlagCell.swift
//  SailingFlags
//
//  Created by Bryan Gough on 2017-04-15.
//  Copyright © 2017 Bryan Gough. All rights reserved.
//

import UIKit

class FlagCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var imageLabel: UILabel!

    func update(with image: UIImage?, flag:Flag) {
        if let imageToDisplay = image {
            imageView.image = imageToDisplay
            imageLabel.text = flag.title
        } else {
            imageView.image = nil
        }
    }
}
