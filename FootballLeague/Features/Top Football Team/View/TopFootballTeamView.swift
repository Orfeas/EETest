//
//  TopFootballTeamView.swift
//  FootballLeague
//
//  Created by Orfeas Iliopoulos on 23/3/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit
import SVProgressHUD

class TopFootballTeamView: UIViewController {
        
    //MARK: - Variables
    var presenter: TopFootballTeamPresenterProtocol?
    
    var standings: Standings?
    
    @IBOutlet weak var tableView: UITableView!

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Top Football Team"
        
        setupUI()

        getStandings()
    }
    
    func setupUI() {
        navigationItem.title = "Top Football Team"
        
        let menu: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(getStandings))
        navigationItem.rightBarButtonItem = menu
        
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 250.0
    }
    
    @objc func getStandings() {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show()
        
        presenter?.getStandings()
    }
    
    @objc func reloadStandings() {
        getStandings()
    }
}

extension TopFootballTeamView {
    //MARK: - IBActions

}

extension TopFootballTeamView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return standings?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? UITableView.automaticDimension : 100.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var teamCell = TeamTableViewCell()
        
        guard let standing = standings?[indexPath.row] else {
            return UITableViewCell()
        }
        
        if indexPath.row == 0 {
            teamCell = tableView.dequeueReusableCell(withIdentifier: "topTeamCell") as! TeamTableViewCell
        } else {
            teamCell = tableView.dequeueReusableCell(withIdentifier: "teamCell") as! TeamTableViewCell
        }
        
        teamCell.populateWithStanding(standing: standing)
        teamCell.selectionStyle = .none
        
        return teamCell
    }
    
    
}

extension TopFootballTeamView: TopFootballTeamViewProtocol {
    func didGetStandings(standingContext: StandingContext) {
        SVProgressHUD.dismiss()
        
        standings = standingContext.table
        
        standings?.sort(by: {$0.won > $1.won})
        
        DispatchQueue.main.async {[weak self] in
            self?.tableView.reloadData()
        }
                
    }
    
    func didFailWithError(error: APIError?) {
        SVProgressHUD.dismiss()
        
        DispatchQueue.main.async {[weak self] in
            self?.tableView.isHidden = true
        }
    }
    
    
}
