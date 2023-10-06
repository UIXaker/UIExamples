import SwiftUI

struct MagicStyle: ButtonStyle {
    @State var color: Color = .clear
    @State var gradientColors: [Color] = []
    @StateObject private var animator = ParticleAnimator()
    @State private var animateGradient: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack(alignment: .center) {
            ForEach(animator.particles.filter { $0.type == .down }, id: \.self) {
                ButtonParticleView(particle: $0)
            }
            
            SetupConfiguration(configuration)
                .onPreferenceChange(MagicStyleBounce.self) { rect in
                    animator.rect = rect
                }
            
            ForEach(animator.particles.filter { $0.type == .up }, id: \.self) {
                ButtonParticleView(particle: $0)
                    .blendMode(.softLight)
            }
        }
        .onAppear {
            animator.animate()
        }
        .onDisappear {
            animator.animate()
        }
    }
    
    private func SetupConfiguration(_ configuration: Configuration) -> some View {
        configuration.label
            .onChange(of: configuration.isPressed, { oldValue, newValue in
                animator.isPressed = newValue
            })
            .foregroundColor(.white)
            .font(.system(size: 18, weight: .semibold))
            .padding(.top, configuration.isPressed ? 14 : 13)
            .padding(.bottom, configuration.isPressed ? 13 : 14)
            .padding(.horizontal, 30)
            .background(color)
            .background(
                LinearGradient(
                    colors: gradientColors,
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .hueRotation(.degrees(animateGradient ? 45 : 0))
                .onAppear {
                    withAnimation(.easeInOut(duration: 3).repeatForever()) {
                        animateGradient.toggle()
                    }
                }
            )
            .overlay(configuration.isPressed ? Color.black.opacity(0.15) : Color.clear)
            .clipShape(.rect(cornerRadius: configuration.isPressed ? 16 : 14))
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .shadow(
                color: configuration.isPressed ? Color.black.opacity(0.1) : Color.clear,
                radius: configuration.isPressed ? 10 : 0,
                x: configuration.isPressed ? 0 : 0,
                y: configuration.isPressed ? -3 : 0
            )
            .animation(.spring().speed(1.5), value: configuration.isPressed)
            .background(
                GeometryReader {
                    Color.clear.preference(
                        key: MagicStyleBounce.self,
                        value: $0.frame(in: .local)
                    )
                }
            )
    }
}

#Preview {
    VStack {
        Button(action: {}, label: {
            Text("Create with AI")
                .foregroundStyle(.white)
        })
        .buttonStyle(MagicStyle(gradientColors: [.blue, .purple]))
    }
}
