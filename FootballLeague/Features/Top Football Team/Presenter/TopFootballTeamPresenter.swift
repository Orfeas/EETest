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
    
    func getMatches() {
        interactor?.getMatches()
    }
    
    func getTopTeams(fromMatches matches: Matches) -> Teams {
        
        let uniqueHomeTeams = matches.unique{ $0.homeTeam.id}.compactMap { match -> Team in
            return match.homeTeamWithScore
        }
        let uniqueAwayTeams = matches.unique{ $0.awayTeam.id}.compactMap { match -> Team in
            return match.homeTeamWithScore
        }
        let uniqueTeams = (uniqueHomeTeams + uniqueAwayTeams).unique{ $0.id}
        
        var topTeams = Teams()
        
        for team in uniqueTeams {
            var tempTeam = Team(id: team.id, name: team.name)
            tempTeam.score = team.score
            
            
            matches.forEach { match in
                if match.homeTeam.id == team.id {
                    tempTeam.score = (tempTeam.score ?? 0) + (match.homeTeamWithScore.score ?? 0)
                } else if match.awayTeam.id == team.id {
                    tempTeam.score = (tempTeam.score ?? 0) + (match.awayTeamWithScore.score ?? 0)
                }
            }
            
            topTeams.append(tempTeam)
        }
        
        topTeams.sort(by: { (team1, team2) -> Bool in
            
            if team1.score == team2.score {
                return team1.name < team2.name
            }
            
            return team1.score ?? 0 > team2.score ?? 0
        })
        
        return topTeams
    }
    
}

extension TopFootballTeamPresenter: TopFootballTeamInteractorOutputProtocol {
    func didGetMatches(matches: Matches) {
        
        view?.didGetTeams(teams: getTopTeams(fromMatches: matches))
    }
    
    func didFailWithError(error: APIError?) {
        view?.didFailWithError(error: error)
    }
}
