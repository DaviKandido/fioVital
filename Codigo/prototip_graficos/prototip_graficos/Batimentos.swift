//
//  Batimentos.swift
//  FioVital
//
//  Created by Turma02-1 on 07/04/25.
//

import Foundation

struct Batimentos: Codable, Identifiable {
    var id: String
    var hora: String
    var data: String
    var bpm: String
}
