//
//  TopFootballTeamInteractor.swift
//  FootballLeague
//
//  Created by Orfeas Iliopoulos on 23/3/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

class TopFootballTeamInteractor: TopFootballTeamInteractorInputProtocol {
    weak var presenter: TopFootballTeamInteractorOutputProtocol?
    
    func getStandings() {
        StandingsAPIServices.getStandingsForCompetionId(competitionId: "2021") {[weak self] standingsContext in
            self?.presenter?.didGetStandings(standingsContext: standingsContext)
        } failure: {[weak self] error in
            self?.presenter?.didFailWithError(error: error)
        }

    }
}
