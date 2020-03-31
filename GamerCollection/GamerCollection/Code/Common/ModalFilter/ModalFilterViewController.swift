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

protocol ModalFilterViewProtocol: BaseViewProtocol {
    /**
     * Add here your methods for communication VIEW_MODEL -> VIEW
     */
    func setPlatforms(platforms: PlatformsResponse)
    func setGenres(genres: GenresResponse)
    func setFormats(formats: FormatsResponse)
    func closePopup()
}

protocol ModalFilterConfigurableViewProtocol: class {
    
    func set(viewModel: ModalFilterViewModelProtocol)
    
}

class ModalFilterViewController: BaseViewController {
    
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
        
        view.backgroundColor = .clear
        scrollView = svFilters
        configViews()
        viewModel?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        registerKeyboardNotifications()
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.animatedDarkenBackground()
        }
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
        closePopup()
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
        vwMaxScore.rating = 10
        
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
            if let button = view as? UIButton, button.isSelected {
                platforms.append(button.titleLabel?.text)
            }
        }
        
        var genres = [String?]()
        for view in svGenres.arrangedSubviews {
            if let button = view as? UIButton, button.isSelected {
                genres.append(button.titleLabel?.text)
            }
        }
        
        var formats = [String?]()
        for view in svFormats.arrangedSubviews {
            if let button = view as? UIButton, button.isSelected {
                formats.append(button.titleLabel?.text)
            }
        }
        
        let minScore = vwMinScore.rating
        let maxScore = vwMaxScore.rating
        
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
        
        print(platforms)
        print(genres)
        print(formats)
        print(minScore)
        print(maxScore)
        print(minReleaseDate)
        print(maxReleaseDate)
        print(minPurchaseDate)
        print(maxPurchaseDate)
        print(minPrice)
        print(maxPrice)
        print(isGoty)
        print(isLoaned)
        print(hasSaga)
        print(hasSongs)
        
        closePopup()
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
}

// MARK: - ModalFilterViewProtocol

extension ModalFilterViewController:  ModalFilterViewProtocol {
    
    func setPlatforms(platforms: PlatformsResponse) {
        
        var button: RoundLabelButton
        for platform in platforms {
            
            button = getRoundLabelButton(title: platform.name)
            svPlatforms.addArrangedSubview(button)
        }
    }
    
    func setGenres(genres: GenresResponse) {
        
        var button: RoundLabelButton
        for genre in genres {
            
            button = getRoundLabelButton(title: genre.name)
            svGenres.addArrangedSubview(button)
        }
    }
    
    func setFormats(formats: FormatsResponse) {
        
        var button: RoundLabelButton
        for format in formats {
            
            button = getRoundLabelButton(title: format.name)
            svFormats.addArrangedSubview(button)
        }
    }
    
    func closePopup() {
        
        animatedClearBackground()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.hidePopup()
        }
    }
}

// MARK: - ModalFilterViewProtocol

extension ModalFilterViewController:  ModalFilterConfigurableViewProtocol {
    
    func set(viewModel: ModalFilterViewModelProtocol) {
        self.viewModel = viewModel
    }
}
