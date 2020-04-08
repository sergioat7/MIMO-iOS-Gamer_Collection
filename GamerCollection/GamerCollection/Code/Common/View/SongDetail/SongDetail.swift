//
//  SongDetail.swift
//  GamerCollection
//
//  Created by alumno on 07/04/2020.
//

import UIKit

class SongDetail: UIView {
    
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbSinger: UILabel!
    @IBOutlet weak var lbUrl: UILabel!
    @IBOutlet weak var btRemove: UIButton!
    
    var song: SongResponse? {
        didSet {
            setUp()
        }
    }
    
    var isEnabled: Bool = false {
        didSet {
            btRemove.isHidden = !isEnabled
        }
    }
    
    var removeHandler: ((Int64) -> Void)?
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        
        let bundle = Bundle(for: type(of: self))
        // nibName --> gets the name of the class so the .xib has to be called just like the class
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        view.frame = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        
        addSubview(view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        
        let name = song?.name ?? ""
        lbName.attributedText = NSAttributedString(string: name,
                                                   attributes: [.font : UIFont.bold16,
                                                                .foregroundColor: Color.color2])
        
        let singer = song?.singer ?? ""
        lbSinger.attributedText = NSAttributedString(string: singer,
                                                     attributes: [.font : UIFont.regular16,
                                                                  .foregroundColor: Color.color2])
        
        let url = song?.url ?? ""
        lbUrl.attributedText = NSAttributedString(string: url,
                                                  attributes: [.font : UIFont.regular16,
                                                               .foregroundColor: Color.color2])
        
        btRemove.setAttributedTitle(NSAttributedString(string: "REMOVE".localized(),
                                                       attributes: [.font : UIFont.bold16,
                                                                    .foregroundColor: Color.color4]),
                                    for: UIControl.State())
        btRemove.addTarget(self, action: #selector(removeSong), for: .touchUpInside)
    }
    
    // MARK: - Private functions
    
    @objc private func removeSong() {
        
        if let songId = song?.id {
            removeHandler?(songId)
        }
    }
}
