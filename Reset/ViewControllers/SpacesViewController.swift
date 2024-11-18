//
//  SpacesViewController.swift
//  Reset
//
//  Created by Prasanjit Panda on 14/11/24.
//

import UIKit

class SpacesViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    let mockMilestoneEvents: [SpacesModel] = [
        SpacesModel(
            title: "Celebrating Milestones: Big and Small",
            hostedBy: "SoberWarrior42",
            description: "Open mic for sharing recovery victories",
            listeners: 83,
            duration: "Live for 45 mins",
            speakers: [mockUsers[0],mockUsers[1],mockUsers[2]]
        ),
        SpacesModel(
            title: "Breaking Chains Together",
            hostedBy: "FreedomLover88",
            description: "Sharing strategies for overcoming addiction",
            listeners: 120,
            duration: "Live for 30 mins",
            speakers: [mockUsers[2],mockUsers[3],mockUsers[4]]
            
        ),
        SpacesModel(
            title: "Path to Freedom",
            hostedBy: "HopeBringer73",
            description: "Stories of hope and resilience",
            listeners: 95,
            duration: "Live for 60 mins",
            speakers: [mockUsers[3],mockUsers[1]]
        ),
        SpacesModel(
            title: "Every Step Counts",
            hostedBy: "JourneySeeker21",
            description: "Celebrating small wins in sobriety",
            listeners: 76,
            duration: "Live for 25 mins",
            speakers: [mockUsers[4],mockUsers[1]]
        ),
        SpacesModel(
            title: "Finding Strength in Numbers",
            hostedBy: "RecoveryChampion56",
            description: "Community support and shared experiences",
            listeners: 112,
            duration: "Live for 50 mins",
            speakers: [mockUsers[0],mockUsers[3],mockUsers[4]]
        )
    ]
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        mockMilestoneEvents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpacesCell", for: indexPath) as! SpacesCollectionViewCell
        let space = mockMilestoneEvents[indexPath.row]
        cell.configure(with: space)
        return cell
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width - 40, height: 150) // Adjust height as needed
        layout.minimumLineSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        collectionView.collectionViewLayout = layout
        
        
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let space = mockMilestoneEvents[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "SpaceDetailViewController") as? SpaceDetailViewController else { return }
           
           // Pass the selected space details
        vc.space = space
        vc.modalPresentationStyle = .pageSheet
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
            sheet.prefersScrollingExpandsWhenScrolledToEdge = true
            sheet.prefersEdgeAttachedInCompactHeight = true
        }
        present(vc,animated: true)
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
