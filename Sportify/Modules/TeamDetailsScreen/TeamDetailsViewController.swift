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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        teamImage.image = UIImage(named: "Alahly")
        teamName.text = "Al Ahly"
        coachName.text = "Coach : Marcel Koller"
        
        playerTable.register(UINib(nibName: "PlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "PlayerCell")
        playerTable.estimatedRowHeight = 100
        playerTable.rowHeight = UITableView.automaticDimension
            
        self.playerTable.dataSource = self
        self.playerTable.delegate = self

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as! PlayerTableViewCell
        cell.playerName.text="Ali Maaloul"
        cell.playerNumber.text = "21"
        cell.playerAge.text = "34 yrs"
        cell.playerImage.image = UIImage(named: "AliMaaloul")
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
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
