//
//  TopFootballTeamPresenter.swift
//  FootballLeague
//
//  Created by Orfeas Iliopoulos on 23/3/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

class TopFootballTeamPresenter: TopFootballTeamPresenterProtocol {
    weak var view: TopFootballTeamViewProtocol?
    var interactor: TopFootballTeamInteractorInputProtocol?
    var wireframe: TopFootballTeamWireframeProtocol?
    
    func getStandings() {
        interactor?.getStandings()
    }
    
    func getTotalStanding(standingsContext: StandingsContext) -> StandingContext? {
        
        return standingsContext.first(where: { $0.type == "TOTAL" })
    }
}

extension TopFootballTeamPresenter: TopFootballTeamInteractorOutputProtocol {
    func didGetStandings(standingsContext: StandingsContext) {
        
        if let totalStanding = getTotalStanding(standingsContext: standingsContext) {
            view?.didGetStandings(standingContext: totalStanding)
        }
    }
    
    func didFailWithError(error: APIError?) {
        view?.didFailWithError(error: error)
    }
}
