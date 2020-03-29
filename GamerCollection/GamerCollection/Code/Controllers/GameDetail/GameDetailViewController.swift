//
//  GameDetailViewController.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 25/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit
import Kingfisher
import Cosmos
import ActionSheetPicker_3_0

protocol GameDetailViewProtocol: BaseViewProtocol {
    /**
     * Add here your methods for communication VIEW_MODEL -> VIEW
     */
    func showPlatforms(platforms: PlatformsResponse)
    func showGenres(genres: GenresResponse)
    func showFormats(formats: FormatsResponse)
    func showStates(states: StatesResponse)
    func showData(game: GameResponse)
    func enableEdition(enable: Bool)
    func getGameData() -> GameResponse
}

protocol GameDetailConfigurableViewProtocol: class {
    
    func set(viewModel: GameDetailViewModelProtocol)
    
}

class GameDetailViewController: BaseViewController {
    
    // MARK: - Public properties
    
    @IBOutlet weak var svDetails: UIScrollView!
    @IBOutlet weak var tvName: UITextView!
    @IBOutlet weak var ivGame: UIImageView!
    @IBOutlet weak var ivGoty: UIImageView!
    @IBOutlet weak var btPlatform: DropdownButton!
    @IBOutlet weak var btGenre: DropdownButton!
    @IBOutlet weak var btFormat: DropdownButton!
    @IBOutlet weak var btReleaseDate: DropdownButton!
    @IBOutlet weak var vwScore: CosmosView!
    @IBOutlet weak var lbScore: UILabel!
    @IBOutlet weak var btPending: GameFilterButton!
    @IBOutlet weak var btInProgress: GameFilterButton!
    @IBOutlet weak var btFinished: GameFilterButton!
    
    @IBOutlet weak var lbDetailsTitle: UILabel!
    @IBOutlet weak var tvDistributor: UnderlinedTextView!
    @IBOutlet weak var tvDeveloper: UnderlinedTextView!
    @IBOutlet weak var btPegi: DropdownButton!
    @IBOutlet weak var tvPlayers: UnderlinedTextView!
    @IBOutlet weak var tvPrice: UnderlinedTextView!
    @IBOutlet weak var btPurchaseDate: DropdownButton!
    @IBOutlet weak var tvPurchaseLocation: UnderlinedTextView!
    @IBOutlet weak var swGoty: UISwitch!
    @IBOutlet weak var tvLoanedTo: UnderlinedTextView!
    @IBOutlet weak var tvVideoUrl: UnderlinedTextView!
    @IBOutlet weak var tvObservations: UnderlinedTextView!
        
    // MARK: - Private properties
    
    private var viewModel:GameDetailViewModelProtocol?
    
    private var platforms = PlatformsResponse()
    private var genres = GenresResponse()
    private var formats = FormatsResponse()
    private var states = StatesResponse()
    private var gameId:Int64 = 0
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "GAME_DETAIL".localized()
        scrollView = svDetails
        configViews()
        enableEdition(enable: false)
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
    
    @IBAction func showPickerView(_ sender: UIButton) {
        
        var title = ""
        var rows = [Any]()
        var initialSelection = 0
        var actionDoneBlock: ActionStringDoneBlock = {_,_,_ in }
        
        if sender == btPlatform {

            title = "GAME_DETAIL_SELECT_PLATFORM".localized()
            rows = platforms.compactMap({$0.name})
            initialSelection = platforms.firstIndex(where: {$0.name == btPlatform.value}) ?? 0
            actionDoneBlock = { picker, value, index in
                let platform = String(describing: index ?? "")
                self.btPlatform.value = platform
                return
            }
        } else if sender == btGenre {

            title = "GAME_DETAIL_SELECT_GENRE".localized()
            rows = genres.compactMap({$0.name})
            initialSelection = genres.firstIndex(where: {$0.name == btGenre.value}) ?? 0
            actionDoneBlock = { picker, value, index in
            let genre = String(describing: index ?? "")
                self.btGenre.value = genre
                return
            }
        } else if sender == btFormat {

            title = "GAME_DETAIL_SELECT_FORMAT".localized()
            rows = formats.compactMap({$0.name})
            initialSelection = formats.firstIndex(where: {$0.name == btFormat.value}) ?? 0
            actionDoneBlock = { picker, value, index in
            let format = String(describing: index ?? "")
                self.btFormat.value = format
                return
            }
        } else if sender == btPegi {
            
            title = "GAME_DETAIL_SELECT_PEGI".localized()
            let rowsAux = ["+3", "+4", "+6", "+7", "+12", "+16", "+18"]
            rows = rowsAux
            initialSelection = rowsAux.firstIndex(where: {$0 == btPegi.value}) ?? 0
            actionDoneBlock = { picker, value, index in
                let format = String(describing: index ?? "")
                self.btPegi.value = format
                return
            }
        }

        ActionSheetStringPicker.show(withTitle: title,
                                     rows: rows,
                                     initialSelection: initialSelection,
                                     doneBlock: actionDoneBlock,
                                     cancel: { picker in
                                        return
                                     },
                                     origin: sender)
    }
    
    @IBAction func showDatePickerView(_ sender: UIButton) {
        
        var title = ""
        let format = Locale.current.languageCode == "es" ? Constants.DateFormat.spanish : Constants.DateFormat.english
        var defaultDate = Date()
        var actionDoneBlock: ActionDateDoneBlock = {_,_,_ in }
        
        if sender == btReleaseDate {

            title = "GAME_DETAIL_SELECT_DATE".localized()
            defaultDate = self.btReleaseDate.value?.toDate(format: format) ?? Date()
            actionDoneBlock = { picker, date, origin in
                
                var value = ""
                if let date = date as? Date {
                    let format = Locale.current.languageCode == "es" ? Constants.DateFormat.spanish : Constants.DateFormat.english
                    value = date.toString(format: format)
                }
                self.btReleaseDate.value = value
                return
            }
        } else if sender == btPurchaseDate {

            title = "GAME_DETAIL_SELECT_DATE".localized()
            defaultDate = self.btPurchaseDate.value?.toDate(format: format) ?? Date()
            actionDoneBlock = { picker, date, origin in
                
                var value = ""
                if let date = date as? Date {
                    let format = Locale.current.languageCode == "es" ? Constants.DateFormat.spanish : Constants.DateFormat.english
                    value = date.toString(format: format)
                }
                self.btPurchaseDate.value = value
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
    }
    
    func setScoreLabel(rating: Double) {
        lbScore.attributedText = NSAttributedString(string: "\(rating)",
                                                    attributes: [.font : UIFont.roman16,
                                                                 .foregroundColor: Color.color2])
    }
    
    @IBAction func selectState(_ sender: UIButton) {
        
        btPending.isSelected = sender == btPending
        btInProgress.isSelected = sender == btInProgress
        btFinished.isSelected = sender == btFinished
    }
    
    // MARK: - Overrides
    
    // MARK: - Private functions
    
    private func configViews() {
        
        btPlatform.title = "GAME_DETAIL_PLATFORM".localized()
        btGenre.title = "GAME_DETAIL_GENRE".localized()
        btFormat.title = "GAME_DETAIL_FORMAT".localized()
        btReleaseDate.title = "GAME_DETAIL_RELEASE_DATE".localized()
        
        btPlatform.placeholder = "GAME_DETAIL_SELECT_PLATFORM".localized()
        btGenre.placeholder = "GAME_DETAIL_SELECT_GENRE".localized()
        btFormat.placeholder = "GAME_DETAIL_SELECT_FORMAT".localized()
        btReleaseDate.placeholder = "GAME_DETAIL_SELECT_DATE".localized()
        
        vwScore.didFinishTouchingCosmos = setScoreLabel
        
        btPending.title = "GAME_DETAIL_BUTTON_TITLE_PENDING".localized()
        btInProgress.title = "GAME_DETAIL_BUTTON_TITLE_IN_PROGRESS".localized()
        btFinished.title = "GAME_DETAIL_BUTTON_TITLE_FINISHED".localized()
        
        btPending.gameState = Constants.State.pending
        btInProgress.gameState = Constants.State.inProgress
        btFinished.gameState = Constants.State.finished
        
        lbDetailsTitle.attributedText = NSAttributedString(string: "GAME_DETAIL_TITLE".localized(),
                                                           attributes: [.font : UIFont.bold18,
                                                                        .foregroundColor: Color.color2])
        
        tvDistributor.placeholder = "GAME_DETAIL_PLACEHOLDER_DISTRIBUTOR".localized()
        tvDeveloper.placeholder = "GAME_DETAIL_PLACEHOLDER_DEVELOPER".localized()
        btPegi.placeholder = "GAME_DETAIL_SELECT_PEGI".localized()
        tvPlayers.placeholder = "GAME_DETAIL_PLACEHOLDER_PLAYERS".localized()
        tvPrice.placeholder = "GAME_DETAIL_PLACEHOLDER_PRICE".localized()
        btPurchaseDate.placeholder = "GAME_DETAIL_SELECT_DATE".localized()
        tvPurchaseLocation.placeholder = "GAME_DETAIL_PLACEHOLDER_PURCHASE_LOCATION".localized()
        tvLoanedTo.placeholder = "GAME_DETAIL_PLACEHOLDER_LOANED_TO".localized()
        tvVideoUrl.placeholder = "GAME_DETAIL_PLACEHOLDER_VIDEO_URL".localized()
        tvObservations.placeholder = "GAME_DETAIL_PLACEHOLDER_OBSERVATIONS".localized()
    }
    
}

// MARK: - GameDetailViewProtocol

extension GameDetailViewController:  GameDetailViewProtocol {
    
    func showPlatforms(platforms: PlatformsResponse) {
        self.platforms = platforms
    }
    
    func showGenres(genres: GenresResponse) {
        self.genres = genres
    }
    
    func showFormats(formats: FormatsResponse) {
        self.formats = formats
    }
    
    func showStates(states: StatesResponse) {
        self.states = states
    }
    
    func showData(game: GameResponse) {
        
        gameId = game.id
        
        tvName.attributedText = NSAttributedString(string: game.name ?? "",
                                                   attributes: [.font : UIFont.bold24,
                                                                .foregroundColor: Color.color2])
        
        if let image = game.imageUrl, let imageUrl = URL(string: image) {
            
            ivGame.kf.indicatorType = .activity
            ivGame.kf.setImage(with: imageUrl)
        }
        
        ivGoty.isHidden = !game.goty
        
        let platform = platforms.first(where: { $0.id == game.platform })
        btPlatform.value = platform?.name

        if let genreId = game.genre, let genre = genres.first(where: { $0.id == genreId }) {
            btGenre.value = genre.name
        }
        let genre = genres.first(where: { $0.id == game.genre })
        btGenre.value = genre?.name

        let format = formats.first(where: { $0.id == game.format })
        btFormat.value = format?.name

        btReleaseDate.value = game.releaseDate
        
        vwScore.rating = game.score
        lbScore.attributedText = NSAttributedString(string: "\(game.score)",
                                                    attributes: [.font : UIFont.roman16,
                                                                 .foregroundColor: Color.color2])
        
        if let stateId = game.state {
            
            btPending.isSelected = stateId == Constants.State.pending
            btInProgress.isSelected = stateId == Constants.State.inProgress
            btFinished.isSelected = stateId == Constants.State.finished
        }
        
        tvDistributor.text = game.distributor
        tvDeveloper.text = game.developer
        btPegi.value = game.pegi
        tvPlayers.text = game.players
        tvPrice.text = "\(game.price)"
        btPurchaseDate.value = game.purchaseDate
        tvPurchaseLocation.text = game.purchaseLocation
        swGoty.isOn = game.goty
        tvLoanedTo.text = game.loanedTo
        tvVideoUrl.text = game.videoUrl
        tvObservations.text = game.observations
    }
    
    func enableEdition(enable: Bool) {
        
        tvName.isUserInteractionEnabled = enable
        ivGame.isUserInteractionEnabled = enable
        btPlatform.isEnabled = enable
        btGenre.isEnabled = enable
        btFormat.isEnabled = enable
        btReleaseDate.isEnabled = enable
        vwScore.isUserInteractionEnabled = enable
        btPending.isEnabled = enable
        btInProgress.isEnabled = enable
        btFinished.isEnabled = enable
        
        tvDistributor.isEnabled = enable
        tvDeveloper.isEnabled = enable
        btPegi.isEnabled = enable
        tvPlayers.isEnabled = enable
        tvPrice.isEnabled = enable
        btPurchaseDate.isEnabled = enable
        tvPurchaseLocation.isEnabled = enable
        swGoty.isEnabled = enable
        tvLoanedTo.isEnabled = enable
        tvVideoUrl.isEnabled = enable
        tvObservations.isEnabled = enable
    }
    
    func getGameData() -> GameResponse {
        
        let id = gameId
        let name = tvName.text
        let platform = platforms.first(where: { $0.name == btPlatform.value })?.id ?? nil
        let score = vwScore.rating
        let pegi = btPegi.value
        let distributor = tvDistributor.text
        let developer = tvDeveloper.text
        let players = tvPlayers.text
        let releaseDate = btReleaseDate.value
        let goty = swGoty.isOn
        let format = formats.first(where: { $0.name == btFormat.value })?.id ?? nil
        let genre = genres.first(where: { $0.name == btGenre.value })?.id ?? nil
        let state = btPending.isSelected ? Constants.State.pending : ( btInProgress.isSelected ? Constants.State.inProgress : Constants.State.finished )
        let purchaseDate = btPurchaseDate.value
        let purchaseLocation = tvPurchaseLocation.text
        let price = Double(tvPrice.text ?? "0") ?? 0
        let imageUrl: String? = nil //TODO
        let videoUrl = tvVideoUrl.text
        let loanedTo = tvLoanedTo.text
        let observations = tvObservations.text
        
        let game = GameResponse(id: id,
                                name: name,
                                platform: platform,
                                score: score,
                                pegi: pegi,
                                distributor: distributor,
                                developer: developer,
                                players: players,
                                releaseDate: releaseDate,
                                goty: goty,
                                format: format,
                                genre: genre,
                                state: state,
                                purchaseDate: purchaseDate,
                                purchaseLocation: purchaseLocation,
                                price: price,
                                imageUrl: imageUrl,
                                videoUrl: videoUrl,
                                loanedTo: loanedTo,
                                observations: observations)
        
        return game
    }
}

// MARK: - GameDetailViewProtocol

extension GameDetailViewController:  GameDetailConfigurableViewProtocol {
    
    func set(viewModel: GameDetailViewModelProtocol) {
        self.viewModel = viewModel
    }
    
}
