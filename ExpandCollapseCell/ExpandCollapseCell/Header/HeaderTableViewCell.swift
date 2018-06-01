//
//  HeaderTableViewCell.swift
//  CollectionDemo
//
//  Created by shubam on 01/06/18.
//  Copyright © 2018 shubam. All rights reserved.
//

import UIKit
protocol HeaderViewDelegate {
    func expandButtonTapped(_ cell:HeaderTableViewCell)
}

class HeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var arrowLbl: UILabel!
    
    var delegate : HeaderViewDelegate?
    var section :Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(section:Int,student:Student){
        headerLabel.text = student.className
        self.section = section
        arrowLbl.text = student.isSelected ? "v" : ">"
        self.selectionStyle = .none
    }
    
  
    
    @IBAction func expandTapped(_ sender: UIButton) {
        delegate?.expandButtonTapped(self)
    }
}


