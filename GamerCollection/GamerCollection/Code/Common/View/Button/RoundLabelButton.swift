//
//  RoundLabelButton.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 29/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

class RoundLabelButton: UIButton {

    @IBInspectable var background: UIColor? {
        didSet {
            setUp()
        }
    }
    @IBInspectable var selectedBackground: UIColor? {
        didSet {
            setUp()
        }
    }
    @IBInspectable var titleColor: UIColor = .white {
        didSet {
            setUp()
        }
    }
    @IBInspectable var selectedTitleColor: UIColor = .white {
        didSet {
            setUp()
        }
    }
    @IBInspectable var border: UIColor? {
        didSet {
            setUp()
        }
    }
    
    override var isSelected: Bool {
        willSet {
            
            let color = newValue ? selectedTitleColor : titleColor
            setAttributedTitle(NSAttributedString(string: self.currentTitle ?? "",
                               attributes: [.font : UIFont.roman14,
                                            .foregroundColor: color]),
                               for: UIControl.State())
            backgroundColor = newValue ? selectedBackground : background
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
        layer.cornerRadius = layer.frame.height / 2
    }
    
    func setUp() {
        
        titleLabel?.textAlignment = NSTextAlignment.center
        titleLabel?.numberOfLines = 1
        
        contentEdgeInsets = UIEdgeInsets(horizontal: 30, vertical: 15)
                
        setAttributedTitle(NSAttributedString(string: self.currentTitle ?? "",
                                              attributes: [.font : UIFont.roman14,
                                                           .foregroundColor: titleColor]),
                           for: UIControl.State())
        
        backgroundColor = background
        
        layer.borderColor = border?.cgColor
        layer.borderWidth = 1
    }
}
