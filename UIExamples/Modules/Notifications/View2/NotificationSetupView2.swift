import SwiftUI

struct NotificationSetupView2: View {
    @Environment(\.dismiss) private var dismiss
    @State var animate: Bool = false
    
    let blurHeight = 66.0
    let blurTint: UIColor = .secondarySystemBackground.withAlphaComponent(0)
    let center = UNUserNotificationCenter.current()
    let impactFeedback = UIImpactFeedbackGenerator(style: .soft)
    let model = NotificationSetupModel.initial
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                Spacer(minLength: 0)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: animate ? 10 : -100) {
                        ForEach(model.notificationPushes, id: \.self) { model in
                            NotificationPushView(model: model)
                                .rotationEffect(Angle(degrees: 180)).scaleEffect(x: -1.0, y: 1.0, anchor: .center)
                        }
                    }
                    .animation(.spring().speed(0.4), value: animate)
                }
                .scrollDisabled(true)
                .rotationEffect(Angle(degrees: 180)).scaleEffect(x: -1.0, y: 1.0, anchor: .center)
                .onAppear {
                    animate.toggle()
                }
                
                VStack(spacing: 18) {
                    Text("Let's set up your notifications.")
                        .font(.system(size: 34, weight: .bold))
                        .multilineTextAlignment(.center)
                        .kerning(-0.22)
                        .padding(.top, 22)
                    
                    Text("You can modify and turn off individual notifications at any time in Settings.")
                        .font(.system(size: 16))
                        .multilineTextAlignment(.center)
                        .lineSpacing(2)
                }
                
                Spacer()
                
                VStack(spacing: 4) {
                    Button(action: {
                        impactFeedback.impactOccurred()
                        
                        Task {
                            _ = try? await center.requestAuthorization(options: [.alert, .sound, .badge])
                            dismiss()
                        }
                    }) {
                        Text("Turn on Notifications")
                            .foregroundColor(.white)
                            .frame(height: 24)
                    }
                    .buttonStyle(NiceButton(color: .blue))
                    
                    Button {
                        dismiss()
                    } label: {
                        Text("Not Now")
                            .foregroundColor(.blue)
                            .fontWeight(.semibold)
                    }
                    .frame(height: 50)
                    .padding(.bottom, 6)
                }
                .padding(.top, 24)
            }
            .padding(.horizontal, 44)
            
            BlurView(colorTint: blurTint)
                .mask {
                    LinearGradient(
                        gradient: Gradient(colors: [.clear, .black]),
                        startPoint: UnitPoint(x: 0, y: 1),
                        endPoint: UnitPoint(x: 0, y: 0)
                    )
                }
                .frame(height: blurHeight)
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct NotificationSetupView2_Previews: PreviewProvider {
    static var previews: some View {
        NotificationSetupView2()
    }
}
