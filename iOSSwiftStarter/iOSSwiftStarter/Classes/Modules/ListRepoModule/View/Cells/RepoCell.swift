//
//  RepoCell.swift
//  iOSSwiftStarter
//
//  Created by Romain Rochegude on 16/12/2015.
//  Copyright © 2015 Romain Rochegude. All rights reserved.
//

import UIKit
import Hakuba
import Kingfisher

class RepoCellModel : CellModel {
    let avatarUrl: String;
    let name: String;
    
    init(
        avatarUrl: String,
        name: String,
        selectionHandler: SelectionHandler) {
        
        self.avatarUrl = avatarUrl;
        self.name = name;
        
        super.init(cell: RepoCell.self, height: 57, selectionHandler: selectionHandler)
    }
}

class RepoCell: Cell, CellType {
    typealias CellModel = RepoCellModel
    
    @IBOutlet weak var imageViewAvatar: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    
    override func configure() {
        guard let cellModel = cellmodel else {
            return
        }
        
        imageViewAvatar.kf_setImageWithURL(NSURL(string: cellModel.avatarUrl)!,
                                           placeholderImage: UIImage(asset: .Git_icon),
                                           optionsInfo: [.Transition(ImageTransition.Fade(1))]
        );
        
        imageViewAvatar.kf_showIndicatorWhenLoading = true;
        
        labelName.text = cellModel.name;
    }
}
