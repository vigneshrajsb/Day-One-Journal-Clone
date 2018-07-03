//
//  ImageCollectionViewController.swift
//  Day One Journal Clone
//
//  Created by Vigneshraj Sekar Babu on 6/24/18.
//  Copyright © 2018 Vigneshraj Sekar Babu. All rights reserved.
//

import UIKit
import RealmSwift

//private let reuseIdentifier = "cell"

class ImageCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var images : Results<Pictures>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
           fetchImages()
    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let images = images {
        return images.count
        }
            return 0
    
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? ImageCollectionViewCell {
            if let image = images?[indexPath.row] {
            cell.imageView.image = image.getsmallImage()
            cell.dayLabel.text = image.entry?.getDateComponent(component: "d")
            cell.monthYearLabel.text = image.entry?.getDateComponent(component: "MMM yyyy")
            }
             return cell
        }
        
        // Configure the cell
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width/2 , height: view.safeAreaLayoutGuide.layoutFrame.width/2 )
    }
    
    //MARK: - fecth data from Realm
    
    func fetchImages() {
        guard let realm = try? Realm() else { fatalError("cannot initialize Realm while fetching images")}
        images = realm.objects(Pictures.self)
       // print(images)
        collectionView?.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedEntry = images?[indexPath.row] {
        performSegue(withIdentifier: "imageToDetail", sender: selectedEntry.entry)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "imageToDetail" {
            if let journal = sender as? JournalEntry {
                if let destinationVC = segue.destination as? JournalDetailViewController {
                    destinationVC.selectedJournal = journal
                }
            }
        }
    }
   
    
}
