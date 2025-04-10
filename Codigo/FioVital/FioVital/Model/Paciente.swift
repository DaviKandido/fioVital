//
//  Paciente.swift
//  FioVital
//
//  Created by Turma02-9 on 07/04/25.
//

import Foundation

struct pacient:Codable, Identifiable{
//    let _id: String?
//    let _rev: String?
    let id:String?
    let nome:String?
    let idade:String?
    let hist_cond:String?
    let endereco:String?
    let last_consulta:String?
    let latitude: String?
    let longitude: String?
}
