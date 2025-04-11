//
//  MonitorView.swift
//  FioVital
//
//  Created by Turma02-9 on 04/04/25.
//

import SwiftUI

struct MonitorView: View {
    
    @State var data: Date = Date()
    let someDateTime = Date()
    // Feb 2, 1997, 10:26 AM
    // Specify date components
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.background.ignoresSafeArea()
                
                VStack{
                    Text("Monitor")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)

                    
                    Monitor()
                    
                    Text(someDateTime.formatted(.dateTime.locale(Locale(identifier: "pt_BR"))
                        .month(.wide).day().year()))
                        .font(.title2)
                        .fontWeight(.medium)
                        .padding(5)
                    
                    GraficoView()
                        .frame(width: 350, height: 250)
                    
                    PulseView()
                    
                    Spacer()
                
                }
                
            }
            .navigationBarBackButtonHidden(true)
        }
        
        
    }
}

#Preview {
    MonitorView()
}
