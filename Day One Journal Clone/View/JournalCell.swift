//
//  TableViewCell.swift
//  Day One Journal Clone
//
//  Created by Vigneshraj Sekar Babu on 6/30/18.
//  Copyright © 2018 Vigneshraj Sekar Babu. All rights reserved.
//

import UIKit

class JournalCell: UITableViewCell {

    
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var previewTextView: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    @IBOutlet weak var constraintForImageViewWidth: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
