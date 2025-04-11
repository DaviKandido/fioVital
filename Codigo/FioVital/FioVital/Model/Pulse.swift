//
//  Pulse.swift
//  FioVital
//
//  Created by Turma02-9 on 07/04/25.
//

import Foundation

struct medida_pulso:Codable, Identifiable{
    let id:String?
    let hora:String?
    let data:String?
    let bpm:String?
}
