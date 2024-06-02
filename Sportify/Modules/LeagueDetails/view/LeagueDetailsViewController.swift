//
//  LeagueDetailsViewController.swift
//  Sportify
//
//  Created by Hadeer Adel Ahmed on 18/05/2024.
//

import UIKit
import Kingfisher

class LeagueDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var viewModel: LeagueDetailsViewModel?
    var league: FavLeagues?

    private var isHeartFilled = false
    private var heartButton: UIBarButtonItem!
    
    private var indicator : UIActivityIndicatorView?

    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModel()
        isHeartFilled = viewModel!.isSportFavorited(leagueID: league!.id!)
        
        modifyNavigationBar()
        setupCollectionView()
        
        indicator = UIActivityIndicatorView(style: .medium)
        indicator!.center = view.center
        indicator!.startAnimating()
        view.addSubview(indicator!)
        
        viewModel?.getUpComingEvents(sportType: (league?.sport)!, leagueId: (league?.id)!)
        viewModel?.getLatestResults(sportType: (league?.sport)!, leagueId: (league?.id)!)
        viewModel?.getTeams(sportType: (league?.sport)!, leagueId: (league?.id)!)

    }
    
    private func modifyNavigationBar(){
        navigationItem.backBarButtonItem?.title = "Back"
        navigationItem.title = "League Details"
        
        let imageName = isHeartFilled ? "heart.fill" : "heart"
        heartButton = UIBarButtonItem(image: UIImage(systemName: imageName), style: .plain, target: self, action: #selector(heartButtonTapped))
        navigationItem.rightBarButtonItem = heartButton
    }
    @objc func heartButtonTapped() {
        isHeartFilled.toggle()
        
        if isHeartFilled {
            makeAlert(title: "Insert"){ [weak self] in
                self?.heartButton.image = UIImage(systemName: "heart.fill")
                self?.viewModel?.addToFavourite(league: (self?.league)!)
            }
        } else {
            makeAlert(title: "Delete"){ [weak self] in
                guard let self = self else { return }
                self.heartButton.image = UIImage(systemName: "heart")
                self.viewModel?.deleteFromFavourite(leagueID: (self.league?.id)!)
            }
        }
   }
    
    private func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "HeaderCollectionView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.register(UINib(nibName: "EventCell", bundle: nil), forCellWithReuseIdentifier: "eventCell")
        collectionView.register(UINib(nibName: "TeamCell", bundle: nil), forCellWithReuseIdentifier: "teamCell")
        collectionView.register(UINib(nibName: "NoDataCell", bundle: nil), forCellWithReuseIdentifier: "noDataCell")
        
        let layout = UICollectionViewCompositionalLayout {sectionIndex,enviroment in
            switch sectionIndex {
            case 0 :
                return self.upComingSection()
            case 1 :
                return self.latestSection()
            default:
                return self.teamSection()
            }
        }
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    private func setupViewModel(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        viewModel = LeagueDetailsViewModel(cachingManager: CachingManager(), appDelegate: appDelegate)
        
        viewModel?.bindUpComingEventsToViewController = { [weak self] in
            DispatchQueue.main.async {
                self?.indicator?.stopAnimating ()
                self?.collectionView.reloadData()
            }
        }
        viewModel?.bindLatestResultsToViewController = { [weak self] in
            DispatchQueue.main.async {
                self?.indicator?.stopAnimating ()
                self?.collectionView.reloadData()
            }
        }
        viewModel?.bindTeamsToViewController = { [weak self] in
            DispatchQueue.main.async {
                self?.indicator?.stopAnimating ()
                self?.collectionView.reloadData()
            }
        }
    }
    
    private func upComingSection()-> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85), heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 4)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 40, trailing: 8)
        section.orthogonalScrollingBehavior = .continuous
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        section.boundarySupplementaryItems = [header]
        
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
            items.forEach { item in
                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                let minScale: CGFloat = 0.8
                let maxScale: CGFloat = 1.0
                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
        
        return section
    }
    
    private func latestSection()-> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalWidth(0.4))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 32, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 8, bottom: 40, trailing: 8)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        section.boundarySupplementaryItems = [header]

        return section
    }
    
    private func teamSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 12)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 8, bottom: 40, trailing: 8)
        
        section.orthogonalScrollingBehavior = .continuous
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        section.boundarySupplementaryItems = [header]

        return section
    }

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch(section){
        case 0:
            return viewModel?.upComingEvents?.count ?? 1
        case 1:
            return viewModel?.latestResults?.count ?? 1
        default :
            return viewModel?.teams?.count ?? 1
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            if viewModel?.upComingEvents == nil {
                return collectionView.dequeueReusableCell(withReuseIdentifier: "noDataCell", for: indexPath) as! NoDataCell
            }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as! EventCell
            cell.layer.borderColor = UIColor.systemBlue.cgColor
            let data = viewModel!.upComingEvents![indexPath.row]
            cell.score.text = "VS"
            return setDataOnCell(data: data, cell: cell)
            
        }
        else if indexPath.section == 1 {
            if viewModel?.latestResults == nil {
                return collectionView.dequeueReusableCell(withReuseIdentifier: "noDataCell", for: indexPath) as! NoDataCell
            }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as! EventCell
            cell.layer.borderColor = UIColor.darkGray.cgColor
            let data = viewModel!.latestResults![indexPath.row]
            cell.score.text = data.event_final_result
            if league?.sport == "cricket" {
                cell.score.text = (data.event_home_final_result ?? "0") + " - " + (data.event_away_final_result ?? "0")
            }
            return setDataOnCell(data: data, cell: cell)

        }
        else {
            if viewModel?.teams == nil {
                return collectionView.dequeueReusableCell(withReuseIdentifier: "noDataCell", for: indexPath) as! NoDataCell
            }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath) as! TeamCell
            
            if let logoString = viewModel?.teams?[indexPath.row].team_logo, let logoURL = URL(string: logoString) {
                cell.teamImage.kf.setImage(with: logoURL, placeholder: UIImage(named: "TeamLogo"))
            } else {
                cell.teamImage.image = UIImage(named: "TeamLogo")
            }
            cell.teamImage.layer.cornerRadius = cell.teamImage.bounds.width / 2
            cell.teamImage.clipsToBounds = true
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! HeaderCollectionView
        switch indexPath.section {
        case 0:
            header.title.text = "UpComing Events"
            break
        case 1:
            header.title.text = "Latest Results"
            break
        default:
            header.title.text = "Teams"
            break
        }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(indexPath.section == 2 && viewModel?.teams != nil){
            let teamDetailsController = TeamDetailsViewController();
            teamDetailsController.team = viewModel?.teams?[indexPath.row]
            teamDetailsController.modalPresentationStyle = .fullScreen
            present(teamDetailsController, animated: true)
            //navigationController?.pushViewController(teamDetailsController, animated: true)
        }
    }
    
    private func setDataOnCell(data: Fixture, cell: EventCell) -> EventCell{
        
        cell.date.text = data.event_date
        if league?.sport == "cricket" {
            cell.date.text = data.event_date_start
        }
        cell.time.text = data.event_time
        
        cell.teamName_1.text = data.event_home_team
        cell.teamName_2.text = data.event_away_team
        if league?.sport == "tennis" {
            cell.teamName_1.text = data.event_first_player
            cell.teamName_2.text = data.event_second_player
        }
        var image1 = data.home_team_logo
        var image2 = data.away_team_logo
        if league?.sport == "basketball" || league?.sport == "cricket" {
            image1 = data.event_home_team_logo
            image2 = data.event_away_team_logo
        }
        else if league?.sport == "tennis" {
            image1 = data.event_first_player_logo
            image2 = data.event_second_player_logo
        }
        if let logoString1 = image1, let logoURL1 = URL(string: logoString1) {
            cell.teamImage_1.kf.setImage(with: logoURL1, placeholder: UIImage(named: "TeamLogo"))
        } else {
            cell.teamImage_1.image = UIImage(named: "TeamLogo")
        }
        if let logoString2 = image2, let logoURL2 = URL(string: logoString2) {
            cell.teamImage_2.kf.setImage(with: logoURL2, placeholder: UIImage(named: "TeamLogo"))
        } else {
            cell.teamImage_2.image = UIImage(named: "TeamLogo")
        }
        
        return cell
    }
    
    func makeAlert(title: String, action: @escaping ()->Void) {
        let alertFailed = UIAlertController(title: title, message: "Are you sure you want to \(title.lowercased()) this item?", preferredStyle: .alert)
        let actionNo = UIAlertAction(title: "NO", style: .default, handler: nil)

        let actionOk = UIAlertAction(title: "OK", style: .default) { _ in
            action()
        }
        alertFailed.addAction(actionNo)
        alertFailed.addAction(actionOk)
        self.present(alertFailed, animated: true, completion: nil)
    }

}
