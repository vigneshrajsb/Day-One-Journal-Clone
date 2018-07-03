//
//  JournalDetailViewController.swift
//  Day One Journal Clone
//
//  Created by Vigneshraj Sekar Babu on 6/24/18.
//  Copyright © 2018 Vigneshraj Sekar Babu. All rights reserved.
//

import UIKit

class JournalDetailViewController: UIViewController {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var journalTextLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    var selectedJournal : JournalEntry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        fillData()
        
        
    }
    
    func initUI() {
        if let navbar = navigationController?.navigationBar {
            navbar.tintColor = UIColor.white
            //navbar.backItem?.title = "Back"
        }
        stackView.alignment = .fill
    }
    
    func fillData() {
        if let journal = selectedJournal {
            journalTextLabel.text = journal.text
            
            for image in journal.pictures {
                let imageView = UIImageView()
                imageView.contentMode = .scaleAspectFit
                let ratio = image.getFullImage().size.height/image.getFullImage().size.width
                imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1.0)
                imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: ratio).isActive = true
                imageView.image = image.getFullImage()
                stackView.addArrangedSubview(imageView)
            }
        }  else {
            journalTextLabel.text = ""
        }
    }
    
    
    
}
