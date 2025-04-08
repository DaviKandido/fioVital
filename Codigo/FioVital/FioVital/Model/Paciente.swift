//
//  Paciente.swift
//  FioVital
//
//  Created by Turma02-9 on 07/04/25.
//

import Foundation

struct pacient:Codable, Identifiable{
    let id:String?
    let nome:String?
    let idade:String?
    let hist_cond:String?
    let endereco:String?
    let last_consulta:String?
}
