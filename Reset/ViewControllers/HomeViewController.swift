//
//  HomeViewController.swift
//  Reset
//
//  Created by Prasanjit Panda on 12/11/24.
//

import UIKit
import CHTCollectionViewWaterfallLayout

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, CHTCollectionViewDelegateWaterfallLayout, UIPopoverPresentationControllerDelegate,TextInputViewControllerDelegate,ImageInputViewControllerDelegate {
    
    func didSelectImage(_ image: UIImage) {
         // Add the new image item to the data source array
         let newItem = Item(type: .image, text: nil, image: image)
         dataSourceArray.append(newItem)
         
         // Reload the collection view to display the new image item
         collectionView.reloadData()
     }
    

    @IBOutlet weak var collectionView: UICollectionView!
    var dataSourceArray: [Item] = [
        Item(type: .text, text: "Shirts", image: nil),
        Item(type: .text, text: "Pants", image: nil),
        Item(type: .text, text: "Shoes", image: nil),
        Item(type: .text, text: "Hats", image: nil),
        Item(type: .text, text: "Bags", image: nil)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup CHTCollectionViewWaterfallLayout
        let layout = CHTCollectionViewWaterfallLayout()
        layout.columnCount = 2
        layout.minimumColumnSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        collectionView.collectionViewLayout = layout
        collectionView.dataSource = self
        collectionView.delegate = self

        // Enable long-press gesture for reordering
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        collectionView.addGestureRecognizer(longPressGesture)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "homePopOverSegue"
        {
            let popoverVC = segue.destination
            popoverVC.popoverPresentationController?.delegate = self
            
        }
    }
    
    func didEnterText(_ text: String) {
            // Add the new item to the data source array and reload the collection view
        let newItem = Item(type: .text,text: text, image: nil)
            dataSourceArray.append(newItem)
            collectionView.reloadData()
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSourceArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCollectionViewCell
                
                // Configure the cell with the item
        let item = dataSourceArray[indexPath.row]
        cell.configure(with: item)
        cell.backgroundColor = .cyan
        return cell
    }

    // MARK: - UICollectionViewDataSource - Move Item

    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true // Allow all items to be movable
    }

    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // Update data source array to reflect the move
        let movedItem = dataSourceArray.remove(at: sourceIndexPath.item)
        dataSourceArray.insert(movedItem, at: destinationIndexPath.item)
    }

    // MARK: - Long Press Gesture Handler

    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            guard let selectedIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else { break }
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)

        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))

        case .ended:
            collectionView.endInteractiveMovement()

        default:
            collectionView.cancelInteractiveMovement()
        }
    }

    // MARK: - CHTCollectionViewDelegateWaterfallLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = dataSourceArray[indexPath.row]
                if item.type == .image {
                    // Define a fixed size for images
                    return CGSize(width: 100, height: 100)
                } else {
                    // Adjust size for text items
                    return CGSize(width: 100, height: 50)
                }
            }
}


