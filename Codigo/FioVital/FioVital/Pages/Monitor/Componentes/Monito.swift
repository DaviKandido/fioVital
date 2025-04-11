//
//  Monito.swift
//  FioVital
//
//  Created by Turma02-9 on 04/04/25.
//

import SwiftUI

struct Monitor: View {
    
    @State var min: String? = "85"
    @State var med: Int = 95
    @State var max: String? = "107"
    
    @StateObject private var informationViewModel = Information()
    @State private var timer: Timer?
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.redFioVital.opacity(0.4))
                .frame(width: 350, height: 130)
                .cornerRadius(20)
                .shadow(color: .black, radius: 100, x:5, y:5)
                .overlay{
                    
                    
                    HStack{
                        Spacer()
                        VStack{
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                                .padding(.leading, -35)
                            HStack{
                                Text(min ?? "85")
                                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                    .padding(.trailing, -8)
                                Text("BPM")
                                    .padding(.top, 5)
                            }
                            Text("min.")
                                .padding(.leading, -32)
                        }
                        Spacer()
                        VStack{
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                                .padding(.leading, -35)
                            HStack{
                                Text("\(med)")
                                    .font(.title)
                                    .padding(.trailing, -8)
                                Text("BPM")
                                    .padding(.top, 5)
                            }
                            Text("med.")
                                .padding(.leading, -32)
                        }
                        Spacer()
                        VStack{
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                                .padding(.leading, -35)
                            HStack{
                                Text(max ?? "107")
                                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                    .padding(.trailing, -8)
                                Text("BPM")
                                    .padding(.top, 5)
                            }
                            Text("max.")
                                .padding(.leading, -32)
                        }
                        Spacer()
                    }
                }
        }
        .onAppear {
            // Executa uma vez imediatamente
           
            informationViewModel.fetch()
            updateBpm()
            
            // Cria o timer que atualiza a cada 1 segundo
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                informationViewModel.fetch()
                updateBpm()
            }
        }
        .onDisappear {
            // Para o timer quando a view sair
            timer?.invalidate()
            timer = nil
        }
    }
    
    // Atualiza o valor do BPM, cor e status com base nos dados mais recentes
    private func updateBpm() {
        var soma: Int = 0
        let sortedBatimentos = informationViewModel.arraydigi.sorted {
            let date1:Int = Int($0.bpm) ?? 0
//            print("data1:\(date1)")
            let date2:Int = Int($1.bpm) ?? 0
//            print("data2:\(date2)")
        return date1 > date2
        }
        min = sortedBatimentos.last?.bpm ?? "00"
        max = sortedBatimentos.first?.bpm ?? "00"
        
      
        for bat in informationViewModel.arraydigi {
            soma += Int(bat.bpm) ?? 0
        }
        
        if !sortedBatimentos.isEmpty {
            med = soma / sortedBatimentos.count
        }
        
//        med = (soma / sortedBatimentos.count)
        
//        print(soma)
    }

    // Função para converter data e hora em Date
    private func convertToDate(_ dateString: String, _ timeString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
        let fullDateString = "\(dateString) \(timeString)"
        return dateFormatter.date(from: fullDateString) ?? Date()
    }
}

#Preview {
    Monitor()
}
