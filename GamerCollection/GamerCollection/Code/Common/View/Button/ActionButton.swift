//
//  ActionButton.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 15/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

class ActionButton: UIButton {
    
    @IBInspectable var background: UIColor? {
        didSet {
            setUp()
        }
    }
    @IBInspectable var text: UIColor? {
        didSet {
            setUp()
        }
    }

    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                self.backgroundColor = self.backgroundColor?.withAlphaComponent(0.8)
            }
            else {
                UIView.animate(
                    withDuration: 0.2,
                    delay: 0,
                    usingSpringWithDamping: 1,
                    initialSpringVelocity: 0,
                    options: [.beginFromCurrentState, .allowUserInteraction],
                    animations: { () -> Void in
                        self.backgroundColor = self.background
                    },
                    completion: nil
                )
            }
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
        titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        titleLabel?.textAlignment = NSTextAlignment.center
        
        setTitleColor(text, for: UIControl.State())
        
        self.setTitle(self.currentTitle?.localized().uppercased(), for: UIControl.State())
        self.backgroundColor = background
    }

}
