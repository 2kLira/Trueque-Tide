//
//  AddTaskView.swift
//  TruequeTide
//
//  Created by Guillermo Lira on 17/02/26.
//


import SwiftUI

struct AddTruequeView: View {
    
    @ObservedObject var store: TruequeStore
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var description = ""
    @State private var tokens = ""
    
    var body: some View {
        
        NavigationStack {
            
            VStack(spacing: 20) {
                
                TextField("Title", text: $title)
                    .textFieldStyle(.roundedBorder)
                
                TextField("Description", text: $description)
                    .textFieldStyle(.roundedBorder)
                
                TextField("Tokens", text: $tokens)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                
                Button("Add Trueque") {
                    
                    if let value = Int(tokens) {
                        store.addTrueque(
                            title: title,
                            description: description,
                            tokens: value
                        )
                        dismiss()
                    }
                }
                .padding()
            }
            .padding()
            .navigationTitle("New Trueque")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Back") {
                        dismiss()
                    }
                }
            }
        }
    }
}
