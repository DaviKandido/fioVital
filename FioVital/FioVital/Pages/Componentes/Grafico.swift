import SwiftUI
import Charts

// MARK: - Modelo
struct Heartbeat: Identifiable, Codable {
    let id = UUID()
    let time: Int
    let bpm: Double
}

// MARK: - View Gráfico
struct GraficoView: View {
    @State private var data: [Heartbeat] = []

    var body: some View {
        VStack {
            Chart(data) { point in
                LineMark(
                    x: .value("Tempo", point.time),
                    y: .value("BPM", point.bpm)
                )
                .interpolationMethod(.linear)

                PointMark(
                    x: .value("Tempo", point.time),
                    y: .value("BPM", point.bpm)
                )
                .foregroundStyle(.red)
            }
            .frame(width: 320 ,height: 150)
        }
        .padding()
        .onAppear {
            loadHeartbeatData()
        }
    }

    func loadHeartbeatData() {
        let jsonString = """
        [
            { "time": 0, "bpm": 75 },
            { "time": 1, "bpm": 80 },
            { "time": 2, "bpm": 115 },
            { "time": 3, "bpm": 70 },
            { "time": 4, "bpm": 65 },
            { "time": 5, "bpm": 177 },
            { "time": 6, "bpm": 74 }
        ]
        """

        let jsonData = Data(jsonString.utf8)
        do {
            let decoded = try JSONDecoder().decode([Heartbeat].self, from: jsonData)
            data = decoded
        } catch {
            print("Erro ao carregar JSON: \(error)")
        }
    }
}


// MARK: - Preview
#Preview {
    GraficoView()
}
