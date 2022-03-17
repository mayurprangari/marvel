//
//  CharacterListCell.swift
//  Marvel
//
//  Created by Mayur Rangari on 10/03/22.
//

import UIKit
import SDWebImage

class CharacterListCell: UITableViewCell {
    
    @IBOutlet private weak var imgView: UIImageView!
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var lblDescription: UILabel!
    @IBOutlet private weak var innerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        innerView.clipsToBounds = true
        innerView.layer.cornerRadius = 20
        innerView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    func setupData(result:Result){
        let imageUrl : String = "\(result.thumbnail!.path ?? "")/\(result.urls![0].type ?? .detail).\(result.thumbnail!.thumbnailExtension ?? .jpg)"
        imgView.sd_setImage(with: URL(string: imageUrl),placeholderImage: UIImage(named: "imgNoImage"))
        lblTitle?.text = result.name ?? ""
        lblDescription.text = result.resultDescription ?? ""
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
