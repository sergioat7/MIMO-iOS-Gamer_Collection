//
//  ModalGamesViewController.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 05/04/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol ModalGamesViewProtocol: BaseViewProtocol {
    /**
     * Add here your methods for communication VIEW_MODEL -> VIEW
     */
    
}

protocol ModalGamesConfigurableViewProtocol: class {
    
    func set(viewModel: ModalGamesViewModelProtocol)
    
}

class ModalGamesViewController: BaseViewController {
    
    // MARK: - Public properties
    
    @IBOutlet weak var tvGames: UITableView!
    @IBOutlet weak var ivEmptyList: UIImageView!
    @IBOutlet weak var lbEmptyList: UILabel!
    
    // MARK: - Private properties
    
    private var viewModel:ModalGamesViewModelProtocol?
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        configViews()
        viewModel?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            self.animatedDarkenBackground()
        }
    }
    
    // MARK: - Actions
    
    @IBAction func cancel(_ sender: Any) {
        closePopup()
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
        closePopup(gameIds: selectedGameIds, handler: handler)
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
    
    private func animatedDarkenBackground() {
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
            self.view.backgroundColor = Color.color1Light
        }, completion:nil)
    }
    
    private func animatedClearBackground() {
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
            self.view.backgroundColor = UIColor.clear
        }, completion:nil)
    }
    
    private func closePopup(gameIds: [Int64]? = nil, handler: (([Int64]?) -> Void)? = nil) {
        
        animatedClearBackground()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.hidePopup()
            handler?(gameIds)
        }
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
