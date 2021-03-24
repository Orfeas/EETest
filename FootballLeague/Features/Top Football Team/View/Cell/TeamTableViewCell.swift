//
//  TeamTableViewCell.swift
//  FootballLeague
//
//  Created by Orfeas Iliopoulos on 23/3/21.
//

import UIKit
import SVGKit

class TeamTableViewCell: UITableViewCell {

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
    
    func populateWithStanding(standing: Standing) {
        teamLabel.text = standing.team.name
        detailsLabel.text = "Won \(standing.won) games!"
        
        guard let imageUrl = standing.team.imageUrl else {
            teamImageView.image = UIImage(named: "logo-football-league")
            
            return
        }
        
        teamImageView.downloadedsvg(from: imageUrl)
    }

}
