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
    
    init(game: GameResponse,
         platform: PlatformResponse?,
         state: StateResponse?) {
        self.game = game
        self.platform = platform
        self.state = state
    }
    
    var id: Int64 {
        get {
            return game.id
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
    
    var stateName: String {
        get {
            return state?.name ?? ""
        }
    }
    
    var imageUrl: String {
        get {
            return game.imageUrl ?? ""
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
}
