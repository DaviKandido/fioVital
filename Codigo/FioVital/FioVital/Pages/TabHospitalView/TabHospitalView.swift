//
//  TabView.swift
//  FioVital
//
//  Created by Turma02-9 on 07/04/25.
//

import SwiftUI

struct TabHospitalView: View {
    var body: some View {
        TabView{
            
            AcompanhamentoView()
                .tabItem{
                    Label("Home", systemImage: "house")
                }
            
            
        }

    }
}

#Preview {
    TabHospitalView()
}
