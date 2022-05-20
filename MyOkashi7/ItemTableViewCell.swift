//
//  ItemTableViewCell.swift
//  MyOkashi7
//
//  Created by 澤田世那 on 2022/05/20.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    static var identifier: String { String(describing: self) }
    static var nib: UINib { UINib(nibName: String(describing: self), bundle: nil) }

    @IBOutlet weak var okashiImageView: UIImageView!
    @IBOutlet weak var itemLabel: UILabel!
    
    func configure(item: (name: String, maker: String, link: URL, image: URL)) {
        itemLabel.text = item.name
        
        if let imageData = try? Data(contentsOf: item.image) {
        okashiImageView.image = UIImage(data: imageData)
        }
    }
}
