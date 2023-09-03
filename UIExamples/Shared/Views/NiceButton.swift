//
//  NiceButton.swift
//  UIExamples
//
//  Created by Max Xaker on 03.09.2023.
//

import SwiftUI

struct NiceButton: ButtonStyle {
    @State var color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .font(.system(size: 18, weight: .semibold))
            .padding(.top, configuration.isPressed ? 14 : 13)
            .padding(.bottom, configuration.isPressed ? 13 : 14)
            .frame(maxWidth: .infinity)
            .background(color)
            .overlay(
                configuration.isPressed ? Color.black.opacity(0.15) : Color.clear
            )
            .cornerRadius(configuration.isPressed ? 16 : 14)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .shadow(color: configuration.isPressed ? Color.black.opacity(0.1) : Color.clear,
                    radius: configuration.isPressed ? 10 : 0,
                    x: configuration.isPressed ? 0 : 0,
                    y: configuration.isPressed ? -3 : 0)
            .animation(.spring().speed(1.5))
    }
}

struct NiceButton_Previews: PreviewProvider {
    static var previews: some View {
        Button("Nice Button", action: {})
        .buttonStyle(NiceButton(color: .blue))
    }
}
