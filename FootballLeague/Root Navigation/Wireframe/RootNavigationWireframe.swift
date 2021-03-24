//
//  RootNavigationWireframe.swift
//  FootballLeague
//
//  Created by Orfeas Iliopoulos on 23/3/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
import UIKit

class RootNavigationWireframe:  RootNavigationWireframeProtocol {
    static func createRootNavigationModule() -> UIViewController {
        guard let view = UIStoryboard(name: "RootNavigationView", bundle: nil).instantiateViewController(withIdentifier: "RootNavigationView") as? RootNavigationView else {
            return UIViewController()
        }
        let presenter: RootNavigationPresenterProtocol & RootNavigationInteractorOutputProtocol = RootNavigationPresenter()
        let interactor: RootNavigationInteractorInputProtocol = RootNavigationInteractor()
        let wireframe: RootNavigationWireframeProtocol = RootNavigationWireframe()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        interactor.presenter = presenter
        
        return view
    }
    
}
