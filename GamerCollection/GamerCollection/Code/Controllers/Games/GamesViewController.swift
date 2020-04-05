//
//  GamesViewController.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 14/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol GamesViewProtocol: BaseViewProtocol {
    /**
     * Add here your methods for communication VIEW_MODEL -> VIEW
     */
    func showGames()
    func setGamesCount()
}

protocol GamesConfigurableViewProtocol: class {

    func set(viewModel: GamesViewModelProtocol)
    
}

class GamesViewController: BaseViewController {
    
    // MARK: - Public properties
    
    @IBOutlet weak var lbGamesNumber: UILabel!
    @IBOutlet weak var btPending: GameFilterButton!
    @IBOutlet weak var btInProgress: GameFilterButton!
    @IBOutlet weak var btFinished: GameFilterButton!
    @IBOutlet weak var tvGames: UITableView!
    @IBOutlet weak var ivEmptyList: UIImageView!
    @IBOutlet weak var lbEmptyList: UILabel!
    
    // MARK: - Private properties
    
    private var viewModel:GamesViewModelProtocol?
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "GAMES".localized()
        configViews()
        viewModel?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.viewWillAppear()
    }
    
    // MARK: - Actions
    
    @IBAction func sortGames(_ sender: Any) {
        print("sort")
         //TODO
    }
    
    @IBAction func showPendingGames(_ sender: Any) {

        btPending.isSelected = !btPending.isSelected
        btInProgress.isSelected = false
        btFinished.isSelected = false
        viewModel?.filterGamesByState(showPending: btPending.isSelected,
                                      showInProgress: btInProgress.isSelected,
                                      showFinished: btFinished.isSelected)
    }
    
    @IBAction func showInProgressGames(_ sender: Any) {

        btPending.isSelected = false
        btInProgress.isSelected = !btInProgress.isSelected
        btFinished.isSelected = false
        viewModel?.filterGamesByState(showPending: btPending.isSelected,
                                      showInProgress: btInProgress.isSelected,
                                      showFinished: btFinished.isSelected)
    }
    
    @IBAction func showFinishedGames(_ sender: Any) {

        btPending.isSelected = false
        btInProgress.isSelected = false
        btFinished.isSelected = !btFinished.isSelected
        viewModel?.filterGamesByState(showPending: btPending.isSelected,
                                      showInProgress: btInProgress.isSelected,
                                      showFinished: btFinished.isSelected)
    }
    
    
    // MARK: - Overrides
    
    // MARK: - Private functions
    
    private func configViews() {
        
        btPending.title = "GAMES_FILTER_BUTTON_TITLE_PENDING".localized()
        btInProgress.title = "GAMES_FILTER_BUTTON_TITLE_IN_PROGRESS".localized()
        btFinished.title = "GAMES_FILTER_BUTTON_TITLE_FINISHED".localized()
        
        btPending.gameState = Constants.State.pending
        btInProgress.gameState = Constants.State.inProgress
        btFinished.gameState = Constants.State.finished
        
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

// MARK: - GamesViewProtocol

extension GamesViewController:  GamesViewProtocol {
    
    func showGames() {
        tvGames.reloadData()
    }
    
    func setGamesCount() {
        
        let gameCellViewModels = viewModel?.getGameCellViewModels()
        let gamesCount = gameCellViewModels?.count ?? 0
        
        lbGamesNumber.attributedText = NSAttributedString(string: "#\(gamesCount) \("GAMES_NUMBER_TITLE".localized())", attributes: [.font : UIFont.bold18, .foregroundColor: Color.color1])
        
        let filteredGames = gameCellViewModels?.compactMap({$0.stateId})
        let pendingGamesCount = filteredGames?.filter({$0 == Constants.State.pending}).count ?? 0
        let inProgressGamesCount = filteredGames?.filter({$0 == Constants.State.inProgress}).count ?? 0
        let finishedGamesCount = filteredGames?.filter({$0 == Constants.State.finished}).count ?? 0
        btPending.gamesNumber = "\(pendingGamesCount)"
        btInProgress.gamesNumber = "\(inProgressGamesCount)"
        btFinished.gamesNumber = "\(finishedGamesCount)"
    }
}

// MARK: - GamesViewProtocol

extension GamesViewController:  GamesConfigurableViewProtocol {
    
    func set(viewModel: GamesViewModelProtocol) {
        self.viewModel = viewModel
    }
}

// MARK: - UITableViewDelegate

extension GamesViewController:  UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let gameCellViewModels = viewModel?.getGameCellViewModels()
        let gameId = gameCellViewModels?[indexPath.row].id ?? 0
        GameDetailRouter(gameId: gameId).push()
    }
}

// MARK: - UITableViewDataSource

extension GamesViewController:  UITableViewDataSource {
    
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
