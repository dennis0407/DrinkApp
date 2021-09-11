//
//  MenuTableViewCell.swift
//  Drink
//
//  Created by Dennis Lin on 2021/8/24.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    
    @IBOutlet weak var drinkLabel: UILabel!
    @IBOutlet weak var lPriceLabel: UILabel!
    @IBOutlet weak var mPriceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
