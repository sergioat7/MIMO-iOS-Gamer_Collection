//
//  SagaTableViewHeaderView.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 05/04/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

class SagaTableViewHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var btEdit: UIButton!
    
    var sagaHeaderViewModel: SagaHeaderViewModel? {
        didSet {
            configure()
        }
    }
    
    func configure() {
        
        lbTitle.attributedText = NSAttributedString(string: sagaHeaderViewModel?.name ?? "",
                                                    attributes: [.font : UIFont.bold18,
                                                                 .foregroundColor: Color.color2])
        
        btEdit.setAttributedTitle(NSAttributedString(string: "EDIT".localized(),
                                                     attributes: [.font : UIFont.regular16,
                                                                  .foregroundColor: Color.color2]),
                                  for: UIControl.State())
        btEdit.addTarget(self, action: #selector(editSaga), for: .touchUpInside)
    }
    
    @objc private func editSaga() {
        
        if let sagaId = sagaHeaderViewModel?.id {
            SagaDetailRouter(sagaId: sagaId).push()
        }
    }
}
