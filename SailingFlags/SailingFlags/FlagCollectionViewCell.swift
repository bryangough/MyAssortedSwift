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
    //@IBOutlet var spinner: UIActivityIndicatorView!
    
    func update(with image: UIImage?, flag:Flag) {
        if let imageToDisplay = image {
            //spinner.stopAnimating()
            imageView.image = imageToDisplay
            imageLabel.text = flag.title
        } else {
            //spinner.startAnimating()
            imageView.image = nil
        }
    }
    
    /*override func awakeFromNib() {
        super.awakeFromNib()
        
        update(with: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        update(with: nil)
    }*/
    
}
