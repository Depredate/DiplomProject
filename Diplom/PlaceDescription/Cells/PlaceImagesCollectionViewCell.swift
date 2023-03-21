//
//  PlaceImagesCollectionViewCell.swift
//  Diplom
//
//  Created by Махова Татьяна on 21.03.2023.
//

import UIKit
import SDWebImage

class PlaceImagesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func setupCell(URLString: String) {
        let imageURL = URL(string: URLString)
        imageView.sd_setImage(with: imageURL)
    }

}
