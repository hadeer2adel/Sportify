//
//  TeamDetailsViewController.swift
//  Sportify
//
//  Created by AhmedAbuFoda on 18/05/2024.
//

import UIKit

class TeamDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var coachName: UILabel!
    @IBOutlet weak var playerTable: UITableView!
    
    var team : Team?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modifyNavigationBar()
        playerTable.register(UINib(nibName: "PlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "PlayerCell")
        playerTable.estimatedRowHeight = 100
        playerTable.rowHeight = UITableView.automaticDimension
            
        self.playerTable.dataSource = self
        self.playerTable.delegate = self
        
        
        if let teamImageString = team?.team_logo, let logoURL = URL(string: teamImageString) {
            teamImage.kf.setImage(with: logoURL, placeholder: UIImage(named: "Cup"))
        } else {
            teamImage.image = UIImage(named: "Cup")
        }
        teamName.text = team?.team_name
        coachName.text = team?.coaches?[0].coach_name

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return team?.players?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as! PlayerTableViewCell
        cell.playerName.text = team?.players?[indexPath.row].player_name
        let number = team?.players?[indexPath.row].player_number
        if (number != "") {
            cell.playerNumber.text = "No: " + number!
        }else{
            cell.playerNumber.text = ""
        }
        let age = team?.players?[indexPath.row].player_age
        if (age != "") {
            cell.playerAge.text = age! + " yrs"
        }else{
            cell.playerAge.text = ""
        }
        if let imageString = team?.players?[indexPath.row].player_image, let logoURL = URL(string: imageString) {
            cell.playerImage.kf.setImage(with: logoURL, placeholder: UIImage(named: "playerAvatar"))
        } else {
            cell.playerImage.image = UIImage(named: "playerAvatar")
        }
        cell.playerImage.layer.cornerRadius = cell.playerImage.bounds.width / 2
        cell.playerImage.clipsToBounds = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 100
    }
    
    private func modifyNavigationBar(){
        navigationItem.backBarButtonItem?.title = "Back"
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
