//
//  TopFootballTeamWireframe.swift
//  FootballLeague
//
//  Created by Orfeas Iliopoulos on 23/3/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
import UIKit

class TopFootballTeamWireframe:  TopFootballTeamWireframeProtocol {
    static func createTopFootballTeamModule() -> UIViewController {
        guard let view = UIStoryboard(name: "TopFootballTeamView", bundle: nil).instantiateViewController(withIdentifier: "TopFootballTeamView") as? TopFootballTeamView else {
            return UIViewController()
        }
        let presenter: TopFootballTeamPresenterProtocol & TopFootballTeamInteractorOutputProtocol = TopFootballTeamPresenter()
        let interactor: TopFootballTeamInteractorInputProtocol = TopFootballTeamInteractor()
        let wireframe: TopFootballTeamWireframeProtocol = TopFootballTeamWireframe()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        interactor.presenter = presenter
        
        return view
    }
    
}
