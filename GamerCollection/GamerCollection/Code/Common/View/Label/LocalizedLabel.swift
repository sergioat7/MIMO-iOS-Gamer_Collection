//
//  LocalizedLabel.swift
//  GamerCollection
//
//  Created by alumno on 28/03/2020.
//

import UIKit

class LocalizedLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    func setUp() {
        self.text = text?.localized()
    }
}
