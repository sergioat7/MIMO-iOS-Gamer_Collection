//
//  SagaDetailViewController.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 05/04/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol SagaDetailViewProtocol: BaseViewProtocol {
    /**
     * Add here your methods for communication VIEW_MODEL -> VIEW
     */
    func setName(name: String?)
    func showGames(games: GamesResponse)
    func enableEdition(enable: Bool)
    func getSagaName() -> String?
}

protocol SagaDetailConfigurableViewProtocol: class {
    
    func set(viewModel: SagaDetailViewModelProtocol)
    
}

class SagaDetailViewController: BaseViewController {
    
    // MARK: - Public properties
    
    @IBOutlet weak var tvName: UnderlinedTextView!
    @IBOutlet weak var svGames: UIStackView!
    @IBOutlet weak var btAddGame: UIButton!
    
    // MARK: - Private properties
    
    private var viewModel:SagaDetailViewModelProtocol?
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "SAGA_DETAIL".localized()
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
    
    @IBAction func addGame(_ sender: Any) {
        print("add game to saga")//TODO
    }
    
    @IBAction func deleteSaga(_ sender: UIButton) {
        
        showConfirmationDialog(message: "SAGA_DETAIL_DELETE_CONFIRMATION".localized(), handler: {
            self.viewModel?.deleteSaga()
        }, handlerCancel: nil)
    }
    
    // MARK: - Overrides
    
    // MARK: - Private functions
    
    private func configViews() {
        
        tvName.placeholder = "GAME_DETAIL_PLACEHOLDER_NAME".localized()
        tvName.placeholderFont = .bold24
        tvName.textFont = .bold24
        tvName.isEnabled = true
    }
}

// MARK: - SagaDetailViewProtocol

extension SagaDetailViewController:  SagaDetailViewProtocol {
    
    func setName(name: String?) {
        tvName.text = name
    }
    
    func showGames(games: GamesResponse) {
        
        svGames.removeArrangedSubviews()
        var label: UILabel
        
        for game in games {
            if let name = game.name {
                
                label = UILabel()
                label.attributedText = NSAttributedString(string: "- \(name)",
                                                          attributes: [.font: UIFont.roman16,
                                                                       .foregroundColor: Color.color2])
                label.numberOfLines = 0
                label.setContentHuggingPriority(.required, for: .vertical)
                label.setContentCompressionResistancePriority(.required, for: .vertical)
                svGames.addArrangedSubview(label)
            }
        }
    }
    
    func enableEdition(enable: Bool) {
        
        tvName.isEnabled = enable
        btAddGame.isHidden = !enable
    }
    
    func getSagaName() -> String? {
        return tvName.text
    }
}

// MARK: - SagaDetailViewProtocol

extension SagaDetailViewController:  SagaDetailConfigurableViewProtocol {
    
    func set(viewModel: SagaDetailViewModelProtocol) {
        self.viewModel = viewModel
    }
    
}
