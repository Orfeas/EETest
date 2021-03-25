//
//  TopFootballTeamTests.swift
//  FootballLeague
//
//  Created by Orfeas Iliopoulos on 23/3/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import XCTest
@testable import FootballLeague

class TopFootballTeamTests: XCTestCase {
    var moduleView: TopFootballTeamView?
    let mockView = MockTopFootballTeamView()
    let mockPresenter = MockTopFootballTeamPresenter()
    let mockInteractor = MockTopFootballTeamInteractor()
    let mockWireframe = MockTopFootballTeamWireframe()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        moduleView = TopFootballTeamWireframe.createTopFootballTeamModule() as? TopFootballTeamView
        
        XCTAssertNotNil(moduleView)
        
        _ = moduleView!.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_Module_ViperComponents_Setup() {
        XCTAssertTrue(moduleView?.presenter is TopFootballTeamPresenter)
        XCTAssertTrue(moduleView?.presenter?.view is TopFootballTeamView)
        XCTAssertTrue(moduleView?.presenter?.interactor is TopFootballTeamInteractor)
        XCTAssertTrue(moduleView?.presenter?.wireframe is TopFootballTeamWireframe)
        XCTAssertTrue(moduleView?.presenter?.interactor?.presenter is TopFootballTeamPresenter)
    }

    func test_View_Outlets_NotNil_onViewDidLoad() throws {
        let view = try XCTUnwrap(moduleView)

        XCTAssertNotNil(view.tableView)
        XCTAssertTrue(view.tableView.delegate is TopFootballTeamView)
        XCTAssertTrue(view.tableView.dataSource is TopFootballTeamView)

    }
    
    func test_View_SetupUI() throws {
        let view = try XCTUnwrap(moduleView)
        let navigationItem = try XCTUnwrap(moduleView?.navigationItem)

        XCTAssertEqual(view.navigationItem.title, "Top Football Team")
        XCTAssertNotNil(navigationItem.rightBarButtonItem)
    }
    
    func test_DidGetStandings_TeamView_Updated() throws {
        let view = try XCTUnwrap(moduleView)
        
        //Create a dummy Standing object
        let topTeam = Team(id: 0, name: "Team Name", crestUrl: "", score: 1)
        let secondTeam = Team(id: 1, name: "Team Name", crestUrl: "", score: 0)

        view.teams = [topTeam, secondTeam]
        
        view.tableView.reloadData()
        
        XCTAssertEqual(view.tableView.numberOfRows(inSection: 0), 2)
        
        let topCell = try XCTUnwrap(view.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? TeamTableViewCell)

        XCTAssertNotNil(topCell)
        XCTAssertEqual(topCell.selectionStyle, UITableViewCell.SelectionStyle.none)
        XCTAssertEqual(topCell.teamLabel.text, "Team Name")
        let topTeamScore = try XCTUnwrap(topTeam.score)
        XCTAssertEqual(topCell.detailsLabel.text, "Won \(topTeamScore) games!")
        
        let secondaryCell = try XCTUnwrap(view.tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? TeamTableViewCell)

        XCTAssertNotNil(secondaryCell)
        XCTAssertEqual(secondaryCell.selectionStyle, UITableViewCell.SelectionStyle.none)
        XCTAssertEqual(secondaryCell.teamLabel.text, "Team Name")
        
        let secondTeamScore = try XCTUnwrap(secondTeam.score)

        XCTAssertEqual(secondaryCell.detailsLabel.text, "Won \(secondTeamScore) games!")

    }
    
    func test_GetMatches_API() {
        var didGetMatches = false

        let expectation = self.expectation(description: "GetMatches")

        MatchesAPIServices.getMatches { matches in
            didGetMatches = true
            expectation.fulfill()
        } failure: { error in
            didGetMatches = false
            expectation.fulfill()
        }

        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue(didGetMatches)

    }
    
    func test_GetTeam_API() {
        var didGetTeam = false

        let expectation = self.expectation(description: "GetTeam")

        MatchesAPIServices.getTeamForId(teamId: "65") { team in
            didGetTeam = true
            expectation.fulfill()
        } failure: { error in
            didGetTeam = false
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue(didGetTeam)

    }
    
}

// MARK: - Integration tests
extension TopFootballTeamTests {
    func test_Viper_Integration() throws {
        let view = try XCTUnwrap(moduleView)
        view.presenter = mockPresenter
        view.presenter?.view = mockView
        view.presenter?.interactor = mockInteractor
        view.presenter?.interactor?.presenter = mockPresenter
        view.getStandings()
        
        XCTAssertTrue(mockInteractor.didGetMatches)
        XCTAssertTrue(mockPresenter.didGetMatches)
    }
}

// MARK: - Mock classes
class MockTopFootballTeamView: TopFootballTeamViewProtocol {
    
    var presenter: TopFootballTeamPresenterProtocol?
    
    var didGetTeams = false
        
    func didGetTeams(teams: Teams) {
        didGetTeams = true
    }

    func didFailWithError(error: APIError?) {}
}

class MockTopFootballTeamPresenter: TopFootballTeamPresenterProtocol, TopFootballTeamInteractorOutputProtocol {
    
    var view: TopFootballTeamViewProtocol?
    var interactor: TopFootballTeamInteractorInputProtocol?
    var wireframe: TopFootballTeamWireframeProtocol?
    
    var didGetMatches = false
    
    func getMatches() {
        interactor?.getMatches()
    }
    
    
    func didGetMatches(matches: Matches) {
        didGetMatches = true
    }

    func didFailWithError(error: APIError?) {}

}

class MockTopFootballTeamInteractor: TopFootballTeamInteractorInputProtocol {
    var presenter: TopFootballTeamInteractorOutputProtocol?
    var didGetMatches = false
    
    func getMatches() {
        didGetMatches = true
        presenter?.didGetMatches(matches: Matches())
    }

}

class MockTopFootballTeamWireframe: TopFootballTeamWireframeProtocol {
    static func createTopFootballTeamModule() -> UIViewController {
        return UIViewController()
    }
}
