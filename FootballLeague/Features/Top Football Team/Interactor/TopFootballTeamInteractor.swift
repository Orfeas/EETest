//
//  TopFootballTeamInteractor.swift
//  FootballLeague
//
//  Created by Orfeas Iliopoulos on 23/3/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

class TopFootballTeamInteractor: TopFootballTeamInteractorInputProtocol {
    weak var presenter: TopFootballTeamInteractorOutputProtocol?
    
    func getMatches() {
        MatchesAPIServices.getMatches {[weak self] matches in
            self?.presenter?.didGetMatches(matches: matches)
        } failure: {[weak self] error in
            self?.presenter?.didFailWithError(error: error)
        }
    }
}
