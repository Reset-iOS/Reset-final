//
//  DetailViewController.swift
//  Reset
//
//  Created by Prasanjit Panda on 15/11/24.
//

import UIKit

class DetailViewController: UIViewController {
    var user: User?
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var streaks: UILabel!
    @IBOutlet weak var userNameAndAge: UILabel!
    @IBOutlet weak var soberSince: UILabel!
    @IBOutlet weak var resets: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        print(user!)
        
        let currentUser = DataManager.shared.getCurrentUser()
        profileImage.image = UIImage(named: currentUser!.profileImage)
        userNameAndAge.text = "\(currentUser?.name ?? "") (\(currentUser?.age ?? 0))"
        if let soberSinceDate = currentUser?.soberSince {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.weekOfYear], from: soberSinceDate, to: Date())
            let weeks = components.weekOfYear ?? 0
            soberSince.text = "\(weeks) weeks"
        } else {
            soberSince.text = "No date available"
        }
        resets.text = "\(currentUser?.resets ?? 0)"
        streaks.text = "\(currentUser?.streak ?? 0)"
        
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addSponsorButtonClicked(_ sender: Any) {
        guard let currentUser = DataManager.shared.getCurrentUser() else {
                    showAlert(title: "Error", message: "No current user is logged in.")
                    return
        }
        // Update the current user's sponsorID
        var updatedUser = currentUser
        updatedUser.sponsorID = user?.id

                // Save the updated current user
        DataManager.shared.setCurrentUser(updatedUser)

                // Update the list of all users
        DataManager.shared.saveUpdatedUser(updatedUser)

                // Navigate back in the view hierarchy
        
        guard let navigationController = self.navigationController,
                      let firstViewController = storyboard?.instantiateViewController(withIdentifier: "support") else {
                    print("First view controller could not be instantiated.")
                    return
        }
        firstViewController.navigationItem.hidesBackButton = true
        navigationController.setViewControllers([firstViewController], animated: true)
    }
    
    private func showAlert(title: String, message: String) {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            present(alertController, animated: true)
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
