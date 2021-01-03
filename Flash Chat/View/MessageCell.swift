//
//  MessageCell.swift
//  Flash Chat
//
//  Created by João Victor Ipirajá de Alencar on 02/01/21.
//

import UIKit

class MessageCell: UITableViewCell {
    
    @IBOutlet weak var messageBubble: UIView!
       @IBOutlet weak var label: UILabel!
       @IBOutlet weak var rightImageView: UIImageView!
       @IBOutlet weak var leftImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
