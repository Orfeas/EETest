//
//  RootNavigationView.swift
//  FootballLeague
//
//  Created by Orfeas Iliopoulos on 23/3/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

class RootNavigationView: UINavigationController {
    
    //MARK: - Variables
    var presenter: RootNavigationPresenterProtocol?
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let topFootballView = TopFootballTeamWireframe.createTopFootballTeamModule()
        
        setViewControllers([topFootballView], animated: true)
    }
}

extension RootNavigationView {
    //MARK: - IBActions

}

extension RootNavigationView: RootNavigationViewProtocol {
    
}
