//
//  AcompanhamentoView.swift
//  FioVital
//
//  Created by Turma02-9 on 07/04/25.
//

import SwiftUI

struct AcompanhamentoView: View{
    
    @StateObject var viewModel = ModelView()
    @State var mostraSheet: Bool = false

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
                        Button(action: {
                            mostraSheet.toggle()
                        }, label: {
                            PacienteCard(PacienteName: pacient.nome ?? "erro")
                        })
                        .sheet(isPresented: $mostraSheet, content: {
                            Sheet(paciente: pacient)
                                .cornerRadius(40)
                                .ignoresSafeArea()
                        })
                    }
                    .foregroundColor(.black)
                    .padding(.vertical, 10)
                    
                    
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
