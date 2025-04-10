import SwiftUI

struct PulseView: View {
    @StateObject private var informationViewModel = Information()
    @State private var color: Color = .green
    @State private var bpm: Int = 70
    @State private var status: String = "Ideal"
    @State private var timer: Timer?
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(color.opacity(0.7))
                .frame(width: 130, height: 130)
                .cornerRadius(20)
                .overlay {
                    VStack {
                        Text(status)
                            .font(.callout)
                            .padding(.trailing, 40)
                        
                        HStack {
                            Text("\(bpm)")
                                .font(.title)
                                .padding(.trailing, -8)
                            Text("BPM")
                                .padding(.top, 5)
                        }
                        
                        Text("Status")
                            .font(.callout)
                            .padding(.leading, 40)
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
        let sortedBatimentos = informationViewModel.arraydigi.sorted {
        let date1 = convertToDate($0.data, $0.hora)
        let date2 = convertToDate($1.data, $1.hora)
        return date1 > date2
        }
        
        if let latestBpmString = sortedBatimentos.first?.bpm,
           let bpmValue = Int(latestBpmString.trimmingCharacters(in: .whitespacesAndNewlines)) {
            self.bpm = bpmValue
            
            // Atualiza cor e status com base nas faixas
            switch bpmValue {
            case ..<50, 111...:
                color = .red
                status = "Risco"
            case 50..<70, 90...110:
                color = .yellow
                status = "Cuidado"
            case 70..<90:
                color = .green
                status = "Ideal"
            default:
                color = .gray
                status = "Desconhecido"
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

#Preview {
    PulseView()
        .previewLayout(.sizeThatFits)
}
