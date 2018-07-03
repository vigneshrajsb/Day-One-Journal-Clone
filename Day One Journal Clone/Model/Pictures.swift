//
//  Pictures.swift
//  Day One Journal Clone
//
//  Created by Vigneshraj Sekar Babu on 6/29/18.
//  Copyright © 2018 Vigneshraj Sekar Babu. All rights reserved.
//

import Foundation
import RealmSwift
import Toucan

class Pictures : Object {
    @objc dynamic var imageName : String = ""
    @objc dynamic var smallImageName : String = ""
    @objc dynamic var entry : JournalEntry?
    
    
    convenience init(image : UIImage) {
        self.init()
        imageName = convertImageToURLString(image: image)
        if let croppedImage = Toucan(image: image).resize(CGSize(width: 500, height: 500), fitMode: .crop).image {
            smallImageName = convertImageToURLString(image: croppedImage)
        }
       
    }
    
    func convertImageToURLString(image : UIImage) -> String {
        if let imagePNGRep = UIImagePNGRepresentation(image) {
            let uniqueFileName = UUID().uuidString + ".png"
            var path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            path?.appendPathComponent(uniqueFileName)
            guard let guardedPath = path else { fatalError("missing the path of the image data")}
            try? imagePNGRep.write(to: guardedPath)
            return uniqueFileName
        }
        return ""
    }
    
    
    func getsmallImage() -> UIImage {
        return getImagefromName(fileName: smallImageName)
    }

    func getFullImage() -> UIImage {
        return getImagefromName(fileName: imageName)
    }
    
    func getImagefromName(fileName : String) -> UIImage {
      
        guard var path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return UIImage()}
        path.appendPathComponent(fileName)
        if let imageData = try? Data(contentsOf: path) {
            if let image = UIImage(data: imageData) {
                return image
            }
            
        }
        
        return UIImage()
    }
    
}
