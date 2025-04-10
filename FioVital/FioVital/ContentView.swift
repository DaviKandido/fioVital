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
                
                
                ScrollView(.vertical){
                    VStack {

                        Image("logo")
                            .resizable()
                            .frame(width: 450, height: 400)
                            .foregroundStyle(.tint)
                            .padding(.bottom, -40)
                        
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
                           
                        Spacer()
                            .padding(.bottom, 30)
                        
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
                        
                        
                    }
                }
                
                VStack {
                    HStack{
                        NavigationLink(destination: TabHospitalView()){
                            Rectangle()
                                .frame(width: 50, height: 50)
                                .opacity(0)
                                .overlay{
                                    Image(systemName: "cross.circle.fill")
                                        .font(.title)
                                    //                                .padding(.leading, 300)
                                    //                                .padding(.vertical, 50)
                                        .foregroundColor(.black)
                                }
                                .padding(.leading, 300)
                        }
                    }
                    Spacer()
                }
            }

        }

    }
}

#Preview {
    ContentView()
}
