//
//  ModalGamesViewController.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 05/04/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol ModalGamesViewProtocol: BaseModalViewProtocol {
    /**
     * Add here your methods for communication VIEW_MODEL -> VIEW
     */
    
}

protocol ModalGamesConfigurableViewProtocol: class {
    
    func set(viewModel: ModalGamesViewModelProtocol)
    
}

class ModalGamesViewController: BaseModalViewController {
    
    // MARK: - Public properties
    
    @IBOutlet weak var tvGames: UITableView!
    @IBOutlet weak var ivEmptyList: UIImageView!
    @IBOutlet weak var lbEmptyList: UILabel!
    
    // MARK: - Private properties
    
    private var viewModel:ModalGamesViewModelProtocol?
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configViews()
        viewModel?.viewDidLoad()
    }
    
    // MARK: - Actions
    
    @IBAction func cancel(_ sender: Any) {
        closePopup(success: {})
    }
    
    @IBAction func save(_ sender: Any) {
        
        var selectedGameIds = [Int64]()
        if let gameCellViewModels = viewModel?.getGameCellViewModels() {
            for gameCellViewModel in gameCellViewModels {
                
                if gameCellViewModel.isSelected {
                    selectedGameIds.append(gameCellViewModel.id)
                }
            }
        }
        
        let handler = viewModel?.getHandler()
        close(gameIds: selectedGameIds, handler: handler)
    }
    
    // MARK: - Overrides
    
    // MARK: - Private functions
    
    private func configViews() {
        setupTableView()
    }
    
    private func setupTableView() {
        
        tvGames.dataSource = self
        registerNib()
    }
    
    private func registerNib() {
        tvGames.register(UINib(nibName: "GameTableViewCell", bundle: nil), forCellReuseIdentifier: "GameCell")
    }
    
    private func close(gameIds: [Int64], handler: (([Int64]?) -> Void)?) {
        
        closePopup(success: {
            handler?(gameIds)
        })
    }
}

// MARK: - ModalGamesViewProtocol

extension ModalGamesViewController:  ModalGamesViewProtocol {
    
}

// MARK: - ModalGamesViewProtocol

extension ModalGamesViewController:  ModalGamesConfigurableViewProtocol {
    
    func set(viewModel: ModalGamesViewModelProtocol) {
        self.viewModel = viewModel
    }
}

// MARK: - UITableViewDataSource

extension ModalGamesViewController:  UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let gameCellViewModelsCount = viewModel?.getGameCellViewModels().count ?? 0
        ivEmptyList.image = gameCellViewModelsCount != 0 ? nil : UIImage(named: "game pad")
        lbEmptyList.attributedText = gameCellViewModelsCount != 0 ? nil : NSAttributedString(string: "EMPTY_LIST".localized(),
                                                                                             attributes: [.font : UIFont.bold24,
                                                                                                          .foregroundColor: Color.color2])
        return gameCellViewModelsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as! GameTableViewCell
        
        let gameCellViewModels = viewModel?.getGameCellViewModels()
        let gameCellViewModel = gameCellViewModels?[indexPath.row]
        cell.gameCellViewModel = gameCellViewModel
        
        cell.selectionStyle = .none
        
        return cell
    }
}
