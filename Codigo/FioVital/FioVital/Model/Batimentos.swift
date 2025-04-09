//
//  Batimentos.swift
//  FioVital
//
//  Created by Turma02-9 on 08/04/25.
//

import Foundation

// MARK: - Modelo
struct Batimentos: Identifiable, Codable {
    var id = UUID()
    let time: Int
    let bpm: Double
}
