import Foundation

class DataManager {
    static let shared = DataManager()
    private let usersKey = "mockUsers"
    private let postsKey = "mockPosts"
    private let currentUserKey = "currentUser"

    private init() {}

    // MARK: - User Management

    func saveUsers(_ users: [User]) {
        if let encodedData = try? JSONEncoder().encode(users) {
            UserDefaults.standard.set(encodedData, forKey: usersKey)
        }
    }

    func loadUsers() -> [User] {
        if let data = UserDefaults.standard.data(forKey: usersKey),
           let users = try? JSONDecoder().decode([User].self, from: data) {
            return users
        }
        return mockUsers // Fallback to initial data if nothing is saved
    }

    func setCurrentUser(_ user: User) {
        if let encodedData = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encodedData, forKey: currentUserKey)
        }
    }

    func getCurrentUser() -> User? {
        if let data = UserDefaults.standard.data(forKey: currentUserKey),
           let user = try? JSONDecoder().decode(User.self, from: data) {
            return user
        }
        return nil // Return nil if no logged-in user is found
    }

    // MARK: - Post Management

    func savePosts(_ posts: [Post]) {
        if let encodedData = try? JSONEncoder().encode(posts) {
            UserDefaults.standard.set(encodedData, forKey: postsKey)
        }
    }

    func loadPosts() -> [Post] {
        if let data = UserDefaults.standard.data(forKey: postsKey),
           let posts = try? JSONDecoder().decode([Post].self, from: data) {
            return posts
        }
        return mockPosts // Fallback to initial data if nothing is saved
    }
    
    func saveUpdatedUser(_ updatedUser: User) {
            var allUsers = loadUsers()
            if let index = allUsers.firstIndex(where: { $0.id == updatedUser.id }) {
                allUsers[index] = updatedUser
                saveUsers(allUsers)
            }
        }
}
