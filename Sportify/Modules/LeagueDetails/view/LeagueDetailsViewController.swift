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
    var sport : String?
    var leagueId : String?
    
    private var indicator : UIActivityIndicatorView?

    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "HeaderCollectionView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.register(UINib(nibName: "EventCell", bundle: nil), forCellWithReuseIdentifier: "eventCell")
        collectionView.register(UINib(nibName: "TeamCell", bundle: nil), forCellWithReuseIdentifier: "teamCell")
        
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
        
        
        viewModel = LeagueDetailsViewModel()
        
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
        
        indicator = UIActivityIndicatorView(style: .medium)
        indicator!.center = view.center
        indicator!.startAnimating()
        view.addSubview(indicator!)
        
        viewModel?.getUpComingEvents(sportType: sport!, leagueId: leagueId!)
        viewModel?.getLatestResults(sportType: sport!, leagueId: leagueId!)
        viewModel?.getTeams(sportType: sport!, leagueId: leagueId!)

    }

    func upComingSection()-> NSCollectionLayoutSection {
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
    
    func latestSection()-> NSCollectionLayoutSection {
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
    
    func teamSection() -> NSCollectionLayoutSection {
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
            return viewModel?.upComingEvents?.count ?? 0
        case 1:
            return viewModel?.latestResults?.count ?? 0
        default :
            return viewModel?.teams?.count ?? 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       var cellIdentifier = "eventCell"
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! EventCell
            cell.layer.borderColor = UIColor.systemBlue.cgColor
            cell.score.text = "VS"
            
            let data = viewModel!.upComingEvents![indexPath.row]
            
            cell.date.text = data.event_date
            cell.time.text = data.event_time
            cell.teamName_1.text = data.event_home_team
            cell.teamName_2.text = data.event_away_team
            if let logoString1 = data.home_team_logo, let logoURL1 = URL(string: logoString1) {
                cell.teamImage_1.kf.setImage(with: logoURL1, placeholder: UIImage(named: "TeamLogo"))
            } else {
                cell.teamImage_1.image = UIImage(named: "TeamLogo")
            }
            if let logoString2 = data.away_team_logo, let logoURL2 = URL(string: logoString2) {
                cell.teamImage_2.kf.setImage(with: logoURL2, placeholder: UIImage(named: "TeamLogo"))
            } else {
                cell.teamImage_2.image = UIImage(named: "TeamLogo")
            }
            
            return cell
        }
        else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! EventCell
            cell.layer.borderColor = UIColor.darkGray.cgColor
            
            let data = viewModel!.latestResults![indexPath.row]
            
            cell.date.text = data.event_date
            cell.time.text = data.event_time
            cell.score.text = data.event_final_result
            cell.teamName_1.text = data.event_home_team
            cell.teamName_2.text = data.event_away_team
            
            if let logoString1 = data.home_team_logo, let logoURL1 = URL(string: logoString1) {
                cell.teamImage_1.kf.setImage(with: logoURL1, placeholder: UIImage(named: "TeamLogo"))
            } else {
                cell.teamImage_1.image = UIImage(named: "TeamLogo")
            }
            if let logoString2 = data.away_team_logo, let logoURL2 = URL(string: logoString2) {
                cell.teamImage_2.kf.setImage(with: logoURL2, placeholder: UIImage(named: "TeamLogo"))
            } else {
                cell.teamImage_2.image = UIImage(named: "TeamLogo")
            }
            return cell
        }
        else {
            cellIdentifier = "teamCell"
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! TeamCell
            
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
    
}
