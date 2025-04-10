import SwiftUI
import Charts

struct GraficoView: View {
    @StateObject private var info = information()

    // Timer que dispara a cada 60 segundos
    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()

    // Data de hoje no formato "dd/MM/yyyy"
    private var dataDeHoje: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: Date())
    }

    var body: some View {
        VStack {
            Text("Batimentos Cardíacos - \(dataDeHoje)")
                .font(.title2)
                .fontWeight(.bold)

            if filtradosPorDataAtual.isEmpty {
                Text("Sem dados disponíveis para hoje.")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                Chart(filtradosPorDataAtual) { batimento in
                    if let bpm = Double(batimento.bpm) {
                        LineMark(
                            x: .value("Hora", batimento.hora),
                            y: .value("BPM", bpm)
                        )

                        PointMark(
                            x: .value("Hora", batimento.hora),
                            y: .value("BPM", bpm)
                        )
                        .foregroundStyle(.red)
                    }
                }
                .frame(height: 200)
                .padding()
            }
        }
        .padding()
        .onAppear {
            info.fetch()
        }
        .onReceive(timer) { _ in
            info.fetch()
        }
    }

    // Filtro para dados do dia atual em intervalos de 10 em 10 minutos
    var filtradosPorDataAtual: [Batimentos] {
        info.arraydigi.filter { batimento in
            batimento.data == dataDeHoje && minutoEhMultiploDe10(hora: batimento.hora)
        }
    }

    // Função auxiliar: verifica se os minutos da hora são múltiplos de 10
    func minutoEhMultiploDe10(hora: String) -> Bool {
        
        //Divide a string da hora (ex: "14:30") em partes separadas pelo caractere
        let componentes = hora.split(separator: ":")
        
    //    Verifica se a hora tem pelo menos dois componentes (hora e minuto).
        if componentes.count >= 2, let minuto = Int(componentes[1]) {
            return minuto % 5 == 0
        }
        return false
    }
}

// MARK: - Preview
#Preview {
    GraficoView()
}
