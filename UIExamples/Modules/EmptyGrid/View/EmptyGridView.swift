import SwiftUI

struct EmptyGridView: View {
    @Environment(\.dismiss) private var dismiss
    private let impactFeedback = UIImpactFeedbackGenerator(style: .soft)
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                GridView()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                
                VStack {
                    Spacer()
                    
                    Text("You don't have any projects yet")
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.largeTitle)
                        .bold()
                        .padding(.horizontal, 40)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                }
                
                Button {
                    impactFeedback.impactOccurred()
                    dismiss()
                } label: {
                    
                }
                .buttonStyle(CircleSmallButton(icon: "xmark"))
            }
        }
    }
}

struct EmptyGridView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyGridView()
    }
}
