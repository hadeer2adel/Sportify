//
//  LeaguesViewController.swift
//  Sportify
//
//  Created by AhmedAbuFoda on 17/05/2024.
//

import UIKit
import Kingfisher

class LeaguesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var leagueTable: UITableView!
    var leagueViewModel: LeagueViewModel?
    var league : [League]?
    var sport : String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        leagueTable.register(UINib(nibName: "LeaguesTableViewCell", bundle: nil), forCellReuseIdentifier: "LeagueCell")
        let word = sport!.prefix(1).uppercased() + sport!.dropFirst() + " Leagues"
        self.title = word
        leagueTable.estimatedRowHeight = 100
        leagueTable.rowHeight = UITableView.automaticDimension
        
        leagueTable.dataSource = self
        leagueTable.delegate = self
        
        leagueViewModel = LeagueViewModel()
        leagueViewModel?.getLeagues(sportType: sport!)
        leagueViewModel?.bindResultToViewController = { [weak self] in
            DispatchQueue.main.async {
                self?.league = self?.leagueViewModel?.league
                self?.leagueTable.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return league?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueCell", for: indexPath) as! LeaguesTableViewCell
        
        cell.leagueName.text = league?[indexPath.row].league_name
        if let logoString = league?[indexPath.row].league_logo, let logoURL = URL(string: logoString) {
            cell.leagueImage.kf.setImage(with: logoURL, placeholder: UIImage(named: "Cup"))
        } else {
            cell.leagueImage.image = UIImage(named: "Cup")
        }
        cell.leagueImage.layer.cornerRadius = cell.leagueImage.bounds.width / 2
        cell.leagueImage.clipsToBounds = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
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
