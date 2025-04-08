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
            Text("Batimentos Cardíacos")
                .font(.title2)
                .fontWeight(.bold)

            Chart(data) { point in
                LineMark(
                    x: .value("Tempo", point.time),
                    y: .value("BPM", point.bpm)
                )
                .interpolationMethod(.catmullRom)

                PointMark(
                    x: .value("Tempo", point.time),
                    y: .value("BPM", point.bpm)
                )
                .foregroundStyle(.red)
            }
            .frame(height: 200)
            .padding()

            Button("Reload") {
                loadHeartbeatData()
            }
            .padding()
            .buttonStyle(.borderedProminent)

            Spacer()
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

// MARK: - Tela Inicial
struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemBackground)
                    .ignoresSafeArea()

                VStack {
                    Image("logo")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                        .padding(.top, -60)
                        .padding(.horizontal, 20)
                        .scaledToFit()

                    Group {
                        HStack {
                            Text("Tecendo o que é")
                            Text("vital")
                                .foregroundStyle(.red)
                        }
                        Text("para você")
                    }
                    .fontWeight(.medium)
                    .font(.system(size: 35))

                    Spacer()
                        .padding(.top, 20)

                    NavigationLink(destination: GraficoView()) {
                        ZStack {
                            Rectangle()
                                .frame(width: 150, height: 60)
                                                                .cornerRadius(20)
                                .opacity(0.5)

                            Text("Começar")
                                .foregroundStyle(.white)
                                .fontWeight(.heavy)
                                .font(.system(size: 25))
                        }
                    }

                    Spacer()
                        .padding(.bottom, 20)
                }
                .padding()
            }
        }
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}
