//
//  ProgressViewController.swift
//  Reset
//
//  Created by Prasanjit Panda on 12/11/24.
//

import UIKit

class ProgressViewController: UIViewController {

    @IBOutlet weak var ProgressLine: UIProgressView!
    
    @IBOutlet weak var progressCardView: UIView!
    @IBOutlet weak var profileButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProgressLine.progress = 0.4
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(progressCardTapped))
        progressCardView.addGestureRecognizer(tapGesture)
        progressCardView.isUserInteractionEnabled = true
                
    }
    
    @objc func progressCardTapped() {
            // Push LevelViewController
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let levelViewController = storyboard.instantiateViewController(withIdentifier: "LevelsViewController") as? LevelsViewController {
                self.navigationController?.pushViewController(levelViewController, animated: true)
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
