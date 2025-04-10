import Foundation

class information: ObservableObject {
    @Published var arraydigi: [Batimentos] = []

    func fetch() {
        guard let url = URL(string: "http://192.168.128.100:1880/via3") else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }

            do {
                let parsed = try JSONDecoder().decode([Batimentos].self, from: data)
                DispatchQueue.main.async {
                    self?.arraydigi = parsed
                }
            } catch {
                print("Erro ao decodificar JSON: \(error)")
            }
        }

        task.resume()
    }
}
