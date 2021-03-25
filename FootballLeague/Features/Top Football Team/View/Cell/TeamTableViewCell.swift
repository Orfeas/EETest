//
//  TeamTableViewCell.swift
//  FootballLeague
//
//  Created by Orfeas Iliopoulos on 23/3/21.
//

import UIKit
import SVGKit

class TeamTableViewCell: UITableViewCell {
    
    var imageDownloadClosure: ((Data) -> Void) = {_ in }
    
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var teamImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populateWithTeam(team: Team) {
        teamLabel.text = team.name
        detailsLabel.text = "Won \(team.score ?? 0) games!"
        teamImageView.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        
        if let imageData = team.imageData {
            teamImageView.image = UIImage(data: imageData)
        } else {
            getCrestForTeam(team: team)
        }
        
    }
    
    private func getCrestForTeam(team: Team) {
        MatchesAPIServices.getTeamForId(teamId: "\(team.id)", success: {[weak self] teamWithCrest in
            guard let imageUrl = teamWithCrest.imageUrl else {
                self?.teamImageView.image = UIImage(named: "logo-football-league")
                return
            }
            self?.teamImageView.downloadedsvg(from: imageUrl, completion: {[weak self] data in
                self?.imageDownloadClosure(data)
            })
            
        }, failure: nil)


    }

}
