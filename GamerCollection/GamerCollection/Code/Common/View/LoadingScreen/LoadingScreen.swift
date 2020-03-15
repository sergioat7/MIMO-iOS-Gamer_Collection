//
//  LoadingScreen.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 09/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

class LoadingScreen: UIView {

    var view: UIView!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var backgroundView: UIView!

    // MARK: - Object lifecycle
    
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        loadingIndicator.color = .black
        backgroundView.backgroundColor = .white
        backgroundView.alpha = 0.8
    }
    
    // MARK: Public methods
    
    func show(view: UIView) {
        
        alpha = 1
        
        if self.superview == nil {
            view.addSubview(self)
            fillToSuperview()
            loadingIndicator.startAnimating()
        }
    }
    
    func hide(animated: Bool = true, completion: (() -> Void)? = nil) {
        if animated == true {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3, animations: {
                    self.alpha = 0
                }, completion: { (finished) in
                    if self.superview != nil, finished {
                        self.loadingIndicator.stopAnimating()
                        self.removeFromSuperview()
                        completion?()
                    }
                })
            }
        } else {
            self.loadingIndicator.stopAnimating()
            self.removeFromSuperview()
            completion?()
        }
    }
    
    deinit {
        loadingIndicator.stopAnimating()
        removeFromSuperview()
    }

}

