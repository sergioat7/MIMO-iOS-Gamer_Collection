//
//  DropdownButton.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 27/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

enum Theme: Int {
    case light = 0
    case dark = 1
}

class DropdownButton: UIButton {
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbValue: UILabel!
    @IBOutlet weak var ivArrowDropdown: UIImageView!
    @IBOutlet weak var vwBottomLine: UIView!
    
    var theme: Theme? = .dark {
        didSet {
            setUp()
        }
    }
    
    var title: String? {
        didSet {
            setTitle(title: title ?? "")
        }
    }
    
    var value: String? {
        didSet {
            setValue(value: value)
        }
    }
    
    var placeholder: String? {
        didSet {
            setPlaceholder(placeholder: placeholder ?? "")
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            ivArrowDropdown.isHidden = !isEnabled
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
        if let view = Bundle.main.loadNibNamed("DropdownButton", owner:self, options:nil)!.first as? UIView {
            view.frame = bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(view)
        }
        
        vwBottomLine.backgroundColor = theme == .dark ? Color.color2 : Color.color1
    }
    
    // MARK: - Private functions
    
    private func setTitle(title: String) {
        
        let color = theme == .dark ? Color.color2 : Color.color1
        lbTitle.attributedText = NSAttributedString(string: title,
                                                    attributes: [.font : UIFont.roman12,
                                                                 .foregroundColor: color])
    }
    
    private func setValue(value: String?) {
        
        if let value = value, !value.isEmpty {

            let color = theme == .dark ? Color.color2 : Color.color1
            lbValue.attributedText = NSAttributedString(string: value,
                                                        attributes: [.font : UIFont.roman16,
                                                                     .foregroundColor: color])
        } else {
            setPlaceholder(placeholder: placeholder ?? "")
        }
        
    }
    
    private func setPlaceholder(placeholder: String) {
        
        let color = theme == .dark ? Color.color2SuperLight : Color.color1SuperLight
        guard let val = value, !val.isEmpty else {
            lbValue.attributedText = NSAttributedString(string: placeholder,
                                                        attributes: [.font : UIFont.roman16,
                                                                     .foregroundColor: color])
            return
        }
    }
}
