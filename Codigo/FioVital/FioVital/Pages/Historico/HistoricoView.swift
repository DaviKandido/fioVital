import SwiftUI
import Charts

struct HistoricoView: View {
    @StateObject private var info = Information()
    @State private var dataSelecionada = Date()
    @State private var irregularidades = 0

    var body: some View {
        ZStack{
            Color.background
                .ignoresSafeArea()
            
            VStack {
                Text("Histórico")
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .padding(.top, 10)
                    .padding(.horizontal)
                
                Spacer()
                
                
                DatePicker("Escolha uma data", selection: $dataSelecionada, displayedComponents: [.date])
                    .datePickerStyle(.compact)
                    .padding()
                
                Text("Histórico de Batimentos - \(formatarData(dataSelecionada))")
                    .font(.title2)
                    .fontWeight(.bold)
                
                
                if filtradosPorDataSelecionada.isEmpty {
                    Text("Sem dados disponíveis para essa data.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    Chart(filtradosPorDataSelecionada) { batimento in
                        if let bpm = Double(batimento.bpm) {
                            LineMark(
                                x: .value("Hora", batimento.hora),
                                y: .value("BPM", bpm)
                            )
                            PointMark(
                                x: .value("Hora", batimento.hora),
                                y: .value("BPM", bpm)
                            )
                            .foregroundStyle(.blue)
                        }
                    }
                    .frame(height: 200)
                    .padding()
                    
                    Text("Irregularidades no dia: \(irregularidades)")
                        .foregroundColor(.red)
                        .font(.headline)
                        .padding(.bottom)
                }
                Spacer()
            }
            .padding()
            .onAppear {
                info.fetch()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    contarIrregularidades()
                }
            }
            .onChange(of: dataSelecionada) { _ in
                contarIrregularidades()
            }
        }
        
    }

    func formatarData(_ data: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: data)
    }

    func horaTemMinuto(_ hora: String, igualA alvo: Int) -> Bool {
        let componentes = hora.split(separator: ":")
        if componentes.count >= 2, let minuto = Int(componentes[1]) {
            return minuto == alvo
        }
        return false
    }

    func horaMinutoMultiploDe5(_ hora: String) -> Bool {
        let componentes = hora.split(separator: ":")
        if componentes.count >= 2, let minuto = Int(componentes[1]) {
            return minuto % 5 == 0
        }
        return false
    }

    func existemBatimentosPorHoraCheia(na data: String) -> Bool {
        return info.arraydigi.contains { batimento in
            batimento.data == data && horaTemMinuto(batimento.hora, igualA: 0)
        }
    }

    var filtradosPorDataSelecionada: [Batimentos] {
        let dataFiltrada = formatarData(dataSelecionada)

        if existemBatimentosPorHoraCheia(na: dataFiltrada) {
            return info.arraydigi.filter { batimento in
                batimento.data == dataFiltrada && horaTemMinuto(batimento.hora, igualA: 0)
            }
        } else {
            return info.arraydigi.filter { batimento in
                batimento.data == dataFiltrada && horaMinutoMultiploDe5(batimento.hora)
            }
        }
    }

    func contarIrregularidades() {
        let batimentosFiltrados = filtradosPorDataSelecionada

        let total = batimentosFiltrados.filter { batimento in
            if let bpm = Double(batimento.bpm) {
                return bpm < 50 || bpm > 110
            }
            return false
        }.count

        irregularidades = total
    }
}

// Preview
#Preview {
    HistoricoView()
}
