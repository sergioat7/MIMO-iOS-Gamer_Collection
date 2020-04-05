//
//  SagasViewController.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 14/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol SagasViewProtocol: BaseViewProtocol {
    /**
     * Add here your methods for communication VIEW_MODEL -> VIEW
     */
    func showSagas()
}

protocol SagasConfigurableViewProtocol: class {

    func set(viewModel: SagasViewModelProtocol)
    
}

class SagasViewController: BaseViewController {
    
    // MARK: - Public properties
    
    @IBOutlet weak var tvSagas: UITableView!
    @IBOutlet weak var ivEmptyList: UIImageView!
    @IBOutlet weak var lbEmptyList: UILabel!
    
    // MARK: - Private properties
    
    private var viewModel:SagasViewModelProtocol?
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "SAGAS".localized()
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
        
        tvSagas.delegate = self
        tvSagas.dataSource = self
        registerNib()
    }
    
    private func registerNib() {
        
        tvSagas.register(UINib(nibName: "SagaTableViewHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "SagaHeader")
        tvSagas.register(UINib(nibName: "GameTableViewCell", bundle: nil), forCellReuseIdentifier: "GameCell")
    }
    
}

// MARK: - SagasViewProtocol

extension SagasViewController:  SagasViewProtocol {
    
    func showSagas() {
        tvSagas.reloadData()
    }
}

// MARK: - SagasViewProtocol

extension SagasViewController:  SagasConfigurableViewProtocol {
    
    func set(viewModel: SagasViewModelProtocol) {
        self.viewModel = viewModel
    }
}

// MARK: - UITableViewDelegate

extension SagasViewController:  UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sagaHeaderViewModels = viewModel?.getSagaHeaderViewModels()
        let sagaId = sagaHeaderViewModels?[indexPath.section].id ?? 0
        let gameCellViewModels = viewModel?.getSagaGameCellViewModels(sagaId: sagaId)
        let gameId = gameCellViewModels?[indexPath.row].id ?? 0
        GameDetailRouter(gameId: gameId).push()
    }
}

// MARK: - UITableViewDataSource

extension SagasViewController:  UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        let sagaHeaderViewModelsCount = viewModel?.getSagaHeaderViewModels().count ?? 0
        ivEmptyList.image = sagaHeaderViewModelsCount != 0 ? nil : UIImage(named: "sagas image")
        lbEmptyList.attributedText = sagaHeaderViewModelsCount != 0 ? nil : NSAttributedString(string: "EMPTY_LIST".localized(),
                                                                                               attributes: [.font : UIFont.bold24,
                                                                                                            .foregroundColor: Color.color2])
        return sagaHeaderViewModelsCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let sagaHeaderViewModels = viewModel?.getSagaHeaderViewModels()
        let sagaId = sagaHeaderViewModels?[section].id ?? 0
        let gameCellViewModelsCount = viewModel?.getSagaGameCellViewModels(sagaId: sagaId).count ?? 0
        return gameCellViewModelsCount
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SagaHeader") as! SagaTableViewHeaderView
        
        let sagaHeaderViewModels = viewModel?.getSagaHeaderViewModels()
        let sagaHeaderViewModel = sagaHeaderViewModels?[section]
        header.sagaHeaderViewModel = sagaHeaderViewModel
        
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as! GameTableViewCell
        
        let sagaHeaderViewModels = viewModel?.getSagaHeaderViewModels()
        let sagaId = sagaHeaderViewModels?[indexPath.section].id ?? 0
        let gameCellViewModels = viewModel?.getSagaGameCellViewModels(sagaId: sagaId)
        let gameCellViewModel = gameCellViewModels?[indexPath.row]
        cell.gameCellViewModel = gameCellViewModel
        
        cell.selectionStyle = .none
        
        return cell
    }
}
