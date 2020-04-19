//
//  UnderlinedTextView.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 29/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

class UnderlinedTextView: UITextView {

    @IBOutlet weak var tvText: UITextView!
    @IBOutlet weak var vwBottomLine: UIView!
    @IBOutlet weak var lbPlaceholder: UILabel!
    
    var theme: Theme? = .dark {
        didSet {
            setUp()
        }
    }
    
    override var text: String? {
        set {
            setText(text: newValue)
        }
        get {
            return tvText.text
        }
    }
    
    var textFont: UIFont = .regular16
    
    var placeholder: String? {
        didSet {
            setPlaceholder(placeholder: placeholder ?? "")
        }
    }
    
    var placeholderFont: UIFont = .regular16
    
    var isEnabled: Bool = true {
        didSet {
            isUserInteractionEnabled = isEnabled
            tvText.isEditable = isEnabled
            vwBottomLine.isHidden = !isEnabled
        }
    }
    
    init(frame: CGRect) {
        super.init(frame: frame, textContainer: nil)
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
        if let view = Bundle.main.loadNibNamed("UnderlinedTextView", owner:self, options:nil)!.first as? UIView {
            view.frame = bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(view)
        }
        
        tvText.keyboardType = keyboardType
        tvText.textAlignment = self.textAlignment
        
        vwBottomLine.backgroundColor = theme == .dark ? Color.color2 : Color.color1
        
        self.isEditable = false
    }
    
    // MARK: - Private functions
    
    private func setText(text: String?) {
        
        if let text = text, !text.isEmpty {

            let color = theme == .dark ? Color.color2 : Color.color1
            tvText.attributedText = NSAttributedString(string: text,
                                                       attributes: [.font : textFont,
                                                                    .foregroundColor: color])
            lbPlaceholder.isHidden = true
        } else {
            tvText.text = ""
            setPlaceholder(placeholder: placeholder ?? "")
        }
    }
    
    private func setPlaceholder(placeholder: String) {
        
        let color = theme == .dark ? Color.color2SuperLight : Color.color1SuperLight
        lbPlaceholder.attributedText = NSAttributedString(string: placeholder,
                                                          attributes: [.font : placeholderFont,
                                                                       .foregroundColor: color])
        lbPlaceholder.isHidden = false
        
        tvText.delegate = self
    }
}

extension UnderlinedTextView: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        lbPlaceholder.isHidden = !textView.text.isEmpty
    }
}
