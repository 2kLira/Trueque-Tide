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
            
            selectedCommunity?.trueques = [
                Trueque(title: "Carpenter Work",
                        description: "Repairing wooden doors.",
                        tokens: 6,
                        owner: "Aurelio"),
                
                Trueque(title: "Childcare Support",
                        description: "Helping neighbors with kids.",
                        tokens: 3,
                        owner: "Ximena"),
                
                Trueque(title: "Corn Milling",
                        description: "Grinding maize locally.",
                        tokens: 4,
                        owner: "Mateo")
            ]
            
        case "Mixtec":
            
            selectedCommunity?.users = [
                User(name: "Yaretzi", tokenBalance: 9),
                User(name: "Itzel", tokenBalance: 6),
                User(name: "Gael", tokenBalance: 4)
            ]
            
            selectedCommunity?.trueques = [
                Trueque(title: "Grass Cutting",
                        description: "Field maintenance.",
                        tokens: 4,
                        owner: "Yaretzi"),
                
                Trueque(title: "Water Delivery",
                        description: "Transporting clean water.",
                        tokens: 5,
                        owner: "Itzel"),
                
                Trueque(title: "Basic Healthcare",
                        description: "Community health assistance.",
                        tokens: 7,
                        owner: "Gael")
            ]
            
        case "Mazatec":
            
            selectedCommunity?.users = [
                User(name: "Citlali", tokenBalance: 11),
                User(name: "Axel", tokenBalance: 7),
                User(name: "Brayan", tokenBalance: 3)
            ]
            
            selectedCommunity?.trueques = [
                Trueque(title: "Community Cooking",
                        description: "Preparing meals.",
                        tokens: 5,
                        owner: "Citlali"),
                
                Trueque(title: "Maize Grinding",
                        description: "Traditional milling.",
                        tokens: 4,
                        owner: "Axel"),
                
                Trueque(title: "Childcare Evening",
                        description: "After school supervision.",
                        tokens: 3,
                        owner: "Brayan")
            ]
            
        default:
            selectedCommunity?.users = []
            selectedCommunity?.trueques = []
        }
        
        selectedUser = nil
    }
    
    func selectUser(_ user: User) {
        selectedUser = user
    }
    
    // MARK: Add Trueque (FIX IMPORTANTE)
    
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
    
    // MARK: Update Status
    
    func updateTrueque(_ trueque: Trueque, newStatus: TruequeStatus) {
        
        guard let index = selectedCommunity?.trueques.firstIndex(where: { $0.id == trueque.id }) else { return }
        
        selectedCommunity?.trueques[index].status = newStatus
        
        if newStatus == .rejected {
            selectedCommunity?.trueques.remove(at: index)
        }
    }
    
    // MARK: Reset
    
    func reset() {
        selectedCommunity = nil
        selectedUser = nil
    }
}
