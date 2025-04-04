//
//  ContentView.swift
//  FioVital
//
//  Created by Turma02-9 on 04/04/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack{
            ZStack{
                Color.background
                    .ignoresSafeArea()
                
                VStack {
                    Image("logo")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                        .padding(.top, -60)
                        .scaledToFit()
                    
                    Group{
                        HStack{
                            Text("Tecendo o que é")
                            Text("vital")
                                .foregroundStyle(.red)
                        }
                        Text("para você")
                    }
                    .fontWeight(.medium)
                    .font(.system(size: 35))
                    .padding()
                    
                    Spacer()
                    
                    NavigationLink(destination: CadastroView()){
                        ZStack{
                            Rectangle()
                                .frame(width: 150,height: 60)
                                .foregroundColor(.redFioVital)
                                .cornerRadius(20)
                                .opacity(0.5)
                            Text("Começar")
                                .foregroundStyle(.white)
                                .fontWeight(.heavy)
                                .font(.system(size: 25))
                        }
                    }
                    
                    Spacer()

                }
                .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
