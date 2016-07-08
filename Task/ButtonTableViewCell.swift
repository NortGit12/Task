//
//  ButtonTableViewCell.swift
//  Task
//
//  Created by Jeff Norton on 7/8/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {
    
    // MARK: - Stored Properties
    
    @IBOutlet weak var primaryLabel: UILabel!
    @IBOutlet weak var isCompleteButton: UIButton!
    
    // MARK: - General

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Actions

    @IBAction func isCompleteButtonTapped(sender: UIButton) {
    }
}
