//
//  TimelineTableViewCell.swift
//  EmoDiary
//
//  Created by 이지영 on 2016. 11. 27..
//  Copyright © 2016년 gamsung. All rights reserved.
//

import UIKit

class TimelineTableViewCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var emotionColor: UIImageView!
    @IBOutlet weak var memoLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.emotionColor.layer.cornerRadius = self.emotionColor.fs_width / 2
        self.emotionColor.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
