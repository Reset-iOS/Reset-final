//
//  SponsorViewController.swift
//  Reset
//
//  Created by Prasanjit Panda on 12/11/24.
//

import UIKit

class FriendsResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var users: [User] = [] // Holds the filtered users
    private let tableView = UITableView()
    var selectedUsers: [UUID] = [] // Temporary storage for selected user IDs
    var onDismiss: (([UUID]) -> Void)? // Callback to pass selected users back

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
    }

    private func setupTableView() {
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ResultCell")
        view.addSubview(tableView)
    }

    func updateResults(with users: [User]) {
        self.users = users
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)
        let user = users[indexPath.row]
        cell.textLabel?.text = "\(user.name), \(user.age)"
        return cell
    }

    @objc(tableView:didSelectRowAtIndexPath:) func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = users[indexPath.row]

        // Show confirmation alert
        let alert = UIAlertController(title: "Add Friend", message: "Do you want to add \(selectedUser.name) to your friends?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { [weak self] _ in
            self?.addUserToSelectedList(selectedUser)
        }))
        present(alert, animated: true, completion: nil)
    }

    private func addUserToSelectedList(_ user: User) {
        guard !selectedUsers.contains(user.id) else { return }
        selectedUsers.append(user.id)
        print("Added \(user.name) to selected list.")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        onDismiss?(selectedUsers) // Pass the selected users back to the parent
    }
}




class FriendsViewController: UIViewController, UISearchResultsUpdating {

    let searchController = UISearchController(searchResultsController: FriendsResultsViewController())
    private var allUsers: [User] = [] // Store all users
    private var filteredUsers: [User] = [] // Store filtered users
    private var selectedUsers: [UUID] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Friends and Family"
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self

        // Fetch user names from DataManager
        fetchUsers()

        // Set the selection callback
        if let resultsVC = searchController.searchResultsController as? FriendsResultsViewController {
                    resultsVC.onDismiss = { [weak self] selectedIDs in
                        self?.selectedUsers = selectedIDs
                    }
        }
    }

    private func fetchUsers() {
        let users = DataManager.shared.loadUsers()
        allUsers = users
    }

    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            filteredUsers = []
            updateResultsView()
            return
        }

        // Filter users based on the search text
        filteredUsers = allUsers.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        updateResultsView()
    }

    private func updateResultsView() {
        if let resultsVC = searchController.searchResultsController as? FriendsResultsViewController {
            resultsVC.updateResults(with: filteredUsers)
        }
    }

    private func showDetailViewController(for user: User) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailView") as! DetailViewController
        detailVC.user = user // Pass the selected user to DetailViewController
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)

            // Append selected users to the current user's friends list
            if let currentUser = DataManager.shared.getCurrentUser() {
                var updatedUser = currentUser
                updatedUser.friends.append(contentsOf: selectedUsers)
                updatedUser.friends = Array(Set(updatedUser.friends)) // Ensure uniqueness

                DataManager.shared.saveUpdatedUser(updatedUser)
                print("Updated friends list with \(selectedUsers.count) new users.")
            }
        }
}
