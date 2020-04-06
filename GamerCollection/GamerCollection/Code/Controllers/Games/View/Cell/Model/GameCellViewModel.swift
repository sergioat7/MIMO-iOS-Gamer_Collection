//
//  GameCellViewModel.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 21/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

class GameCellViewModel {

    private let game: GameResponse
    private let platform: PlatformResponse?
    private let state: StateResponse?
    private let selectable: Bool?
    
    init(game: GameResponse,
         platform: PlatformResponse?,
         state: StateResponse?,
         selectable: Bool? = false) {
        self.game = game
        self.platform = platform
        self.state = state
        self.selectable = selectable
    }
    
    var id: Int64 {
        get {
            return game.id
        }
    }
    
    var imageUrl: String {
        get {
            return game.imageUrl ?? ""
        }
    }
    
    var name: String {
        get {
            return game.name ?? ""
        }
    }
    
    var platformName: String {
        get {
            return platform?.name ?? ""
        }
    }
    
    var releaseDate: String {
        get {
            return game.releaseDate ?? ""
        }
    }
    
    var score: Double {
        get {
            return game.score
        }
    }
    
    var isGoty: Bool {
        get {
            return game.goty
        }
    }
    
    var stateId: String {
        get {
            return state?.id ?? ""
        }
    }
    
    var isLoaned: Bool {
        get {
            if let loanedTo = game.loanedTo {
                return !loanedTo.isEmpty
            } else {
                return false
            }
        }
    }
    
    var sagaId: Int64? {
        get {
            return game.saga?.id
        }
    }
    
    var isSelectable: Bool? {
        get {
            return selectable
        }
    }
    
    var isSelected = false
}
