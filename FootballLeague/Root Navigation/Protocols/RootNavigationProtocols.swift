//
//  RootNavigationProtocols.swift
//  FootballLeague
//
//  Created by Orfeas Iliopoulos on 23/3/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
import UIKit

protocol RootNavigationViewProtocol: class {
    
}

protocol RootNavigationPresenterProtocol: class {
    var view: RootNavigationViewProtocol? { get set }
    var interactor: RootNavigationInteractorInputProtocol? { get set }
    var wireframe: RootNavigationWireframeProtocol? { get set }
}

protocol RootNavigationInteractorInputProtocol: class {
    var presenter: RootNavigationInteractorOutputProtocol? { get set }
}

protocol RootNavigationInteractorOutputProtocol: class {
}

protocol RootNavigationWireframeProtocol: class {
    static func createRootNavigationModule() -> UIViewController
}
