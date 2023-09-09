import SwiftUI

struct NotificationSetupView3: View {
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
//                Spacer(minLength: 0)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: animate ? 10 : -44) {
                        ForEach(Array(model.notificationPushes.enumerated().prefix(3)), id: \.offset) { index, model in
                            NotificationPushView(model: model)
//                                .offset(y: animate ? 0 : CGFloat(index * 60))
//                                .padding(.horizontal,  animate ? 0 : CGFloat(index) * 10)
                                .rotationEffect(Angle(degrees: 180)).scaleEffect(x: -1.0, y: 1.0, anchor: .center)
                                .scaleEffect(x: animate ? 1 : 1.0 - CGFloat(index) / 10.0, y: animate ? 1 : 1.0 - CGFloat(index) / 10.0)
                                .zIndex(Double(self.model.notificationPushes.count - index))
                        }
                    }
                    .padding(.horizontal, 24)
                    .animation(.spring().speed(0.7), value: animate)
                }
                .scrollDisabled(true)
                .rotationEffect(Angle(degrees: 180)).scaleEffect(x: -1.0, y: 1.0, anchor: .center)
                .onTapGesture {
                    animate.toggle()
                }
                
                VStack(spacing: 18) {
                    Text("Get Notifications")
                        .font(.system(size: 34, weight: .bold))
                        .multilineTextAlignment(.center)
                        .kerning(-0.22)
                        .padding(.top, 22)
                    
                    Text("You can modify and turn off individual notifications at any time in Settings.")
                        .font(.system(size: 16))
                        .multilineTextAlignment(.center)
                        .lineSpacing(2)
                }
                .padding(.horizontal, 44)
                
                VStack(alignment: .leading, spacing: 18) {
                    ForEach(model.notificationFeatures, id: \.self) { item in
                        HStack(spacing: 10) {
                            Spacer()
                            
                            Image(systemName: item.systemNamed)
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.secondary)
                                .fontWeight(.semibold)
                            
                            VStack(alignment: .center, spacing: 2) {
                                Text(item.title)
                                    .font(.system(size: 15, weight: .semibold))
                            }
                            
                            Spacer()
                        }
                    }
                }
                .padding(.vertical, 18)
                
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
                .padding(.horizontal, 44)
            }
            
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

struct NotificationSetupView3_Previews: PreviewProvider {
    static var previews: some View {
        NotificationSetupView3()
    }
}
