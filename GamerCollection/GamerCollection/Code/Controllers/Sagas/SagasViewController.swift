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
    }
}

// MARK: - UITableViewDataSource

extension SagasViewController:  UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let gameCellViewModelsCount = 0
        ivEmptyList.image = gameCellViewModelsCount != 0 ? nil : UIImage(named: "sagas image")
        lbEmptyList.attributedText = gameCellViewModelsCount != 0 ? nil : NSAttributedString(string: "EMPTY_LIST".localized(),
                                                                                             attributes: [.font : UIFont.bold24,
                                                                                                          .foregroundColor: Color.color2])
        return gameCellViewModelsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as! GameTableViewCell
        
//        let gameCellViewModels = viewModel?.getGameCellViewModels()
//        let gameCellViewModel = gameCellViewModels?[indexPath.row]
//        cell.gameCellViewModel = gameCellViewModel
        
        cell.selectionStyle = .none
        
        return cell
    }
}
