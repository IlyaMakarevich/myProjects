//
//  MyTableViewCell.swift
//  tableViewVontroller
//
//  Created by MacBook Pro  on 11.12.2019.
//  Copyright © 2019 MacBook Pro . All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func refresh(_ model: Model) {
        nameLabel.text = model.name
        detailLabel.text = model.prof
    }
}
