//
//  JoinedSpaceViewController.swift
//  Reset
//
//  Created by Prasanjit Panda on 18/11/24.
//

import UIKit

class JoinedSpaceViewController: UIViewController {

    @IBOutlet weak var spaceTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var space: SpacesModel? // The data to populate the details view
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 60, height: 80)
        collectionView.register(SpeakerCollectionViewCell.nib(),forCellWithReuseIdentifier: SpeakerCollectionViewCell.identifier)
        
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
        
        spaceTitle.text = space?.title
        
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

extension JoinedSpaceViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        space?.speakers.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SpeakerCollectionViewCell.identifier, for: indexPath) as! SpeakerCollectionViewCell
        cell.configure(with: space?.speakers[indexPath.row] ?? User(
            id: user1ID,
            name: "John Doe",
            age: 34,
            memberSince: Date(timeIntervalSince1970: 1577880000), // January 1, 2020
            soberSince: Date(timeIntervalSince1970: 1609502400),  // January 1, 2021
            resets: 2,
            streak: 100,
            bloodGroup: "A+",
            sex: "Male",
            profileImage: "shirts",
            sponsorID: nil,
            friends: [user2ID, user3ID]
        ))
        
        return cell
    }
    
    
}

extension JoinedSpaceViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 80)
    }
}




