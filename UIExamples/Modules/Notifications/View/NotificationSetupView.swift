import SwiftUI

struct NotificationSetupView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var animate = false
    
    let blurHeight = 160.0
    let buttonHeight = 24.0
    let blurTint: UIColor = .secondarySystemBackground.withAlphaComponent(0)
    let center = UNUserNotificationCenter.current()
    let impactFeedback = UIImpactFeedbackGenerator(style: .soft)
    let model = NotificationSetupModel.initial
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        VStack(spacing: 16) {
                            Image(systemName: "app.badge")
//                                .symbolEffect(.bounce.up.byLayer, value: animate)
                                .frame(width: 66, height: 66)
                                .font(.system(size: 56, weight: .semibold))
                                .foregroundColor(.red)
                                .fontWeight(.semibold)
                            
                            Text("Let's set up your notifications.")
                                .font(.system(size: 34, weight: .bold))
                                .multilineTextAlignment(.center)
                                .kerning(-0.22)
                                .padding(.horizontal, 40)
                                .padding(.top, 6)
                            
                            Text("You can modify and turn off individual notifications at any time in Settings.")
                                .font(.system(size: 16))
                                .multilineTextAlignment(.center)
                                .lineSpacing(2)
                                .padding(.horizontal, 40)
                        }
                        .offset(y: -12)
                        
                        VStack(alignment: .leading, spacing: 32) {
                            ForEach(model.notifications, id: \.self) { item in
                                HStack(spacing: 10) {
                                    Image(systemName: item.systemNamed)
                                        .font(.system(size: 36, weight: .semibold))
                                        .frame(width: 52, height: 52)
                                        .foregroundColor(.secondary)
                                        .fontWeight(.semibold)
                                        .padding(.leading, 24)
                                    
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(item.title)
                                            .font(.system(size: 15, weight: .semibold))
                                        
                                        Text(item.subtitle)
                                            .font(.system(size: 15, weight: .regular))
                                            .foregroundColor(.secondary)
                                            .multilineTextAlignment(.leading)
                                    }
                                    .padding(.trailing, 32)
                                }
                            }
                        }
                        .offset(y: 18)
                    }
                    .padding()
                    .padding(.top, geometry.size.height/12 + geometry.safeAreaInsets.top)
                    .padding(.bottom, geometry.safeAreaInsets.bottom + blurHeight)
                }
                .onAppear {
                    animate.toggle()
                }
                .onTapGesture {
                    animate.toggle()
                }
                
                ZStack(alignment: .bottom) {
                    BlurView(colorTint: blurTint)
                        .mask({
                            LinearGradient(
                                gradient: Gradient(colors: [.clear, .black]),
                                startPoint: UnitPoint(x: 0, y: 0.1),
                                endPoint: UnitPoint(x: 0, y: 0.4)
                            )
                        })
                        .frame(height: blurHeight + geometry.safeAreaInsets.bottom)
                    
                    VStack(spacing: 4) {
                        Button(action: {
                            impactFeedback.impactOccurred()
                            center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                                if let error = error {
                                    // Handle the error here.
                                }
                                
                                dismiss()
                            }
                        }) {
                            Text("Turn on Notifications")
                                .foregroundColor(.white)
                                .frame(height: buttonHeight)
                        }
                        .buttonStyle(NiceButton(color: .blue))
                        .padding(.horizontal, 44)
                        
                        Button {
                            dismiss()
                        } label: {
                            Text("Not Now")
                                .foregroundColor(.blue)
                                .fontWeight(.semibold)
                        }
                        .frame(height: 51)
                    }
                    .padding(.bottom, geometry.safeAreaInsets.bottom)
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct NotificationSetupView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationSetupView()
    }
}
