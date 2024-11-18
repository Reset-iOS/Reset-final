//
//  CommunityViewController.swift
//  Reset
//
//  Created by Prasanjit Panda on 14/11/24.
//

import UIKit

class CommunityViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var communitySegmentedControl: UISegmentedControl!
    
    var postsViewController: PostsViewController?
    var spacesViewController: SpacesViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Initialize view controllers
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
        postsViewController = storyboard.instantiateViewController(withIdentifier: "Posts") as? PostsViewController
        spacesViewController = storyboard.instantiateViewController(withIdentifier: "Spaces") as? SpacesViewController
                
                // Display the first view controller as the default
        add(asChildViewController: postsViewController!)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
                case 0:
            remove(asChildViewController: spacesViewController!)
                    add(asChildViewController: postsViewController!)
                case 1:
                    remove(asChildViewController: postsViewController!)
                    add(asChildViewController: spacesViewController!)
                default:
                    break
                }
        
    }
    
    
    private func add(asChildViewController viewController: UIViewController) {
            addChild(viewController)
            containerView.addSubview(viewController.view)

            // Configure child view's frame to match the container view's bounds
            viewController.view.frame = containerView.bounds
            viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

            viewController.didMove(toParent: self)
        }

        // Remove a view controller from the container view
        private func remove(asChildViewController viewController: UIViewController) {
            viewController.willMove(toParent: nil)
            viewController.view.removeFromSuperview()
            viewController.removeFromParent()
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
