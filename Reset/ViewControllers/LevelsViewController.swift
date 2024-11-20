//
//  LevelsViewController.swift
//  Reset
//
//  Created by Prasanjit Panda on 18/11/24.
//

import UIKit

class LevelsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private let tableView = UITableView()

    // Badge data
    private let badges: [Badge] = [
        // Use "medal.fill" for each element and set specific tintColor for each badge
        Badge(name: "Bronze", duration: "6 months", image: (UIImage(systemName: "medal.fill")?.withRenderingMode(.alwaysTemplate))!),
        Badge(name: "Silver", duration: "9 months", image: (UIImage(systemName: "medal.fill")?.withRenderingMode(.alwaysTemplate))!),
        Badge(name: "Gold", duration: "1 year", image: (UIImage(systemName: "medal.fill")?.withRenderingMode(.alwaysTemplate))!),
        Badge(name: "Platinum", duration: "2 years", image: (UIImage(systemName: "medal.fill")?.withRenderingMode(.alwaysTemplate))!),
        Badge(name: "Diamond", duration: "5 years", image: (UIImage(systemName: "medal.fill")?.withRenderingMode(.alwaysTemplate))!),
        Badge(name: "Legacy", duration: "10+ years", image: (UIImage(systemName: "medal.fill")?.withRenderingMode(.alwaysTemplate))!)
    ]
    

    // Title label
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Levels"
        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        // Set background color and title
        view.backgroundColor = .white

        // Add title label
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        // Configure Table View
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BadgeCardCell.self, forCellReuseIdentifier: "BadgeCardCell")
        tableView.separatorStyle = .none
        
        // Set the row height to fill the screen evenly
        let availableHeight = view.frame.height - 100 // Adjust for title and padding
        let badgeHeight = availableHeight / CGFloat(badges.count) // Divide space equally for each badge
        tableView.rowHeight = badgeHeight

        // Add Table View
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        // Add Constraints
        NSLayoutConstraint.activate([
            // Title Label Constraints
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            // Table View Constraints
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    // MARK: - TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return badges.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BadgeCardCell", for: indexPath) as? BadgeCardCell else {
            return UITableViewCell()
        }
        
        let badge = badges[indexPath.row]
        cell.badgeImageView.image = badge.image

            // Set a custom color based on the badge name
            switch badge.name {
            case "Bronze":
                cell.badgeImageView.tintColor = .brown // Bronze color
            case "Silver":
                cell.badgeImageView.tintColor = .gray // Silver color
            case "Gold":
                cell.badgeImageView.tintColor = .yellow // Gold color
            case "Platinum":
                cell.badgeImageView.tintColor = .lightGray // Platinum color
            case "Diamond":
                cell.badgeImageView.tintColor = .cyan // Diamond color
            case "Legacy":
                cell.badgeImageView.tintColor = .purple // Legacy color
            default:
                cell.badgeImageView.tintColor = .black // Default color
            }
        cell.badgeNameLabel.text = badge.name
        cell.badgeDurationLabel.text = badge.duration
        return cell
    }

    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let badge = badges[indexPath.row]
        print("Selected Badge: \(badge.name)")
    }
}

