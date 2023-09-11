import SwiftUI

struct NotificationSetupView3: View {
    @Environment(\.dismiss) private var dismiss
    @State private var animate: Bool = false
    @State private var featuresHeight: CGFloat = 0
    @State private var pushesHeight: CGFloat = 0
    @State private var stopUpdateHeight: Bool = false
    @State private var pushesRowHeight: [CGFloat] = []
    
    let blurHeight = 66.0
    let blurTint: UIColor = .secondarySystemBackground.withAlphaComponent(0)
    let center = UNUserNotificationCenter.current()
    let impactFeedback = UIImpactFeedbackGenerator(style: .soft)
    let model = NotificationSetupModel.initial
    let contentOffset: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                VStack {
                    Spacer(minLength: 0)
                    
                    GeometryReader { contentGeometry in
                        ZStack(alignment: .top) {
                            VStack(spacing: 26) {
                                VStack(spacing: 12) {
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
                                
                                VStack(alignment: .leading, spacing: 20) {
                                    ForEach(model.notificationFeatures, id: \.self) { item in
                                        HStack(spacing: 8) {
                                            Spacer()
                                            
                                            Image(systemName: item.systemNamed)
                                                .font(.system(size: 16, weight: .semibold))
                                                .foregroundColor(.blue)
                                                .fontWeight(.semibold)
                                            
                                            VStack(alignment: .center, spacing: 2) {
                                                Text(item.title)
                                                    .font(.system(size: 15, weight: .semibold))
                                            }
                                            
                                            Spacer()
                                        }
                                    }
                                }
                            }
                            .background(
                                GeometryReader { geometry in
                                    Color.clear.preference(
                                        key: FeaturesPreferenceKey.self,
                                        value: geometry.size.height
                                    )
                                }
                            )
                            .offset(y: (contentGeometry.size.height - featuresHeight - pushesHeight)/2 + pushesHeight + contentOffset + geometry.safeAreaInsets.top)
                            
                            ScrollView(showsIndicators: false) {
                                VStack(spacing: animate ? 10 : -18) {
                                    ForEach(Array(model.notificationPushes.enumerated()), id: \.offset) { index, model in
                                        NotificationPushView(notStack: $animate, model: model, index: index)
                                            .padding(.bottom, calculatePaddingForPush(at: index))
                                            .scaleEffect(calculateScaleForPush(at: index))
                                            .zIndex(Double(self.model.notificationPushes.count - index))
                                            .rotationEffect(Angle(degrees: 180)).scaleEffect(x: -1.0, y: 1.0, anchor: .center)
                                            .background(
                                                GeometryReader { geometry in
                                                    Color.clear.preference(
                                                        key: PushViewPreferenceKey.self,
                                                        value: geometry.size.height
                                                    )
                                                }
                                            )
                                            .onPreferenceChange(PushViewPreferenceKey.self) {
                                                pushesRowHeight.append($0)
                                            }
                                    }
                                }
                                .padding(.horizontal, 24)
                                .background(
                                    GeometryReader { geometry in
                                        Color.clear.preference(
                                            key: PushesPreferenceKey.self,
                                            value: geometry.size.height
                                        )
                                    }
                                )
                            }
                            .scrollDisabled(true)
                            .rotationEffect(Angle(degrees: 180)).scaleEffect(x: -1.0, y: 1.0, anchor: .center)
                            .onTapGesture {
                                stopUpdateHeight = true
                                animate.toggle()
                            }
                            .offset(y: -contentGeometry.size.height + pushesHeight + (contentGeometry.size.height - featuresHeight - pushesHeight)/2 + contentOffset + geometry.safeAreaInsets.top)
                        }
                        .onPreferenceChange(FeaturesPreferenceKey.self) {
                            featuresHeight = $0
                        }
                        .onPreferenceChange(PushesPreferenceKey.self) {
                            if !stopUpdateHeight {
                                pushesHeight = $0
                            }
                        }
                    }
                    
                    Spacer(minLength: 0)
                    
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
            .animation(.spring().speed(0.7), value: animate)
            .edgesIgnoringSafeArea(.top)
        }
    }
    
    private func calculatePaddingForPush(at index: Int) -> CGFloat {
        guard !animate, index != 0, pushesRowHeight.count > index else { return 0.0 }
        
        let scale = 1.0 - CGFloat(index) / 10.0
        let scaledHeight = pushesRowHeight[index] * scale
        let heightDifference = pushesRowHeight[index] - scaledHeight
        
        if index > 2 {
            return -scaledHeight - heightDifference/2
        }
        
        return -abs(pushesRowHeight[0] - scaledHeight + heightDifference/2)
    }
    
    private func calculateScaleForPush(at index: Int) -> CGSize {
        guard !animate else { return CGSize(width: 1, height: 1) }
        
        let scale = animate ? 1 : 1.0 - CGFloat(index) / 10.0
        let size = CGSize(width: scale, height: scale)
        
        return size
    }
}

extension NotificationSetupView3 {
    struct FeaturesPreferenceKey: PreferenceKey {
        static let defaultValue: CGFloat = 0
        
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = max(value, nextValue())
        }
    }
    
    struct PushesPreferenceKey: PreferenceKey {
        static let defaultValue: CGFloat = 0
        
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = max(value, nextValue())
        }
    }
    
    struct PushViewPreferenceKey: PreferenceKey {
        static let defaultValue: CGFloat = 0
        
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = max(value, nextValue())
        }
    }
}

struct NotificationSetupView3_Previews: PreviewProvider {
    static var previews: some View {
        NotificationSetupView3()
    }
}
