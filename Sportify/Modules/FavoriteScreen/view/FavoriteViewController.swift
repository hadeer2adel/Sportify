//
//  FavoriteViewController.swift
//  Sportify
//
//  Created by AhmedAbuFoda on 18/05/2024.
//

import UIKit
import Lottie

class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var favoriteTable: UITableView!
    var ainimation: LottieAnimationView!
    var viewModel: FavouriteViewModel?
    var leagues = [FavLeagues]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModel()
        checkData()
        // Do any additional setup after loading the view.
        favoriteTable.register(UINib(nibName: "LeaguesTableViewCell", bundle: nil), forCellReuseIdentifier: "LeagueCell")
        
        favoriteTable.estimatedRowHeight = 100
        favoriteTable.rowHeight = UITableView.automaticDimension
        
        favoriteTable.dataSource = self
        favoriteTable.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupViewModel()
        checkData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagues.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueCell", for: indexPath) as! LeaguesTableViewCell
        
        cell.leagueName.text = leagues[indexPath.row].name
        if let leagueImageString = leagues[indexPath.row].logo, let logoURL = URL(string: leagueImageString) {
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
    
    private func setupViewModel(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        viewModel = FavouriteViewModel(cachingManager: CachingManager(), appDelegate: appDelegate)
        leagues = viewModel?.getFromFavourite() ?? []
        favoriteTable.reloadData()
    }
    
   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alertFailed = UIAlertController(title: "Delete", message: "Are you sure you want to delete this item?", preferredStyle: .alert)
            let actionNo = UIAlertAction(title: "NO", style: .default, handler: nil)

            let actionOk = UIAlertAction(title: "OK", style: .default) { _ in
                let sportToDelete = self.leagues[indexPath.row]
                self.viewModel?.deleteFromFavourite(leagueID: sportToDelete.id ?? "")
                self.leagues.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                self.checkData()
            }
            alertFailed.addAction(actionNo)
            alertFailed.addAction(actionOk)
            self.present(alertFailed, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = LeagueDetailsViewController()
        let league = leagues[indexPath.row]
            
        nextVC.league = FavLeagues(id: String(league.id!), name: league.name, logo: league.logo, sport: league.sport)
        
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    private func checkData(){
        if(leagues.count == 0){
            favoriteTable.isHidden = true
            ainimation = .init(name: "favorite.json")
            ainimation!.frame = view.bounds
            ainimation!.backgroundColor = .white
            ainimation!.contentMode = .center
            ainimation!.loopMode = .loop
            ainimation!.play()
            view.addSubview(ainimation)
        }else{
            if(ainimation != nil){
                ainimation.stop()
                ainimation!.isHidden = true
                favoriteTable.isHidden = false
            }
        }
        
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
