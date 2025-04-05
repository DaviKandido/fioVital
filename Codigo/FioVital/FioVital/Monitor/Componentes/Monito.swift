//
//  Monito.swift
//  FioVital
//
//  Created by Turma02-9 on 04/04/25.
//

import SwiftUI

struct Monitor: View {
    
    @State var min: Int = 85
    @State var med: Int = 95
    @State var max: Int = 107
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.redFioVital.opacity(0.5))
                .frame(width: 350, height: 150)
                .cornerRadius(20)
                .shadow(color: .black, radius: 80, x:10, y:10)

            
            HStack{
                Spacer()
                VStack{
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                        .padding(.leading, -35)
                    HStack{
                        Text("\(min)")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .padding(.trailing, -8)
                        Text("BPM")
                            .padding(.top, 5)
                    }
                    Text("min.")
                        .padding(.leading, -32)
                }
                Spacer()
                VStack{
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                        .padding(.leading, -35)
                    HStack{
                        Text("\(med)")
                            .font(.title)
                            .padding(.trailing, -8)
                        Text("BPM")
                            .padding(.top, 5)
                    }
                    Text("med.")
                        .padding(.leading, -32)
                }
                Spacer()
                VStack{
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                        .padding(.leading, -35)
                    HStack{
                        Text("\(max)")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .padding(.trailing, -8)
                        Text("BPM")
                            .padding(.top, 5)
                    }
                    Text("max.")
                        .padding(.leading, -32)
                }
                Spacer()
            }
        }
    }
}

#Preview {
    Monitor()
}
