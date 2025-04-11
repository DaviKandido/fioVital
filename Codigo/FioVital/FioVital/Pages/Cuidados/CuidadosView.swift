import SwiftUI

struct CuidadosView: View {
    @State private var selectedCare: CareTip? = nil

    var body: some View {
        ZStack {
            Color(Color.background) // Cor personalizada de fundo
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 20) {
                
                Text("Cuidados")
                    .font(.title)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                        .padding(.top, 10)
                        .padding(.horizontal)


                // Lista de Cuidados
                VStack(spacing: 20) {
                    CareItem(title: "1. Respiração Diafragmática (Profunda)", tip: CareTip(
                        titulo: "Inspiração Profunda",
                        descricao: """
                        ✅ Sente-se ou deite-se confortavelmente.
                        ✅ Inspire lentamente pelo nariz contando até 4.
                        ✅ Segure o ar por 1 ou 2 segundos.
                        ✅ Expire lentamente pela boca contando até 6–8.
                        ✅ Repita por 1–2 minutos.

                        🎯 Efeito: ativa o nervo vago, que regula o sistema parassimpático e reduz o ritmo cardíaco.
                        """
                    ), selectedCare: $selectedCare)

                    CareItem(title: "2. Técnica 4-7-8 de Respiração", tip: CareTip(
                        titulo: "Respiração Lenta",
                        descricao: """
                        ✅ Passo a passo:
                        - Inspire pelo nariz por 4 segundos.
                        - Segure o ar por 7 segundos.
                        - Expire lentamente pela boca por 8 segundos.
                        - Repita 4 vezes.

                        🎯 Efeito: desacelera o metabolismo e induz relaxamento profundo.
                        """
                    ), selectedCare: $selectedCare)

                    CareItem(title: "3. Imobilidade Consciente (Parar e Sentar)", tip: CareTip(
                        titulo: "Foco na Respiração",
                        descricao: """
                        ✅ Quando estiver ansioso, sente-se calmamente, mantenha a postura ereta e:
                        - Relaxe os ombros.
                        - Deixe as mãos no colo.
                        - Respire fundo.

                        🎯 Efeito: o corpo percebe que não há "perigo", reduzindo os sinais de alerta.
                        """
                    ), selectedCare: $selectedCare)

                    CareItem(title: "4. Massagem no pescoço (nervo vago)", tip: CareTip(
                        titulo: "Exalação Consciente",
                        descricao: """
                        ✅ Massageie suavemente atrás das orelhas e no pescoço, onde passa o nervo vago.

                        🎯 Efeito: estimula o sistema parassimpático, contribuindo para relaxamento.
                        """
                    ), selectedCare: $selectedCare)
                    
                    
                    CareItem(title: "5. Meditação Guiada ou Mindfulness", tip: CareTip(
                        titulo: "Exalação Consciente",
                        descricao: """
                        ✅ Sente-se por 5 minutos, foque na respiração e deixe os pensamentos irem e virem.
                        """
                    ), selectedCare: $selectedCare)
                    
                    
                    CareItem(title: "6.  Água Fria no Rosto", tip: CareTip(
                        titulo: "Exalação Consciente",
                        descricao: """
                        Lave o rosto com água fria ou coloque uma toalha fria sobre os olhos por alguns segundos.
                        
                        ✅ Efeito: ativa o reflexo de mergulho (diving reflex), reduzindo o ritmo cardíaco rapidamente.
                        """
                    ), selectedCare: $selectedCare)
                }
                .padding(.horizontal)

                Spacer()
            }
        }
        .sheet(item: $selectedCare) { tip in
            DicaBatimentosView(titulo: tip.titulo, descricao: tip.descricao)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
        }
    }
}

// MARK: - Componente de Item de Cuidado
struct CareItem: View {
    var title: String
    var tip: CareTip
    @Binding var selectedCare: CareTip?

    var body: some View {
        Button {
            selectedCare = tip
        } label: {
            HStack {
                Text(title)
                    .font(.body)
                    .foregroundColor(.black)
                Spacer()
                HStack(spacing: 4) {
                    Text("Detalhes")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    Image(systemName: "arrow.up.heart")
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .background(Color.background)
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
        }
    }
}

// MARK: - Estrutura para Dica
struct CareTip: Identifiable {
    var id = UUID()
    var titulo: String
    var descricao: String
}

// MARK: - Sheet com Fundo Personalizado
struct DicaBatimentosView: View {
    var titulo: String
    var descricao: String

    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text(titulo)
                        .font(.title2)
                        .bold()
                        .foregroundColor(.black)

                    Text(descricao)
                        .font(.body)
                        .foregroundColor(.black)

                    Spacer()
                }
                .padding()
            }
        }
    }
}

// MARK: - Preview
#Preview {
    CuidadosView()
}
