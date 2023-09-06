import SwiftUI

struct TestStruct: View {
    @State var needPresent: Bool = false
    
    var body: some View {
        Button {
            needPresent = true
        } label: {
            Text("Present")
        }
        .sheet(isPresented: $needPresent) {
            NotificationSetupView()
        }
        
    }
}


struct NotificationSetupView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var animate = false
    
    let blurHeight = 200.0
    let buttonHeight = 24.0
    let blurTint: UIColor = .secondarySystemBackground.withAlphaComponent(0)
    let model = NotificationSetupModel.initial
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        VStack(spacing: 16) {
                            Image(systemName: "app.badge")
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
                                .kerning(-0.33)
                                .multilineTextAlignment(.center)
                                .lineSpacing(2)
                                .padding(.horizontal, 40)
                        }
                        .offset(y: -12)
                        
                        VStack(alignment: .leading, spacing: 38) {
                            ForEach(model.notifications, id: \.self) { item in
                                HStack(spacing: 10) {
                                    Image(systemName: item.systemNamed)
//                                        .symbolEffect(.bounce.up.byLayer, value: animate)
                                        .font(.system(size: 36, weight: .semibold))
                                        .frame(width: 52, height: 52)
                                        .foregroundColor(.secondary)
                                        .fontWeight(.semibold)
                                        .padding(.leading, 24)
                                        .onAppear {
                                            animate.toggle()
                                        }
                                    
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(item.title)
                                            .kerning(-0.22)
                                            .font(.system(size: 15, weight: .semibold))
                                        
                                        Text(item.subtitle)
                                            .kerning(-0.33)
                                            .font(.system(size: 15, weight: .regular))
                                            .foregroundColor(.secondary)
                                            .multilineTextAlignment(.leading)
                                    }
                                    .padding(.trailing, 32)
                                }
                            }
                        }
                        .offset(y: 38)
                    }
                    .padding()
                    .padding(.top, geometry.size.height/12 + geometry.safeAreaInsets.top)
                    .padding(.bottom, geometry.size.height/12 + geometry.safeAreaInsets.bottom + blurHeight)
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
                            if let url = URL(string: UIApplication.openSettingsURLString) {
                                UIApplication.shared.open(url)
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

struct NotificationSetupModel {
    private var _notifications: [NotificationSetup]
    var notifications: [NotificationSetup] { return _notifications }
    
    init(notifications: [NotificationSetup]) {
        _notifications = notifications
    }
    
    subscript(dreamAt index: Int) -> NotificationSetup {
        get {
            return _notifications[index]
        }
        
        set {
            _notifications[index] = newValue
        }
    }
    
    static var initial: NotificationSetupModel {
        return NotificationSetupModel(notifications: [
            NotificationSetup(
                systemNamed: "shippingbox",
                title: "Order Status",
                subtitle: "Receive status alerts about your latest order activity."
            ),
            NotificationSetup(
                systemNamed: "calendar",
                title: "Session Reminders",
                subtitle: "Get reminders about your upcoming Today at Apple sessions."
            ),
            NotificationSetup(
                systemNamed: "bell.badge",
                title: "Announcements and Offers",
                subtitle: "Get information on new products, special store events, personalized recommendations and more."
            ),
            NotificationSetup(
                systemNamed: "calendar",
                title: "Session Reminders",
                subtitle: "Get reminders about your upcoming Today at Apple sessions."
            ),
            NotificationSetup(
                systemNamed: "calendar",
                title: "Session Reminders",
                subtitle: "Get reminders about your upcoming Today at Apple sessions."
            ),
            NotificationSetup(
                systemNamed: "calendar",
                title: "Session Reminders",
                subtitle: "Get reminders about your upcoming Today at Apple sessions."
            ),
        ])
    }
}

extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

struct NotificationSetup: Hashable {
    var systemNamed: String
    var title: String
    var subtitle: String
}

struct NotificationSetupView_Previews: PreviewProvider {
    static var previews: some View {
        TestStruct()
    }
}
