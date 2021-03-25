//
//  TopFootballTeamProtocols.swift
//  FootballLeague
//
//  Created by Orfeas Iliopoulos on 23/3/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
import UIKit

protocol TopFootballTeamViewProtocol: class {
    func didGetTeams(teams: Teams)
    func didFailWithError(error: APIError?)
}

protocol TopFootballTeamPresenterProtocol: class {
    var view: TopFootballTeamViewProtocol? { get set }
    var interactor: TopFootballTeamInteractorInputProtocol? { get set }
    var wireframe: TopFootballTeamWireframeProtocol? { get set }
    
    func getMatches()
}

protocol TopFootballTeamInteractorInputProtocol: class {
    var presenter: TopFootballTeamInteractorOutputProtocol? { get set }
    
    func getMatches()
}

protocol TopFootballTeamInteractorOutputProtocol: class {
    func didGetMatches(matches: Matches)
    func didFailWithError(error: APIError?)
}

protocol TopFootballTeamWireframeProtocol: class {
    static func createTopFootballTeamModule() -> UIViewController
}
