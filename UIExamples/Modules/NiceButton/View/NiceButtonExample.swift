import SwiftUI

struct NiceButtonExample: View {
    @Environment(\.dismiss) private var dismiss
    let impactFeedback = UIImpactFeedbackGenerator(style: .soft)
    @State private var isPresented = false
    
    var body: some View {
        GeometryReader { geometry in
            Button {
                dismiss()
            } label: { }
                .buttonStyle(CircleSmallButton(icon: "xmark"))
                .offset(y: geometry.safeAreaInsets.top)
            
            Button(action: {
                impactFeedback.impactOccurred()
            }) {
                Text("Button")
                    .foregroundColor(.white)
            }
            .buttonStyle(NiceButton(color: .blue))
            .offset(y: geometry.size.height/2)
            .padding(.horizontal, 40)
        }
    }
}

struct NiceButtonExample_Previews: PreviewProvider {
    static var previews: some View {
        NiceButtonExample()
    }
}

struct NewView: View {
    var body: some View {
        Text("Это новая вьюха!")
            .navigationTitle("Example #2")
            .navigationBarTitleDisplayMode(.inline)
    }
}
