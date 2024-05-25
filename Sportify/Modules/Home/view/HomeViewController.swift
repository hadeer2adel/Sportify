//
//  HomeViewController.swift
//  Sportify
//
//  Created by Hadeer Adel Ahmed on 17/05/2024.
//

import UIKit
import Reachability

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var sportCollectionViewLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var sportCollectionView: UICollectionView!
    var sport = ["Football","Basketball","Tennis","Cricket"]
    var reachability: Reachability!
    override func viewDidLoad() {
        super.viewDidLoad()
        reachability = try! Reachability()
        
        if let flowLayout = sportCollectionViewLayout {
            flowLayout.minimumLineSpacing = 40
            flowLayout.minimumInteritemSpacing = 0
        }
        
        // Do any additional setup after loading the view.
        sportCollectionView.delegate = self
        sportCollectionView.dataSource = self
        sportCollectionView.register(UINib(nibName: "SportCell", bundle: nil), forCellWithReuseIdentifier: "sportCell")
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = sportCollectionView.dequeueReusableCell(withReuseIdentifier: "sportCell", for: indexPath) as! SportCell
    
        
        cell.sportName.text = sport[indexPath.row]
        cell.sportImage.image = UIImage(named: sport[indexPath.row].lowercased())
    
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2.1, height: view.frame.width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if reachability.connection != .unavailable {
            let leagueController = LeaguesViewController()
            leagueController.sport = sport[indexPath.row].lowercased()
            navigationController?.pushViewController(leagueController, animated: true)
        }else{
            let alertFailed = UIAlertController(title: "Error", message: "No Enternet Connection", preferredStyle: .alert)
            let actionOk = UIAlertAction(title: "Ok", style: .destructive, handler: nil)
            alertFailed.addAction(actionOk)
            self.present(alertFailed, animated: true, completion: nil)
        }
    }
}
