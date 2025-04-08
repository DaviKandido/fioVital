//
//  TabView.swift
//  FioVital
//
//  Created by Turma02-9 on 07/04/25.
//

import Foundation

//
//  ContentView.swift
//  FioVital
//
//  Created by Turma02-9 on 04/04/25.
//

import SwiftUI

struct TabPacientView: View {
    var body: some View {
        TabView{
            MonitorView()
                .tabItem{
                    Label("Home", systemImage: "house")
                }
            
            HistoricoView()
                .tabItem{
                    Label("Historico", systemImage: "calendar.badge.clock")
                }
            
            
            CuidadosView()
                .tabItem{
                    Label("Cuidados", systemImage: "cross.case.fill")
                }
        }

    }
}

#Preview {
    TabPacientView()
}
