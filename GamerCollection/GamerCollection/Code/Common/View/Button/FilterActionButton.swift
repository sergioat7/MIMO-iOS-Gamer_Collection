//
//  FilterActionButton.swift
//  GamerCollection
//
//  Created by alumno on 29/03/2020.
//

import UIKit

class FilterActionButton: UIButton {

    @IBInspectable var background: UIColor = .clear {
        didSet {
            setUp()
        }
    }
    @IBInspectable var titleColor: UIColor = .white {
        didSet {
            setUp()
        }
    }
    @IBInspectable var border: UIColor = .clear {
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
                
        self.setAttributedTitle(NSAttributedString(string: self.currentTitle?.localized() ?? "",
                                                   attributes: [.font : UIFont.bold16, .foregroundColor: titleColor]),
                                for: UIControl.State())
        
        self.backgroundColor = background
        
        layer.borderWidth = 1
        layer.borderColor = border.cgColor
    }

}
