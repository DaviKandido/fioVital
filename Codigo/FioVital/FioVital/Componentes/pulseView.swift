//
//  pulseView.swift
//  FioVital
//
//  Created by Turma02-9 on 04/04/25.
//

import SwiftUI

struct pulseView: View {
    
    @State var color: Color = .green
    @State var bpm: Int = 70
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(color.opacity(0.7))
                .frame(width: 130, height: 130)
                .cornerRadius(20)
            VStack {
                Text(
                    bpm < 90 ?
                    "Cuidado": "Ideal"
                )
                .font(.callout)
                .padding(.trailing, 40)
                
                HStack {
                    Text("\(bpm)")
                        .font(.title)
                        .padding(.trailing, -8)
                    Text("BPM")
                        .padding(.top, 5)
                }
                Text(
                    "Status"
                )
                .font(.callout)
                .padding(.leading, 40)

            }
        }
    }
}

#Preview {
    pulseView()
}
