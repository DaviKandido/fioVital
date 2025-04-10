//
//  PacienteCard.swift
//  FioVital
//
//  Created by Turma02-9 on 07/04/25.
//

import SwiftUI
import Foundation

struct PacienteCard: View{
    
    @State private var color: Color = .green
    @State private var bpm: Int = 70
    @State private var timer: Timer?
    
    @State var mensage: String = "Ideal"
    
    @State var Paciente: pacient = pacient(
        id: "1",
        nome: "Fatima Fagundes",
        idade: "2",
        hist_cond: "Bradiarritmia",
        endereco: "Avenida Getuio Vargas, 298",
        last_consulta: "2 Semanas",
        latitude: "-19.4658",
        longitude: "-44.2469"
        
    )
    
    @StateObject private var informationViewModel = Information();
    
    
    var body: some View{
        Rectangle()
            .frame(width: 323, height: 140)
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

                    Text(mensage)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Spacer()

                    Text(Paciente.nome ?? "Desconhecido")
                        .font(.title3)
                        .padding(.bottom, 10)
                        .padding(.top, 5)
                    Spacer()
                }
                .onAppear{
                    // Executa uma vez imediatamente
                    informationViewModel.fetch()
                    updateBpm()
                    
                    // Cria o timer que atualiza a cada 1 segundo
                    timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { _ in
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
    }
    
    
    private func updateBpm() {
        let sortedBatimentos = informationViewModel.arraydigi.sorted {
        let date1 = convertToDate($0.data, $0.hora)
        let date2 = convertToDate($1.data, $1.hora)
        return date1 > date2
        }
        
        if Paciente.id == "607"{
            if let latestBpmString = sortedBatimentos.first?.bpm,
               let bpmValue = Int(latestBpmString.trimmingCharacters(in: .whitespacesAndNewlines)) {
                self.bpm = bpmValue
                
                // Atualiza cor e status com base nas faixas
                switch bpmValue {
                case ..<50, 111...:
                    color = .red
                    mensage = "Emergencia"
                case 50..<70, 90...110:
                    color = .yellow
                    mensage = "Em alerta"
                case 70..<90:
                    color = .green
                    mensage = "Ideal"
                default:
                    color = .gray
                    mensage = "Desconhecido"
                }
            }
        }else{
            if let latestBpmString = sortedBatimentos.randomElement()?.bpm,
               let bpmValue = Int(latestBpmString.trimmingCharacters(in: .whitespacesAndNewlines)) {
                self.bpm = bpmValue
                
                // Atualiza cor e status com base nas faixas
                switch bpmValue {
                case ..<50, 111...:
                    color = .red
                    mensage = "Emergencia"
                case 50..<70, 90...110:
                    color = .yellow
                    mensage = "Em alerta"
                case 70..<90:
                    color = .green
                    mensage = "Ideal"
                default:
                    color = .gray
                    mensage = "Desconhecido"
                }
            }
        }
    }

    // Função para converter data e hora em Date
    private func convertToDate(_ dateString: String, _ timeString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
        let fullDateString = "\(dateString) \(timeString)"
        return dateFormatter.date(from: fullDateString) ?? Date()
    }
}

#Preview{
    PacienteCard(Paciente: pacient(
        id: "1",
        nome: "Fatima Fagundes",
        idade: "2",
        hist_cond: "Bradiarritmia",
        endereco: "Avenida Getuio Vargas, 298",
        last_consulta: "2 Semanas",
        latitude: "-19.4658",
        longitude: "-44.2469"
        
    ))
}
