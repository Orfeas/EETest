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
        let topTeam = Team(id: 0, name: "Team Name", crestUrl: "")
        let secondTeam = Team(id: 1, name: "Team Name", crestUrl: "")

        let topStanding = Standing(team: topTeam, won: 2)
        let secondStanding = Standing(team: secondTeam, won: 2)

        view.standings = [topStanding, secondStanding]
        
        view.tableView.reloadData()
        
        XCTAssertEqual(view.tableView.numberOfRows(inSection: 0), 2)
        
        let topCell = try XCTUnwrap(view.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? TeamTableViewCell)

        XCTAssertNotNil(topCell)
        XCTAssertEqual(topCell.selectionStyle, UITableViewCell.SelectionStyle.none)
        XCTAssertEqual(topCell.teamLabel.text, "Team Name")
        XCTAssertEqual(topCell.detailsLabel.text, "Won \(topStanding.won) games!")
        XCTAssertNotNil(topCell.teamImageView.image)
        
        let secondaryCell = try XCTUnwrap(view.tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? TeamTableViewCell)

        XCTAssertNotNil(secondaryCell)
        XCTAssertEqual(secondaryCell.selectionStyle, UITableViewCell.SelectionStyle.none)
        XCTAssertEqual(secondaryCell.teamLabel.text, "Team Name")
        XCTAssertEqual(secondaryCell.detailsLabel.text, "Won \(secondStanding.won) games!")
        XCTAssertNotNil(secondaryCell.teamImageView.image)

    }
    
    func test_GetStandings_API() {
        var didGetStandings = false

        let expectation = self.expectation(description: "GetStandings")

        StandingsAPIServices.getStandingsForCompetionId(competitionId: "2021") { standingsContext in
            didGetStandings = true
            expectation.fulfill()
        } failure: { error in
            didGetStandings = false
            expectation.fulfill()
        }

        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue(didGetStandings)

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
        
        XCTAssertTrue(mockInteractor.didGetStandings)
        XCTAssertTrue(mockPresenter.didGetStandings)
    }
}

// MARK: - Mock classes
class MockTopFootballTeamView: TopFootballTeamViewProtocol {
    var presenter: TopFootballTeamPresenterProtocol?
    
    var didGetStandings = false
    
    func didGetStandings(standingContext: StandingContext) {
        didGetStandings = true
    }
    
    func didFailWithError(error: APIError?) {}
}

class MockTopFootballTeamPresenter: TopFootballTeamPresenterProtocol, TopFootballTeamInteractorOutputProtocol {
    
    var view: TopFootballTeamViewProtocol?
    var interactor: TopFootballTeamInteractorInputProtocol?
    var wireframe: TopFootballTeamWireframeProtocol?
    
    var didGetStandings = false
    
    func getStandings() {
        interactor?.getStandings()
    }
    
    func didGetStandings(standingsContext: StandingsContext) {
        didGetStandings = true
        view?.didGetStandings(standingContext: standingsContext.first!)
    }

    func didFailWithError(error: APIError?) {}

}

class MockTopFootballTeamInteractor: TopFootballTeamInteractorInputProtocol {
    var presenter: TopFootballTeamInteractorOutputProtocol?
    var didGetStandings = false
    
    func getStandings() {
        didGetStandings = true
        presenter?.didGetStandings(standingsContext: [StandingContext(type: "TOTAL", table: Standings())])
    }

}

class MockTopFootballTeamWireframe: TopFootballTeamWireframeProtocol {
    static func createTopFootballTeamModule() -> UIViewController {
        return UIViewController()
    }
}
