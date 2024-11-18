//
//  ProgressViewController.swift
//  Reset
//
//  Created by Prasanjit Panda on 12/11/24.
//

import UIKit

class ProgressViewController: UIViewController {

    @IBOutlet weak var ProgressLine: UIProgressView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProgressLine.progress = 0.4

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
