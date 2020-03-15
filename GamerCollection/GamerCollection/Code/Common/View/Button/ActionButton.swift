//
//  ActionButton.swift
//  GamerCollection
//
//  Created by alumno on 15/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

class ActionButton: UIButton {
    
    var background: UIColor? {
        didSet {
            setUp()
        }
    }
    var text: UIColor? {
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
    
    func setUp() {
        titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        titleLabel?.textAlignment = NSTextAlignment.center
        
        setTitleColor(text, for: UIControl.State())
        if layer.frame.height == 0.0 {
            layer.cornerRadius = 24
        }
        else {
            layer.cornerRadius = layer.frame.height / 2
        }
        
        self.setTitle(self.currentTitle?.localized().uppercased(), for: UIControl.State())
        self.backgroundColor = background
    }

}
