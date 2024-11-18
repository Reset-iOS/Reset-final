//
//  SupportViewController.swift
//  Reset
//
//  Created by Prasanjit Panda on 15/11/24.
//

import UIKit

class SupportViewController: UIViewController,AddSectionTableViewCellDelegate {
    func didTapPlusButton(for sectionTitle: String) {
        // Determine the destination view controller based on section title
        let destinationVC: UIViewController
                
        if sectionTitle == "Sponsors" {
            destinationVC = SponsorViewController() // Replace with your actual SponsorsViewController
        } else if sectionTitle == "Family / Friends" {
            destinationVC = FriendsViewController() // Replace with your actual FriendsViewController
        } else {
                return // Handle any unknown cases if needed
        }
                // Push the destination view controller
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    private let viewModel = SupportViewModel()
    
    // MARK: - UI Components
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        table.backgroundColor = .systemBackground
        table.register(AddSectionTableViewCell.self, forCellReuseIdentifier: "AddSectionCell")
        table.register(ProfileTableViewCell.self, forCellReuseIdentifier: "ProfileCell")
        table.register(EmptyStateTableViewCell.self, forCellReuseIdentifier: "EmptyStateCell")
        return table
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Setup
    private func setupUI() {
        title = "Support"
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - TableView DataSource & Delegate
extension SupportViewController: UITableViewDataSource, UITableViewDelegate {
    enum Section: Int, CaseIterable {
        case sponsors
        case family
        case emptyState
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.hasSupportMembers ? 2 : 3 // Show empty state section if no members
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        
        switch section {
        case .sponsors:
            return viewModel.getSponsor() != nil ? 2 : 1 // Header + sponsor if exists
        case .family:
            print("SupportViewController: \(viewModel.getFriends().count)")
            return 1 + viewModel.getFriends().count // Header + friends
        case .emptyState:
            return viewModel.hasSupportMembers ? 0 : 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        
        switch section {
        case .sponsors:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "AddSectionCell", for: indexPath) as! AddSectionTableViewCell
                cell.delegate = self
                cell.configure(title: "Sponsors")
                cell.selectionStyle = .none
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileTableViewCell
                if let sponsor = viewModel.getSponsor() {
                    cell.configure(with: sponsor)
                }
                return cell
            }
            
        case .family:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "AddSectionCell", for: indexPath) as! AddSectionTableViewCell
                cell.delegate = self
                cell.configure(title: "Family / Friends")
                cell.selectionStyle = .none
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileTableViewCell
                let friends = viewModel.getFriends()
                cell.configure(with: friends[indexPath.row - 1])
                return cell
            }
            
        case .emptyState:
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyStateCell", for: indexPath) as! EmptyStateTableViewCell
            return cell
        }
    }
}
