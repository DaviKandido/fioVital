//
//  Information.swift
//  FioVital
//
//  Created by Turma02-9 on 09/04/25.
//

import Foundation

class Information: ObservableObject {
    @Published var arraydigi: [Batimentos] = []
    
    func fetch() {
        guard let url = URL(string: "http://192.168.128.100:1880/via4") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                // Decodifica os dados da API
                let parsed = try JSONDecoder().decode([Batimentos].self, from: data)
                DispatchQueue.main.async {
                    // Atualiza os dados
                    self?.arraydigi = parsed
                }
            } catch {
                print(error)
            }
        }
        
        task.resume()
    }
}

