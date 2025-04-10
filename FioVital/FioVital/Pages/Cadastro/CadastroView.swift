//
//  CadastroView.swift
//  FioVital
//
//  Created by Turma02-26 on 04/04/25.
//

import SwiftUI

struct CadastroView: View {
    @StateObject var model = ModelView()
    
    @State var nome = ""
    @State var idade:Int = 0
    @State var endereco = ""
    @State var last_consult = ""
    @State var cond = ""
    @State var hist = ["","Hipertensão", "Arritmia", "Cardiomiopatia", "Insuficiência cardíaca", "Derrame"]
    @State var cond_atual = ""
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
                        .frame(width: 300,height: 300)
                        .padding(.bottom, -50)
                        .padding(.top, -50)
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
                    .simultaneousGesture(TapGesture().onEnded({
                        var newID = Int(model.pacientes.last?.id ?? "0")
                        newID! += 1
                        let paciente = pacient(id: String(newID ?? 0), nome: nome, idade: String(idade), hist_cond: cond, endereco: endereco, last_consulta: last_consult, latitude: "0.1276", longitude: "51.5072" )
                        model.post(paciente: paciente)
                    }))
                    Spacer()
                }
            }
            .onAppear(){
                model.fetch()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
}

#Preview {
    CadastroView()
}
