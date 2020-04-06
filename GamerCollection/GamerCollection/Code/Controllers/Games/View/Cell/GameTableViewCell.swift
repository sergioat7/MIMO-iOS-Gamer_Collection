//
//  GameTableViewCell.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 21/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit
import Kingfisher
import Cosmos
import BEMCheckBox

class GameTableViewCell: UITableViewCell {
    
    @IBOutlet weak var vwGameImage: UIView!
    @IBOutlet weak var ivGame: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbPlatform: UILabel!
    @IBOutlet weak var lbReleaseDate: UILabel!
    @IBOutlet weak var vwScore: CosmosView!
    @IBOutlet weak var ivIsGoty: UIImageView!
    @IBOutlet weak var cbSelected: BEMCheckBox!
    
    var gameCellViewModel: GameCellViewModel? {
        didSet {
            configure()
        }
    }
    
    func configure() {
        
        if let state = gameCellViewModel?.stateId {
            
            switch state {
            case Constants.State.pending:
                vwGameImage.backgroundColor = Color.color4
            case Constants.State.inProgress:
                vwGameImage.backgroundColor = Color.color5
            case Constants.State.finished:
                vwGameImage.backgroundColor = Color.color3
            default:break
            }
        }
        
        if let image = gameCellViewModel?.imageUrl, let imageUrl = URL(string: image) {
            
            ivGame.kf.indicatorType = .activity
            ivGame.kf.setImage(with: imageUrl)
        } else {
            ivGame.image = nil
        }
        
        lbName.attributedText = NSAttributedString(string: gameCellViewModel?.name ?? "",
                                                   attributes: [.font : UIFont.bold18,
                                                                .foregroundColor: Color.color1])
        lbPlatform.attributedText = NSAttributedString(string: gameCellViewModel?.platformName ?? "",
                                                       attributes: [.font : UIFont.roman14,
                                                                    .foregroundColor: Color.color1])
        
        if let releaseDate = gameCellViewModel?.releaseDate, !releaseDate.isEmpty, gameCellViewModel?.stateId == Constants.State.pending {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.locale = Locale(identifier: Locale.current.languageCode ?? "en")
            dateFormatter.timeZone = NSTimeZone.local
            
            dateFormatter.dateFormat = "dd-MM-yyyy"
            let date = dateFormatter.date(from: releaseDate)
            
            if date?.compare(Date()) == .orderedDescending {
                lbReleaseDate.attributedText = NSAttributedString(string: "GAMES_UNRELEASED".localized().uppercased(),
                                                                  attributes: [.font : UIFont.bold14,
                                                                               .foregroundColor: Color.color4])
            } else {
                lbReleaseDate.attributedText = NSAttributedString(string: "GAMES_RELEASED".localized().uppercased(),
                                                                  attributes: [.font : UIFont.bold14,
                                                                               .foregroundColor: Color.color3])
            }
            lbReleaseDate.isHidden = false
        } else {
            lbReleaseDate.isHidden = true
        }
        
        vwScore.rating = (gameCellViewModel?.score ?? 0) / 2
        
        ivIsGoty.image = gameCellViewModel?.isGoty == true ? UIImage(named: "goty_label") : nil
        
        if gameCellViewModel?.isSelectable == true {
            
            cbSelected.isHidden = false
            cbSelected.onAnimationType = .fill
            cbSelected.offAnimationType = .fill
            cbSelected.delegate = self
            let isOn = gameCellViewModel?.isSelected == true
            cbSelected.setOn(isOn, animated: true)
        } else {
            cbSelected.isHidden = true
        }
    }
}

// MARK: - BEMCheckBoxDelegate

extension GameTableViewCell: BEMCheckBoxDelegate {
    
    func didTap(_ checkBox: BEMCheckBox) {
        
        let isSelected = gameCellViewModel?.isSelected ?? false
        gameCellViewModel?.isSelected = !isSelected
    }
}
