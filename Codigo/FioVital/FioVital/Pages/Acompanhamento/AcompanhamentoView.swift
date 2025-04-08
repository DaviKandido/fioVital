//
//  AcompanhamentoView.swift
//  FioVital
//
//  Created by Turma02-9 on 07/04/25.
//

import SwiftUI

struct AcompanhamentoView: View{
    
    @StateObject var viewModel = ModelView_Pacient()

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
                    
                    ForEach(viewModel.pacientes){ pacient in
                        PacienteCard(PacienteName: pacient.nome ?? "erro")
                    }
                    
                    
                    Spacer()
                }
            }
        }
        .onAppear{
            viewModel.fetch()
        }
    }
}

#Preview {
    AcompanhamentoView()
}
