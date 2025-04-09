//
//  Sheet.swift
//  FioVital
//
//  Created by Turma02-9 on 08/04/25.
//

import Foundation
import SwiftUI
import MapKit

struct Sheet:View {
    
    @State var paciente: pacient
    
    @State var longitudeVar: Double = -19.466666666667;
    @State var latitudeVar: Double = -44.252222222222;
    
    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: -19.466666666667, longitude: -44.252222222222),
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0 )
        )
    )
    
    var body: some View {
        
        ZStack{
            Color.background
                .ignoresSafeArea()
            VStack{
                Text("Paciente")
                    .font(.title)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
                Text(paciente.nome ?? "Descohecido")
                    .font(.title3)
                    .fontWeight(.medium)
                    .padding(.bottom, 15)
                
                Rectangle()
                    .frame(width: 300, height: 300)
                    .foregroundColor(.white)
                    .cornerRadius(30)
                    .overlay{
                        VStack{
                            Image(systemName: "person")
                                .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                            
                            Group {
                                HStack {
                                    Text("Paciente: \(paciente.nome ?? "Descohecido") ")
                                        .font(.title3)
                                        .fontWeight(.medium)
                                        .multilineTextAlignment(.leading)
                                        .padding(.top, 15)
                                        .padding(.bottom, 2)
                                    Spacer()
                                }
                                
                                HStack{
                                    Text("Idade: \(paciente.idade ?? "Descohecido") ")
                                        .font(.title3)
                                        .fontWeight(.medium)
                                        .padding(.bottom, 2)
                                    Spacer()
                                }
                                
                                HStack{
                                    Text("Complicação: \(paciente.hist_cond ?? "Descohecido") ")
                                        .font(.title3)
                                        .fontWeight(.medium)
                                        .padding(.bottom, 2)
                                    Spacer()
                                }
                                
                                HStack{
                                    Text("Endereço: \(paciente.endereco ?? "Descohecido") ")
                                        .font(.title3)
                                        .fontWeight(.medium)
                                        .padding(.bottom, 2)
                                    Spacer()
                                }
                                
                                HStack{
                                    Text("Ultima consulta: \(paciente.last_consulta ?? "Descohecido") ")
                                        .font(.title3)
                                        .fontWeight(.medium)
                                        .padding(.bottom, 5)
                                    Spacer()
                                }
                            }
                            .padding(.leading, 20)
                            
                            
                        }
                    }
                
                Map(position: $position){
                    Annotation(paciente.nome ?? "Erro", coordinate:
                                CLLocationCoordinate2D(latitude: Double(paciente.latitude!) ?? 0, longitude: Double(paciente.longitude!) ?? 0)
                    ){
                        Localizador(pacienteName: paciente.nome)
                    }
                    .annotationTitles(.hidden)
                    
                }
                .clipShape(
                    .rect(
                        topLeadingRadius: 35,
                        bottomLeadingRadius: 0,
                        bottomTrailingRadius: 0,
                        topTrailingRadius: 35
                    )
                )
            }
        }

    }
    
}

#Preview {
    Sheet(paciente: pacient(
        _id: "01921283",
        _rev: "0123128301",
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
