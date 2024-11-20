//
//  ProfileViewController.swift
//  Reset
//
//  Created by Prasanjit Panda on 19/11/24.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var bloodGrpLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var userName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        let currentUser = DataManager.shared.getCurrentUser()
        imageView.image = UIImage(named: currentUser!.profileImage)
        userName.text = currentUser!.name
        sexLabel.text = currentUser!.sex
        bloodGrpLabel.text = currentUser!.bloodGroup
        
        // Do any additional setup after loading the view.
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
