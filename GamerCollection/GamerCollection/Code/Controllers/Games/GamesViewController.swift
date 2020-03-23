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
}

protocol GamesConfigurableViewProtocol: class {

    func set(viewModel: GamesViewModelProtocol)
    
}

class GamesViewController: BaseViewController {
    
    // MARK: - Public properties
    
    @IBOutlet weak var lbGamesNumber: UILabel!
    @IBOutlet weak var btPending: UIButton!
    @IBOutlet weak var btInProgress: UIButton!
    @IBOutlet weak var btFinished: UIButton!
    @IBOutlet weak var tvGames: UITableView!
    
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
    }
    
    // MARK: - Actions
    
    @IBAction func sortGames(_ sender: Any) {
        print("sort")
    }
    
    // MARK: - Overrides
    
    // MARK: - Private functions
    
    private func configViews() {
        
        btPending.backgroundColor = Color.color1SuperLight
        btInProgress.backgroundColor = Color.color1SuperLight
        btFinished.backgroundColor = Color.color1SuperLight
        
        btPending.layer.cornerRadius = 5
        btInProgress.layer.cornerRadius = 5
        btFinished.layer.cornerRadius = 5
        
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
        //TODO go to detail
    }
}

// MARK: - UITableViewDataSource

extension GamesViewController:  UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let gameCellViewModels = viewModel?.getGameCellViewModels()
        let numberOfGames = gameCellViewModels?.count ?? 0
        lbGamesNumber.attributedText = NSAttributedString(string: "#\(numberOfGames) \("GAMES_NUMBER_TITLE".localized())", attributes: [.font : UIFont.bold18, .foregroundColor: Color.color1])
        return numberOfGames
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
