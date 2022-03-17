//
//  MarvelCollectionCell.swift
//  Marvel
//
//  Created by Mayur Rangari on 10/03/22.
//

import UIKit

class MarvelCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var lblIssueNo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupData(model:Results?){
        lblTitle.text = model?.title
        lblIssueNo.text = "Issue number \(model?.issueNumber ?? 0)"
        let imageUrl : String = "\(model?.thumbnail?.path ?? "")/portrait_uncanny\(model?.thumbnail?.thumbnailExtension ?? ".jpg")"
        imgView.sd_setImage(with: URL(string: imageUrl),placeholderImage: UIImage(named: "imgNoImage"))
    }
}
