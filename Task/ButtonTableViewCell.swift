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
    
    var delegate: ButtonTableViewCellDelegate?
    
    @IBOutlet weak var primaryLabel: UILabel!
    @IBOutlet weak var isCompleteButton: UIButton!
    
    // MARK: - General

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Methods
    
    func updateWith(task: Task) {
        
        primaryLabel.text = task.name
        isCompleteButton.setTitle(task.isComplete.stringValue, forState: .Normal)
        
    }
    
    // MARK: - Actions

    @IBAction func isCompleteButtonTapped(sender: UIButton) {
        
//        imageView?.image = UIImage(named: "complete")
        
        if let delegate = delegate {
            
            delegate.buttonCellButtonTapped(self)
            
        }
        
    }
}

protocol ButtonTableViewCellDelegate {
    
    func buttonCellButtonTapped(cell: ButtonTableViewCell)
    
}
