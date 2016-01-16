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

class RepoCellModel : MYCellModel {
    let avatarUrl: String;
    let name: String;
    
    init(
        avatarUrl: String,
        name: String,
        selectionHandler: MYSelectionHandler) {
            
            self.avatarUrl = avatarUrl;
            self.name = name;
            
            super.init(cell: RepoCell.self, height: 57, selectionHandler: selectionHandler)
    }
}

class RepoCell: MYTableViewCell {
    
    @IBOutlet weak var imageViewAvatar: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    
    override func configureCell(cellModel: MYCellModel) {
        super.configureCell(cellModel);
        
        if let repoCellModel: RepoCellModel = (cellModel as? RepoCellModel) {
            
            imageViewAvatar.kf_setImageWithURL(NSURL(string: repoCellModel.avatarUrl)!,
                placeholderImage: UIImage(asset: .Git_icon),
                optionsInfo: [.Transition(ImageTransition.Fade(1))]
            );
            
            imageViewAvatar.kf_showIndicatorWhenLoading = true;
            
            labelName.text = repoCellModel.name;
            
        }
    }
}
