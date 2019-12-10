//
//  TableViewCell.swift
//  tableView
//
//  Created by MacBook Pro  on 09.12.2019.
//  Copyright © 2019 MacBook Pro . All rights reserved.
//

import UIKit

final class LineCell: UITableViewCell {

    @IBOutlet var lineLabel: UILabel!
    @IBOutlet var textView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
