//
//  Localizador.swift
//  FioVital
//
//  Created by Turma02-9 on 08/04/25.
//

import Foundation
import SwiftUI

struct Localizador: View {
    @State var pacienteName: String?
    
    var body: some View {
        Text(pacienteName ?? "Desconhecido")
            .foregroundColor(.red)

        Image(systemName: "mappin.and.ellipse")
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .foregroundColor(.red)
        
    }
}


#Preview {
    Localizador(pacienteName: "Fatima")
}
