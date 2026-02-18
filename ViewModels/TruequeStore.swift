//
//  TruequeStore.swift
//  TruequeTide
//
//  Created by Guillermo Lira on 17/02/26.
//


import Foundation

class TruequeStore: ObservableObject {
    
    @Published var communities: [Community] = [
        Community(name: "Zapotec"),
        Community(name: "Mixtec"),
        Community(name: "Mazatec")
    ]
    
    @Published var selectedCommunity: Community?
    @Published var selectedUser: User?
    
    // MARK: Select Community
    
    func selectCommunity(_ community: Community) {
        selectedCommunity = community
        
        switch community.name {
            
        case "Zapotec":
            selectedCommunity?.users = [
                User(name: "Aurelio", tokenBalance: 12),
                User(name: "Ximena", tokenBalance: 8),
                User(name: "Mateo", tokenBalance: 5)
            ]
            
        case "Mixtec":
            selectedCommunity?.users = [
                User(name: "Yaretzi", tokenBalance: 9),
                User(name: "Itzel", tokenBalance: 6),
                User(name: "Gael", tokenBalance: 4)
            ]
            
        case "Mazatec":
            selectedCommunity?.users = [
                User(name: "Citlali", tokenBalance: 11),
                User(name: "Axel", tokenBalance: 7),
                User(name: "Brayan", tokenBalance: 3)
            ]
            
        default:
            selectedCommunity?.users = []
        }
        
        selectedUser = nil
    }
    
    func selectUser(_ user: User) {
        selectedUser = user
    }
    
    // MARK: Add Trueque
    
    func addTrueque(title: String, description: String, tokens: Int) {
        
        guard let user = selectedUser else { return }
        
        let newTrueque = Trueque(
            title: title,
            description: description,
            tokens: tokens,
            owner: user.name
        )
        
        selectedCommunity?.trueques.append(newTrueque)
    }
    
    // MARK: Reset
    
    func reset() {
        selectedCommunity = nil
        selectedUser = nil
    }
}
