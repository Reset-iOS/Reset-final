//
//  CustomTabBarController.swift
//  Reset
//
//  Created by Prasanjit Panda on 19/11/24.
//

import UIKit

class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        self.delegate = self

        // Do any additional setup after loading the view.
    }
    
    @objc(tabBarController:shouldSelectViewController:) func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let navController = viewController as? UINavigationController {
            navController.popToRootViewController(animated: false)
        }
        return true
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
