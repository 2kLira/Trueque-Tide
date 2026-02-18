//
//  Trueque.swift
//  TruequeTide
//
//  Created by Guillermo Lira on 17/02/26.
//


import Foundation

struct Trueque: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let tokens: Int
    let owner: String
}
