//
//  LocalizedLabel.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 28/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
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
