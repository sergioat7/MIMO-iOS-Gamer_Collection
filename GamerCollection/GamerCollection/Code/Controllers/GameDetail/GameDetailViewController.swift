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
    func showData(game: GameResponse?)
    func enableEdition(enable: Bool)
    func getGameData() -> GameResponse
}

protocol GameDetailConfigurableViewProtocol: class {
    
    func set(viewModel: GameDetailViewModelProtocol)
    
}

class GameDetailViewController: BaseViewController {
    
    // MARK: - Public properties
    
    @IBOutlet weak var svDetails: UIScrollView!
    @IBOutlet weak var tvName: UnderlinedTextView!
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
    @IBOutlet weak var tvSaga: UnderlinedTextView!
    
    @IBOutlet weak var btAddSong: UIButton!
    @IBOutlet weak var stvSongs: UIStackView!
    
    // MARK: - Private properties
    
    private var viewModel:GameDetailViewModelProtocol?
    
    private var platforms = PlatformsResponse()
    private var genres = GenresResponse()
    private var formats = FormatsResponse()
    private var states = StatesResponse()
    private var currentGame: GameResponse?
    private var imageUrl: String?
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "GAME_DETAIL".localized()
        scrollView = svDetails
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
    
    @IBAction func selectState(_ sender: UIButton) {
        
        btPending.isSelected = sender == btPending
        btInProgress.isSelected = sender == btInProgress
        btFinished.isSelected = sender == btFinished
    }
    
    @IBAction func addSong(_ sender: Any) {
        viewModel?.showAddSongModal()
    }
    
    @IBAction func deleteGame(_ sender: UIButton) {
        
        showConfirmationDialog(message: "GAME_DETAIL_DELETE_CONFIRMATION".localized(), handler: {
            self.viewModel?.deleteGame()
        }, handlerCancel: nil)
    }
    
    @objc func setImage() {
        
        showAlertWithTextField(handlerAccept: { imageUrl in
            
            self.imageUrl = imageUrl
            if let url = URL(string: imageUrl) {
                self.ivGame.kf.setImage(with: url)
            }
        }, handlerCancel: nil)
    }
    
    // MARK: - Overrides
    
    // MARK: - Private functions
    
    private func configViews() {
        
        tvName.placeholder = "GAME_DETAIL_PLACEHOLDER_NAME".localized()
        tvName.placeholderFont = .bold24
        tvName.textFont = .bold24
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(setImage))
        ivGame.addGestureRecognizer(tapGesture)
        
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
        
        tvSaga.isEnabled = false
    }
    
    private func setScoreLabel(rating: Double) {
        lbScore.attributedText = NSAttributedString(string: "\(rating)",
                                                    attributes: [.font : UIFont.roman16,
                                                                 .foregroundColor: Color.color2])
    }
    
    private func getSongDetail(song: SongResponse) -> SongDetail {
        
        let songDetail = SongDetail()
        songDetail.song = song
        return songDetail
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
    
    func showData(game: GameResponse?) {
        
        currentGame = game
        
        tvName.text = game?.name
        
        imageUrl = game?.imageUrl
        if let image = imageUrl, let imageUrl = URL(string: image) {
            
            ivGame.kf.indicatorType = .activity
            ivGame.kf.setImage(with: imageUrl)
        }
        
        ivGoty.isHidden = !(game?.goty ?? false)
        
        let platform = platforms.first(where: { $0.id == game?.platform })
        btPlatform.value = platform?.name

        if let genreId = game?.genre, let genre = genres.first(where: { $0.id == genreId }) {
            btGenre.value = genre.name
        }
        let genre = genres.first(where: { $0.id == game?.genre })
        btGenre.value = genre?.name

        let format = formats.first(where: { $0.id == game?.format })
        btFormat.value = format?.name

        btReleaseDate.value = game?.releaseDate
        
        vwScore.rating = game?.score ?? 0.0
        lbScore.attributedText = NSAttributedString(string: "\(game?.score ?? 0.0)",
                                                    attributes: [.font : UIFont.roman16,
                                                                 .foregroundColor: Color.color2])
        
        if let stateId = game?.state {
            
            btPending.isSelected = stateId == Constants.State.pending
            btInProgress.isSelected = stateId == Constants.State.inProgress
            btFinished.isSelected = stateId == Constants.State.finished
        }
        
        tvDistributor.text = game?.distributor
        tvDeveloper.text = game?.developer
        btPegi.value = game?.pegi
        tvPlayers.text = game?.players
        tvPrice.text = "\(game?.price ?? 0.0)"
        btPurchaseDate.value = game?.purchaseDate
        tvPurchaseLocation.text = game?.purchaseLocation
        swGoty.isOn = game?.goty ?? false
        tvLoanedTo.text = game?.loanedTo
        tvVideoUrl.text = game?.videoUrl
        tvObservations.text = game?.observations
        tvSaga.text = game?.saga?.name
        
        stvSongs.removeSubviews()
        if let songs = game?.songs {
            for song in songs {
                let songDetail = getSongDetail(song: song)
                stvSongs.addArrangedSubview(songDetail)
            }
        }
        
        view.layoutIfNeeded()
    }
    
    func enableEdition(enable: Bool) {
        
        tvName.isEnabled = enable
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
        
        if currentGame != nil {
            btAddSong.isHidden = !enable
        }
        
        for subview in stvSongs.subviews {
            if let songDetail = subview as? SongDetail {
                songDetail.isEnabled = enable
            }
        }
    }
    
    func getGameData() -> GameResponse {
        
        let id = currentGame?.id ?? 0
        let name = tvName.text
        let platform = platforms.first(where: { $0.name == btPlatform.value })?.id
        let score = vwScore.rating
        let pegi = btPegi.value
        let distributor = tvDistributor.text
        let developer = tvDeveloper.text
        let players = tvPlayers.text
        let releaseDate = btReleaseDate.value
        let goty = swGoty.isOn
        let format = formats.first(where: { $0.name == btFormat.value })?.id
        let genre = genres.first(where: { $0.name == btGenre.value })?.id
        let state = btPending.isSelected ? Constants.State.pending : ( btInProgress.isSelected ? Constants.State.inProgress : ( btFinished.isSelected ? Constants.State.finished : nil ) )
        let purchaseDate = btPurchaseDate.value
        let purchaseLocation = tvPurchaseLocation.text
        let price = Double(tvPrice.text ?? "0") ?? 0
        let imageUrl = self.imageUrl
        let videoUrl = tvVideoUrl.text
        let loanedTo = tvLoanedTo.text
        let observations = tvObservations.text
        let saga = currentGame?.saga
        let songs = currentGame?.songs ?? SongsResponse()
        
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
                                observations: observations,
                                saga: saga,
                                songs: songs)
        
        return game
    }
}

// MARK: - GameDetailViewProtocol

extension GameDetailViewController:  GameDetailConfigurableViewProtocol {
    
    func set(viewModel: GameDetailViewModelProtocol) {
        self.viewModel = viewModel
    }
}

// MARK: - UITextFieldDelegate

extension GameDetailViewController:  UITextFieldDelegate {
    
    
}
