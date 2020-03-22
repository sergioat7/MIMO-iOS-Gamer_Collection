//
//  GameTableViewCell.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 21/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

class GameTableViewCell: UITableViewCell {

    var gameCellViewModel: GameCellViewModel? {
        didSet {
            configure()
        }
    }
    
    func configure() {
    }
    
}
