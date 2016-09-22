//
// Created by Tushar on 10/09/16.
// Copyright (c) 2016 arg. All rights reserved.
//

import Foundation
import UIKit

class TileCollectionViewCell: UIKit.UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    
    override func prepareForReuse() {
        imageView.image = Optional.None
        userInteractionEnabled = true
    }
    
    func setImage(imageName:String) {
        imageView.image = UIImage(named: imageName)
    }
    
}
