import SwiftUI

struct ParticleView: View {
    var body: some View {
        VStack {
            Button(action: { }) {
                Text("Start with AI")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
            }
            .buttonStyle(ParticleStyle(gradientColors: [.blue, .purple]))
        }
    }
}

#Preview {
    VStack {
        ParticleView()
    }
    .padding()
}
