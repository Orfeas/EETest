//
//  RootNavigationPresenter.swift
//  FootballLeague
//
//  Created by Orfeas Iliopoulos on 23/3/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

class RootNavigationPresenter: RootNavigationPresenterProtocol {
    weak var view: RootNavigationViewProtocol?
    var interactor: RootNavigationInteractorInputProtocol?
    var wireframe: RootNavigationWireframeProtocol?
}

extension RootNavigationPresenter: RootNavigationInteractorOutputProtocol {
    
}
