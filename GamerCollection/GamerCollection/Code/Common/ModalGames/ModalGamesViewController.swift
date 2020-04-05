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
        closePopup()
    }
    
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
    
    private func closePopup(games: GamesResponse? = nil, handler: ((GamesResponse?) -> Void)? = nil) {
        
        animatedClearBackground()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.hidePopup()
            handler?(games)
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

// MARK: - UITableViewDelegate

extension ModalGamesViewController:  UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

// MARK: - UITableViewDataSource

extension ModalGamesViewController:  UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as! GameTableViewCell
        return cell
    }
}
