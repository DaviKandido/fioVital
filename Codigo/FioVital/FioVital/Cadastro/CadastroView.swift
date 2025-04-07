//
//  CadastroView.swift
//  FioVital
//
//  Created by Turma02-26 on 04/04/25.
//

import SwiftUI

struct CadastroView: View {
    @State var nome = ""
    @State var idade:Int = 0
    @State var endereco = ""
    @State var last_consult = ""
    @State var cond = ""
    @State var hist = ["Condição cardíaca","a", "b", "c", "d"]
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.zeroSymbol  = ""
        return formatter
    }()
    var body: some View {
        NavigationStack{
            ZStack{
                Color.background
                    .ignoresSafeArea()
                VStack{
                    Image("logo")
                        .resizable()
                        .frame(height: 400)
                        .padding(.bottom, -50)
                    TextField("Nome:", text: $nome)
                        .frame(width: 300)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                    TextField("Idade:", value: $idade, formatter: numberFormatter)
                        .frame(width: 300)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                    TextField("Endereço:", text: $endereco)
                        .frame(width: 300)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                    TextField("Última consulta:", text: $last_consult)
                        .frame(width: 300)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                    
                    Picker("Histórico:", selection: $cond) {
                        ForEach(hist, id: \.self) { cond in
                            Text(cond)
                                .foregroundStyle(Color.black)
                        }
                    }
                    .foregroundStyle(Color.black)
                    .frame(width: 300)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5)
                    .pickerStyle(.navigationLink)
                    
                    Spacer()
                    NavigationLink(destination: ContentView()){
                        ZStack{
                            Rectangle()
                                .frame(width: 160, height: 60)
                                .foregroundColor(.redFioVital)
                                .cornerRadius(20)
                                .opacity(0.5)
                            Text("Cadastrar")
                                .foregroundStyle(.white)
                                .fontWeight(.heavy)
                                .font(.system(size: 25))
                        }
                    }
                    .padding(.top, 40)
                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    CadastroView()
}
