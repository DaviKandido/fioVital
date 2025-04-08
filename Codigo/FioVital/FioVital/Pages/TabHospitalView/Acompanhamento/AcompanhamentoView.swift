//
//  AcompanhamentoView.swift
//  FioVital
//
//  Created by Turma02-9 on 07/04/25.
//

import SwiftUI

struct AcompanhamentoView: View{
    
//    @State var Paciente
    
    
    var body: some View{
        ZStack{
            Color.background
                .ignoresSafeArea()
            
            VStack{
                Text("Acompanhamento")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .padding()
                
                ScrollView(.vertical){
                    Spacer()
                    
                    PacienteCard()
                    
                    PacienteCard()
                    
                    PacienteCard()
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    AcompanhamentoView()
}
