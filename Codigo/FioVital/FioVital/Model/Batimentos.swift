//
//  Batimentos.swift
//  FioVital
//
//  Created by Turma02-9 on 08/04/25.
//

import Foundation

struct Batimentos: Codable, Identifiable, Equatable {
    var id: String
    var hora: String
    var data: String
    var bpm: String
}
