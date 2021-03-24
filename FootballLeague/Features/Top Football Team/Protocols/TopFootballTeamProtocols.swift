//
//  TopFootballTeamProtocols.swift
//  FootballLeague
//
//  Created by Orfeas Iliopoulos on 23/3/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
import UIKit

protocol TopFootballTeamViewProtocol: class {
    func didGetStandings(standingContext: StandingContext)
    func didFailWithError(error: APIError?)
}

protocol TopFootballTeamPresenterProtocol: class {
    var view: TopFootballTeamViewProtocol? { get set }
    var interactor: TopFootballTeamInteractorInputProtocol? { get set }
    var wireframe: TopFootballTeamWireframeProtocol? { get set }
    
    func getStandings()
}

protocol TopFootballTeamInteractorInputProtocol: class {
    var presenter: TopFootballTeamInteractorOutputProtocol? { get set }
    
    func getStandings()
}

protocol TopFootballTeamInteractorOutputProtocol: class {
    func didGetStandings(standingsContext: StandingsContext)
    func didFailWithError(error: APIError?)
}

protocol TopFootballTeamWireframeProtocol: class {
    static func createTopFootballTeamModule() -> UIViewController
}
