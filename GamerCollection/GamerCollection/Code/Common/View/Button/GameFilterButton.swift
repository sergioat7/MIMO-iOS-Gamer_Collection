//
//  GameFilterButton.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 24/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

class GameFilterButton: UIButton {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbGamesNumber: UILabel!
    @IBOutlet weak var vwState: UIView!
    
    var title: String? {
        didSet {
            setTitle(title: title ?? "")
        }
    }
    
    var gamesNumber: String? {
        didSet {
            setGamesNumber(number: gamesNumber ?? "")
        }
    }
    
    var gameState: String? {
        didSet {
            setState(state: gameState ?? "")
        }
    }
    
    override var isSelected: Bool {
        willSet {
            backgroundColor = newValue ? Color.color2 : Color.color1SuperLight
            lbTitle.textColor = newValue ? Color.color1 : Color.color2
            lbGamesNumber.textColor = newValue ? Color.color1 : Color.color2
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setUp() {
        if let view = Bundle.main.loadNibNamed("GameFilterButton", owner:self, options:nil)!.first as? UIView {
            view.frame = bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(view)
        }
        
        backgroundColor = Color.color1SuperLight
        layer.cornerRadius = 5
        
        vwState.layer.cornerRadius = 5
    }
    
    // MARK: - Private functions
    
    private func setTitle(title: String) {
        
        lbTitle.attributedText = NSAttributedString(string: title,
                                                    attributes: [.font : UIFont.roman16,
                                                                 .foregroundColor: Color.color2])
    }
    
    private func setGamesNumber(number: String) {
        
        lbGamesNumber.attributedText = NSAttributedString(string: number,
                                                          attributes: [.font : UIFont.bold16,
                                                                       .foregroundColor: Color.color2])
    }
    
    private func setState(state: String) {
        
        switch state {
        case Constants.State.pending:
            vwState.backgroundColor = Color.color4
        case Constants.State.inProgress:
            vwState.backgroundColor = Color.color5
        case Constants.State.finished:
            vwState.backgroundColor = Color.color3
        default:break
        }
    }
}
