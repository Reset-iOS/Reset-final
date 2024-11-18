//
//  JournalManager.swift
//  Reset
//
//  Created by Prasanjit Panda on 18/11/24.
//
import Foundation

class JournalManager {
    static let shared = JournalManager()
    private let journalsKey = "saved_journals"
    
    private init() {}
    
    func saveJournal(_ journal: Journal) {
        var journals = getAllJournals()
        journals.insert(journal, at: 0)  // Add new journal at the beginning
        
        if let encoded = try? JSONEncoder().encode(journals) {
            UserDefaults.standard.set(encoded, forKey: journalsKey)
        }
    }
    
    func getAllJournals() -> [Journal] {
        if let data = UserDefaults.standard.data(forKey: journalsKey),
           let journals = try? JSONDecoder().decode([Journal].self, from: data) {
            return journals
        }
        return []
    }
    
    func getLatestJournal() -> Journal? {
        return getAllJournals().first
    }
}
