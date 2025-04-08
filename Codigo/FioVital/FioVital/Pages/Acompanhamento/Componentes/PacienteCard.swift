//
//  PacienteCard.swift
//  FioVital
//
//  Created by Turma02-9 on 07/04/25.
//

import SwiftUI
import Foundation

struct PacienteCard: View{
    
    @State var color: Color = .redFioVital
    @State var mensage: String = "Emergencia"
    @State var PacienteName: String = "Fatima"
    
    
    var body: some View{
        Rectangle()
            .frame(width: 323, height: 130)
            .foregroundColor(color)
            .opacity(0.6)
            .cornerRadius(20)
            .padding(.horizontal, 20)
            .overlay{
                VStack{
                    Spacer()
                    Image(systemName: "exclamationmark.triangle")
                        .font(.title2)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding(.top, 10)
                    Spacer()

                    Text("Emergencia")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Spacer()

                    Text("Fatima")
                        .font(.title3)
                        .padding(.bottom, 10)
                    Spacer()
                }
                
            }
    }
}

#Preview{
    PacienteCard()
}
