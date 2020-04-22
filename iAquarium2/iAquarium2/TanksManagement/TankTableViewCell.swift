//
//  TankTableViewCell.swift
//  iAquarium2
//
//  Created by Maciej Zajecki on 11/04/2020.
//  Copyright © 2020 Maciej Zajecki. All rights reserved.
//

import UIKit

class TankTableViewCell: UITableViewCell {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var info2Label: UILabel!
    @IBOutlet weak var tankImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
