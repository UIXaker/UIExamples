import SwiftUI

struct MagicView: View {
    var body: some View {
        VStack {
            Button(action: { }) {
                Text("Start with AI")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
            }
            .buttonStyle(MagicStyle(gradientColors: [.blue, .purple]))
        }
    }
}

#Preview {
    VStack {
        MagicView()
    }
    .padding()
}
