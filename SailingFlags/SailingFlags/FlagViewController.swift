//
//  FlagViewController.swift
//  SailingFlags
//
//  Created by Bryan Gough on 2017-04-15.
//  Copyright © 2017 Bryan Gough. All rights reserved.
//
import UIKit

class FlagViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    // @IBOutlet var imageView: UIImageView!
    @IBOutlet var collectionView: UICollectionView!
    
    
    let flagDataSource = FlagDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = flagDataSource
        collectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
        let flag = flagDataSource.flags[indexPath.row]
        if let cellFlag = cell as? FlagCollectionViewCell
        {
            cellFlag.update(with: UIImage(named:flag.image!), flag:flag)
        }
        
        /*if let cell = self.collectionView.cellForItem(at: indexPath) as? FlagCollectionViewCell {
            print(flag)
            cell.update(with: flag.image, flag:flag)
        }*/
        // Download the image data, which could take some time
        /*store.fetchImage(for: photo) { (result) -> Void in
            
            // The index path for the photo might have changed between the
            // time the request started and finished, so find the most
            // recent index path
            
            // (Note: You will have an error on the next line; you will fix it soon)
            guard let photoIndex = self.photoDataSource.photos.index(of: photo),
                case let .success(image) = result else {
                    return
            }
            let photoIndexPath = IndexPath(item: photoIndex, section: 0)
            
            // When the request finishes, only update the cell if it's still visible
            if let cell = self.collectionView.cellForItem(at: photoIndexPath)
                as? PhotoCollectionViewCell {
                cell.update(with: image)
            }
        }*/
    }
 
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
        } else {
            print("Portrait")
        }
        self.collectionView.performBatchUpdates(nil, completion: nil)
    }
   /* override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showPhoto"?:
            if let selectedIndexPath =
                collectionView.indexPathsForSelectedItems?.first {
                
                let photo = photoDataSource.photos[selectedIndexPath.row]
                
                let destinationVC = segue.destination as! PhotoInfoViewController
                destinationVC.photo = photo
                destinationVC.store = store
            }
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }*/
    
    //MARK: - SEARCH
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarSearchButtonClicked \(searchBar.text)")
        //if(!(searchBar.text?.isEmpty)!){
            //reload your data source if necessary
            flagDataSource.search(value: searchBar.text!)
            self.collectionView?.reloadData()
        //}
        //else
        //{
            
        //}
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchBar \(searchText)")
        flagDataSource.search(value: searchText)
        self.collectionView?.reloadData()
        /*if(searchText.isEmpty){
            //reload your data source if necessary
            self.collectionView?.reloadData()
        }*/
    }
    /*// change background color when user touches cell
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.red
    }
    
    // change background color back when user releases touch
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.cyan
    }*/
}
