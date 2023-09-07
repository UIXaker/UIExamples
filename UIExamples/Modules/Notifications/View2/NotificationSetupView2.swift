import SwiftUI

struct NotificationSetupView2: View {
    @Environment(\.dismiss) private var dismiss
    @State var animate: Bool = false
    @State var test = false
    
    let blurHeight = 66.0
    let blurTint: UIColor = .secondarySystemBackground.withAlphaComponent(0)
    let center = UNUserNotificationCenter.current()
    let impactFeedback = UIImpactFeedbackGenerator(style: .soft)
    let model = NotificationSetupModel.initialPush
    
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
                    .animation(.spring().speed(0.5), value: animate)
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
                .mask({
                    LinearGradient(
                        gradient: Gradient(colors: [.clear, .black]),
                        startPoint: UnitPoint(x: 0, y: 1),
                        endPoint: UnitPoint(x: 0, y: 0)
                    )
                })
                .frame(height: blurHeight)
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct NotificationPushView: View {
    let model: NotificationPushModel
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            HStack(alignment: .center, spacing: 10) {
                NotificationPushImageView(model: model)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(model.title)
                        .font(.system(size: 15, weight: .semibold))
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                    
                    Text(model.subtitle)
                        .padding(.all, 0)
                        .font(.system(size: 15))
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 2)
                        .lineLimit(4)
                }
                
                if model.contentImage != nil {
                    Spacer(minLength: 40)
                } else {
                    Spacer()
                }
            }
            
            VStack(alignment: .trailing, spacing: 6) {
                Text(model.time)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.trailing)
                    .font(.system(size: 13))
                
                if let contentImage = model.contentImage {
                    Image(uiImage: contentImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 32, height: 32)
                        .mask {
                            RoundedRectangle(cornerRadius: 5, style: .continuous)
                        }
                }
            }
        }
        .padding(EdgeInsets(top: 14.0, leading: 14.0, bottom: 12.0, trailing: 18.0))
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 24.0, style: .continuous))
    }
}

struct NotificationPushImageView: View {
    var model: NotificationPushModel
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            if let userImage = model.userImage {
                Image(uiImage: userImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 38, height: 38)
                    .cornerRadius(38/2)
                    .clipped()
                
                Image(uiImage: model.icon)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 16, height: 16)
                    .cornerRadius(4)
                    .clipped()
                    .offset(x: 3, y: 2.5)
            } else {
                Image(uiImage: model.icon)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 38, height: 38)
                    .cornerRadius(8)
                    .clipped()
            }
        }
    }
}

struct NotificationPushStackView: View {
    let model: NotificationPushModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            NotificationPushView(model: .init())
                .padding(.horizontal, 25)
            
            NotificationPushView(model: .init())
                .padding(.bottom, 8)
                .padding(.horizontal, 15)
            
            NotificationPushView(model: model)
                .padding(.bottom, 16)
        }
    }
}

struct NotificationSetupView2_Previews: PreviewProvider {
    static var previews: some View {
        NotificationSetupView2()
    }
}
