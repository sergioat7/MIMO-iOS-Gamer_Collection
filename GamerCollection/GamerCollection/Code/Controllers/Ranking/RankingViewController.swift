//
//  RankingViewController.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 14/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol RankingViewProtocol: BaseViewProtocol {
    /**
     * Add here your methods for communication VIEW_MODEL -> VIEW
     */
    func showGames()
}

protocol RankingConfigurableViewProtocol: class {
    
    func set(viewModel: RankingViewModelProtocol)
    
}

class RankingViewController: BaseViewController {
    
    // MARK: - Public properties
    
    @IBOutlet weak var tvGames: UITableView!
    
    // MARK: - Private properties
    
    private var viewModel:RankingViewModelProtocol?
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "RANKING".localized()
        configViews()
        viewModel?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.viewWillAppear()
    }
    
    // MARK: - Actions
    
    // MARK: - Overrides
    
    // MARK: - Private functions
    
    private func configViews() {
        setupTableView()
    }
    
    private func setupTableView() {
        
        tvGames.delegate = self
        tvGames.dataSource = self
        registerNib()
    }
    
    private func registerNib() {
        tvGames.register(UINib(nibName: "GameTableViewCell", bundle: nil), forCellReuseIdentifier: "GameCell")
    }
    
}

// MARK: - RankingViewProtocol

extension RankingViewController:  RankingViewProtocol {
    
    func showGames() {
        tvGames.reloadData()
    }
}

// MARK: - RankingViewProtocol

extension RankingViewController:  RankingConfigurableViewProtocol {
    
    func set(viewModel: RankingViewModelProtocol) {
        self.viewModel = viewModel
    }
}

// MARK: - UITableViewDelegate

extension RankingViewController:  UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let gameCellViewModels = viewModel?.getGameCellViewModels()
        let gameId = gameCellViewModels?[indexPath.row].id ?? 0
        GameDetailRouter(gameId: gameId).push()
    }
}

// MARK: - UITableViewDataSource

extension RankingViewController:  UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let gameCellViewModels = viewModel?.getGameCellViewModels()
        return gameCellViewModels?.count ?? 0
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
