//
//  ModalFilterViewController.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 29/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit
import Cosmos
import ActionSheetPicker_3_0

protocol ModalFilterViewProtocol: BaseModalViewProtocol {
    /**
     * Add here your methods for communication VIEW_MODEL -> VIEW
     */
    func setFormats(formats: FormatsResponse)
    func setGenres(genres: GenresResponse)
    func setPlatforms(platforms: PlatformsResponse)
    func configFilters(filters: FiltersModel?)
}

protocol ModalFilterConfigurableViewProtocol: class {
    
    func set(viewModel: ModalFilterViewModelProtocol)
    
}

class ModalFilterViewController: BaseModalViewController {
    
    // MARK: - Public properties
    
    @IBOutlet weak var svFilters: UIScrollView!
    @IBOutlet weak var svPlatforms: UIStackView!
    @IBOutlet weak var svGenres: UIStackView!
    @IBOutlet weak var svFormats: UIStackView!
    @IBOutlet weak var vwMinScore: CosmosView!
    @IBOutlet weak var vwMaxScore: CosmosView!
    @IBOutlet weak var btMinReleaseDate: DropdownButton!
    @IBOutlet weak var btMaxReleaseDate: DropdownButton!
    @IBOutlet weak var btMinPurchaseDate: DropdownButton!
    @IBOutlet weak var btMaxPurchaseDate: DropdownButton!
    @IBOutlet weak var tvMinPrice: UnderlinedTextView!
    @IBOutlet weak var tvMaxPrice: UnderlinedTextView!
    @IBOutlet weak var swGoty: UISwitch!
    @IBOutlet weak var swLoaned: UISwitch!
    @IBOutlet weak var swSaga: UISwitch!
    @IBOutlet weak var swSongs: UISwitch!
    
    // MARK: - Private properties
    
    private var viewModel:ModalFilterViewModelProtocol?
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView = svFilters
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
    
    @IBAction func showDatePickerView(_ sender: UIButton) {
        
        var title = ""
        let format = Locale.current.languageCode == "es" ? Constants.DateFormat.spanish : Constants.DateFormat.english
        var defaultDate = Date()
        var actionDoneBlock: ActionDateDoneBlock = {_,_,_ in }
        
        if sender == btMinReleaseDate {

            title = "GAME_DETAIL_SELECT_DATE".localized()
            defaultDate = self.btMinReleaseDate.value?.toDate(format: format) ?? Date()
            actionDoneBlock = { picker, date, origin in
                
                var value = ""
                if let date = date as? Date {
                    let format = Locale.current.languageCode == "es" ? Constants.DateFormat.spanish : Constants.DateFormat.english
                    value = date.toString(format: format)
                }
                self.btMinReleaseDate.value = value
                return
            }
        } else if sender == btMaxReleaseDate {

            title = "GAME_DETAIL_SELECT_DATE".localized()
            defaultDate = self.btMaxReleaseDate.value?.toDate(format: format) ?? Date()
            actionDoneBlock = { picker, date, origin in
                
                var value = ""
                if let date = date as? Date {
                    let format = Locale.current.languageCode == "es" ? Constants.DateFormat.spanish : Constants.DateFormat.english
                    value = date.toString(format: format)
                }
                self.btMaxReleaseDate.value = value
                return
            }
        } else if sender == btMinPurchaseDate {
            
            title = "GAME_DETAIL_SELECT_DATE".localized()
            defaultDate = self.btMinPurchaseDate.value?.toDate(format: format) ?? Date()
            actionDoneBlock = { picker, date, origin in
                
                var value = ""
                if let date = date as? Date {
                    let format = Locale.current.languageCode == "es" ? Constants.DateFormat.spanish : Constants.DateFormat.english
                    value = date.toString(format: format)
                }
                self.btMinPurchaseDate.value = value
                return
            }
        } else if sender == btMaxPurchaseDate {
            
            title = "GAME_DETAIL_SELECT_DATE".localized()
            defaultDate = self.btMaxPurchaseDate.value?.toDate(format: format) ?? Date()
            actionDoneBlock = { picker, date, origin in
                
                var value = ""
                if let date = date as? Date {
                    let format = Locale.current.languageCode == "es" ? Constants.DateFormat.spanish : Constants.DateFormat.english
                    value = date.toString(format: format)
                }
                self.btMaxPurchaseDate.value = value
                return
            }
        }
        
        ActionSheetDatePicker.show(withTitle: title,
                                   datePickerMode: .date,
                                   selectedDate: defaultDate,
                                   doneBlock: actionDoneBlock,
                                   cancel: { picker in
                                        return
                                   },
                                   origin: sender)
        hideKeyboard()
    }
    
    @IBAction func cancel(_ sender: Any) {
        closePopup(success: {})
    }
    
    @IBAction func reset(_ sender: Any) {
        
        for view in svPlatforms.arrangedSubviews {
            if let button = view as? UIButton {
                button.isSelected = false
            }
        }
        
        for view in svGenres.arrangedSubviews {
            if let button = view as? UIButton {
                button.isSelected = false
            }
        }
        
        for view in svFormats.arrangedSubviews {
            if let button = view as? UIButton {
                button.isSelected = false
            }
        }
        
        vwMinScore.rating = 0
        vwMaxScore.rating = 5
        
        btMinReleaseDate.value = nil
        btMaxReleaseDate.value = nil
        
        btMinPurchaseDate.value = nil
        btMaxPurchaseDate.value = nil
        
        tvMaxPrice.text = nil
        tvMinPrice.text = nil
        
        swGoty.isOn = false
        
        swLoaned.isOn = false
        
        swSaga.isOn = false
        
        swSongs.isOn = false
    }
    
    @IBAction func save(_ sender: Any) {
        
        var platforms = [String?]()
        for view in svPlatforms.arrangedSubviews {
            if let button = view as? RoundLabelButton, button.isSelected {
                platforms.append(button.id)
            }
        }
        
        var genres = [String?]()
        for view in svGenres.arrangedSubviews {
            if let button = view as? RoundLabelButton, button.isSelected {
                genres.append(button.id)
            }
        }
        
        var formats = [String?]()
        for view in svFormats.arrangedSubviews {
            if let button = view as? RoundLabelButton, button.isSelected {
                formats.append(button.id)
            }
        }
        
        let minScore = vwMinScore.rating * 2
        let maxScore = vwMaxScore.rating * 2
        
        let format = Locale.current.languageCode == "es" ? Constants.DateFormat.spanish : Constants.DateFormat.english
        let minReleaseDate = btMinReleaseDate.value?.toDate(format: format)
        let maxReleaseDate = btMaxReleaseDate.value?.toDate(format: format)
        
        let minPurchaseDate = btMinPurchaseDate.value?.toDate(format: format)
        let maxPurchaseDate = btMaxPurchaseDate.value?.toDate(format: format)
        
        let minPrice = Double(tvMinPrice.text ?? "0") ?? 0
        let maxPrice = Double(tvMaxPrice.text ?? "0") ?? 0
        
        let isGoty = swGoty.isOn
        
        let isLoaned = swLoaned.isOn
        
        let hasSaga = swSaga.isOn
        
        let hasSongs = swSongs.isOn
        
        let filters = FiltersModel(platforms: platforms.compactMap({$0}),
                                   genres: genres.compactMap({$0}),
                                   formats: formats.compactMap({$0}),
                                   minScore: minScore,
                                   maxScore: maxScore,
                                   minReleaseDate: minReleaseDate,
                                   maxReleaseDate: maxReleaseDate,
                                   minPurchaseDate: minPurchaseDate,
                                   maxPurchaseDate: maxPurchaseDate,
                                   minPrice: minPrice,
                                   maxPrice: maxPrice,
                                   isGoty: isGoty,
                                   isLoaned: isLoaned,
                                   hasSaga: hasSaga,
                                   hasSongs: hasSongs)
        
        let handler = viewModel?.getHandler()
        close(filters: filters, handler: handler)
    }
    
    @objc func selectButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    // MARK: - Overrides
    
    // MARK: - Private functions

    private func configViews() {
        
        vwMinScore.text = "MIN".localized()
        vwMaxScore.text = "MAX".localized()
        
        btMinReleaseDate.placeholder = "MIN".localized()
        btMaxReleaseDate.placeholder = "MAX".localized()
        
        btMinPurchaseDate.placeholder = "MIN".localized()
        btMaxPurchaseDate.placeholder = "MAX".localized()
        
        tvMinPrice.placeholder = "MIN".localized()
        tvMaxPrice.placeholder = "MAX".localized()
    }
    
    private func getRoundLabelButton(title: String) -> RoundLabelButton {
        
        let button = RoundLabelButton()
        button.setTitle(title, for: UIControl.State())
        button.background = Color.color1
        button.selectedBackground = Color.color2
        button.titleColor = Color.color2
        button.selectedTitleColor = Color.color1
        button.border = Color.color2
        button.addTarget(self, action: #selector(selectButton), for: .touchUpInside)
        return button
    }
    
    private func close(filters: FiltersModel?, handler: ((FiltersModel?) -> Void)?) {
        
        closePopup(success: {
            handler?(filters)
        })
    }
}

// MARK: - ModalFilterViewProtocol

extension ModalFilterViewController:  ModalFilterViewProtocol {
    
    func setFormats(formats: FormatsResponse) {
        
        var button: RoundLabelButton
        for format in formats {
            
            button = getRoundLabelButton(title: format.name)
            button.id = format.id
            svFormats.addArrangedSubview(button)
        }
    }
    
    func setGenres(genres: GenresResponse) {
        
        var button: RoundLabelButton
        for genre in genres {
            
            button = getRoundLabelButton(title: genre.name)
            button.id = genre.id
            svGenres.addArrangedSubview(button)
        }
    }
    
    func setPlatforms(platforms: PlatformsResponse) {
        
        var button: RoundLabelButton
        for platform in platforms {
            
            button = getRoundLabelButton(title: platform.name)
            button.id = platform.id
            svPlatforms.addArrangedSubview(button)
        }
    }
    
    func configFilters(filters: FiltersModel?) {
        
        if let filters = filters {

            let formats = filters.formats
            if !formats.isEmpty {
                for view in svFormats.arrangedSubviews {
                    if let button = view as? RoundLabelButton, formats.first(where: { $0 == button.id }) != nil {
                        button.isSelected = true
                    }
                }
            }

            let genres = filters.genres
            if !genres.isEmpty {
                for view in svGenres.arrangedSubviews {
                    if let button = view as? RoundLabelButton, genres.first(where: { $0 == button.id }) != nil {
                        button.isSelected = true
                    }
                }
            }
            
            let platforms = filters.platforms
            if !platforms.isEmpty {
                for view in svPlatforms.arrangedSubviews {
                    if let button = view as? RoundLabelButton, platforms.first(where: { $0 == button.id }) != nil {
                        button.isSelected = true
                    }
                }
            }
            
            vwMinScore.rating = filters.minScore / 2
            vwMaxScore.rating = filters.maxScore / 2
            
            let format = Locale.current.languageCode == "es" ? Constants.DateFormat.spanish : Constants.DateFormat.english
            if let minReleaseDate = filters.minReleaseDate?.toString(format: format) {
                btMinReleaseDate.value = minReleaseDate
            }
            if let maxReleaseDate = filters.maxReleaseDate?.toString(format: format) {
                btMaxReleaseDate.value = maxReleaseDate
            }
            
            if let minPurchaseDate = filters.minPurchaseDate?.toString(format: format) {
                btMinPurchaseDate.value = minPurchaseDate
            }
            if let maxPurchaseDate = filters.maxPurchaseDate?.toString(format: format) {
                btMaxPurchaseDate.value = maxPurchaseDate
            }
                        
            let minPrice = filters.minPrice
            if minPrice > 0 {
                tvMinPrice.text = "\(minPrice)"
            }
            let maxPrice = filters.maxPrice
            if maxPrice > 0 {
                tvMaxPrice.text = "\(maxPrice)"
            }
            
            swGoty.isOn = filters.isGoty
            swLoaned.isOn = filters.isLoaned
            swSaga.isOn = filters.hasSaga
            swSongs.isOn = filters.hasSongs
        }
    }
}

// MARK: - ModalFilterViewProtocol

extension ModalFilterViewController:  ModalFilterConfigurableViewProtocol {
    
    func set(viewModel: ModalFilterViewModelProtocol) {
        self.viewModel = viewModel
    }
}
