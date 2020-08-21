//
//  profileCellTableViewCell.swift
//  Soundsgram
//
//  Created by Hasan Dagg on 31.01.2020.
//  Copyright © 2020 Hasan Dag. All rights reserved.
//

import UIKit

class profileCellTableViewCell: UITableViewCell {

    @IBOutlet weak var ownFeedsImg: UIImageView!
    @IBOutlet weak var docIDlabel: UILabel!
    @IBOutlet weak var likeCount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func likeButton(_ sender: Any) {
    }
    @IBAction func commentButon(_ sender: Any) {
    }
    
}
