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

class GameTableViewCell: UITableViewCell {
    
    @IBOutlet weak var vwGameImage: UIView!
    @IBOutlet weak var ivGame: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbPlatform: UILabel!
    @IBOutlet weak var lbReleaseDate: UILabel!
    @IBOutlet weak var vwScore: CosmosView!
    @IBOutlet weak var ivIsGoty: UIImageView!

    var gameCellViewModel: GameCellViewModel? {
        didSet {
            configure()
        }
    }
    
    func configure() {
        
        if let state = gameCellViewModel?.stateId {
            switch state {
            case "PENDING":
                vwGameImage.backgroundColor = Color.color2
            case "IN_PROGRESS":
                vwGameImage.backgroundColor = Color.color5
            case "FINISHED":
                vwGameImage.backgroundColor = Color.color3
            default:break
            }
        }
        
        if let image = gameCellViewModel?.imageUrl, let imageUrl = URL(string: image) {
            
            ivGame.kf.indicatorType = .activity
            ivGame.kf.setImage(with: imageUrl)
        }
        
        lbName.attributedText = NSAttributedString(string: gameCellViewModel?.name ?? "",
                                                   attributes: [.font : UIFont.bold18,
                                                                .foregroundColor: Color.color1])
        lbPlatform.attributedText = NSAttributedString(string: gameCellViewModel?.platformName ?? "",
                                                       attributes: [.font : UIFont.roman14,
                                                                    .foregroundColor: Color.color1])
        
        if let releaseDate = gameCellViewModel?.releaseDate, !releaseDate.isEmpty, gameCellViewModel?.stateId == "PENDING" {
            
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
    }
    
}
