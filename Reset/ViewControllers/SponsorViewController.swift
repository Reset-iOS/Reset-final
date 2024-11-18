//
//  SponsorViewController.swift
//  Reset
//
//  Created by Prasanjit Panda on 12/11/24.
//

import UIKit

class ResultsViewController: UIViewController {
    var users: [User] = [] // Holds the filtered users
    var didSelectUser: ((User) -> Void)? // A callback to pass the selected user

    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
    }

    private func setupTableView() {
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.dataSource = self
        tableView.delegate = self // Add delegate
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ResultCell")
        view.addSubview(tableView)
    }

    func updateResults(with users: [User]) {
        self.users = users
        tableView.reloadData()
    }
}

extension ResultsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)
        let user = users[indexPath.row]
        cell.textLabel?.text = "\(user.name), \(user.age)" // Customize how user data is shown
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = users[indexPath.row]
        didSelectUser?(selectedUser) // Pass the selected user back to the SponsorViewController
    }
}

class SponsorViewController: UIViewController, UISearchResultsUpdating {

    let searchController = UISearchController(searchResultsController: ResultsViewController())
    private var allUsers: [User] = [] // Store all users
    private var filteredUsers: [User] = [] // Store filtered users

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Find Sponsors"
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self

        // Fetch user names from DataManager
        fetchUsers()

        // Set the selection callback
        if let resultsVC = searchController.searchResultsController as? ResultsViewController {
            resultsVC.didSelectUser = { [weak self] user in
                self?.showDetailViewController(for: user)
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
        if let resultsVC = searchController.searchResultsController as? ResultsViewController {
            resultsVC.updateResults(with: filteredUsers)
        }
    }

    private func showDetailViewController(for user: User) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailView") as! DetailViewController
        detailVC.user = user // Pass the selected user to DetailViewController
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
