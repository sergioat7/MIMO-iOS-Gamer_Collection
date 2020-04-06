//
//  ModalSongViewController.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 06/04/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol ModalSongViewProtocol: BaseModalViewProtocol {
    /**
     * Add here your methods for communication VIEW_MODEL -> VIEW
     */
    
}

protocol ModalSongConfigurableViewProtocol: class {
    
    func set(viewModel: ModalSongViewModelProtocol)
    
}

class ModalSongViewController: BaseModalViewController {
    
    // MARK: - Public properties
    
    @IBOutlet weak var svData: UIScrollView!
    @IBOutlet weak var tvName: UnderlinedTextView!
    @IBOutlet weak var tvSinger: UnderlinedTextView!
    @IBOutlet weak var tvUrl: UnderlinedTextView!
    
    // MARK: - Private properties
    
    private var viewModel:ModalSongViewModelProtocol?
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView = svData
        configViews()
        viewModel?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        registerKeyboardNotifications()
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeKeyboardNotifications()
        view.removeGestureRecognizers()
    }
    
    // MARK: - Actions
    
    @IBAction func cancel(_ sender: Any) {
        closePopup(success: {})
    }
    
    @IBAction func save(_ sender: Any) {
        
        let name = tvName.text
        let singer = tvSinger.text
        let url = tvUrl.text
        
        let song = SongResponse(id: 0,
                                name: name,
                                singer: singer,
                                url: url)
        viewModel?.createSong(song: song)
    }
    
    // MARK: - Overrides
    
    // MARK: - Private functions
    
    private func configViews() {
        
        tvName.placeholder = "MODAL_SONG_PLACEHOLDER_NAME".localized()
        tvSinger.placeholder = "MODAL_SONG_PLACEHOLDER_SINGER".localized()
        tvUrl.placeholder = "MODAL_SONG_PLACEHOLDER_URL".localized()
    }
}

// MARK: - ModalSongViewProtocol

extension ModalSongViewController:  ModalSongViewProtocol {
    
}

// MARK: - ModalSongViewProtocol

extension ModalSongViewController:  ModalSongConfigurableViewProtocol {
    
    func set(viewModel: ModalSongViewModelProtocol) {
        self.viewModel = viewModel
    }
    
}
