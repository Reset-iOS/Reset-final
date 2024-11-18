//
//  SupportViewModel.swift
//  Reset
//
//  Created by Prasanjit Panda on 16/11/24.
//

import Foundation

class SupportViewModel {
    private let dataManager = DataManager.shared
    
    var currentUser: User? {
        return dataManager.getCurrentUser()
    }
    
    
    
    // Get sponsor for current user
    func getSponsor() -> User? {
        guard let currentUser = currentUser,
              let sponsorID = currentUser.sponsorID else {
            return nil
        }
        
        return dataManager.loadUsers().first { $0.id == sponsorID }
    }
    
    // Get friends for current user
    func getFriends() -> [User] {
        guard let currentUser = currentUser else { return [] }
        let allUsers = dataManager.loadUsers()
        return currentUser.friends.compactMap { friendID in
            allUsers.first { $0.id == friendID }
        }
    }
    
    // Check if user has any support members
    var hasSupportMembers: Bool {
        return getSponsor() != nil || !getFriends().isEmpty
    }
    
    
}
