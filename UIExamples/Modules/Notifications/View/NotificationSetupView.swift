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
    let blurHeight = 150.0
    let buttonHeight = 24.0
    let blurTint: UIColor = .secondarySystemBackground.withAlphaComponent(0)
    let model = NotificationSetupModel.initial
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 0) {
                GeometryReader { scrollGeometry in
                        ScrollView(.vertical) {
                            VStack {
                                VStack(spacing: 16) {
                                    Image(systemName: "app.badge")
                                        .offset(x: -2, y: -10)
                                        .frame(width: 66, height: 66)
                                        .font(.system(size: 56, weight: .semibold))
                                        .foregroundColor(.red)
                                        .fontWeight(.semibold)
                                                                    
                                    Text("Let's set up your notifications.")
                                        .font(.system(size: 34, weight: .bold))
                                        .multilineTextAlignment(.center)
                                        .kerning(-0.2)
                                        .padding(.horizontal, 40)
                                        
                                    Text("You can modify and turn off individual notifications at any time in Settings.")
                                        .font(.system(size: 16))
                                        .kerning(0.33)
                                        .multilineTextAlignment(.center)
                                        .lineSpacing(2)
                                        .padding(.horizontal, 40)
                                }
                                .offset(y: -12)
                                
                                VStack(alignment: .leading, spacing: 38) {
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
                                .offset(y: 38)
                            }
                            .padding()
                            .frame(width: scrollGeometry.size.width)
                            .frame(minHeight: scrollGeometry.size.height)
                        }
                }
                
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
                    .buttonStyle(NiceButton(color: .red))
                    .padding(.horizontal, 44)
                    
                    Button {
                        dismiss()
                    } label: {
                        Text("Not Now")
                            .foregroundColor(.red)
                            .fontWeight(.semibold)
                    }
                    .frame(height: 51)
                    
                    #warning("KOSTIL")
                    Rectangle()
                        .frame(width: 0, height: 0)
                }
                .offset(y: 4)
            }
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
            )
        ])
    }
}

struct NotificationSetup: Hashable {
    var systemNamed: String
    var title: String
    var subtitle: String
}

struct NotificationSetupView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationSetupView()
    }
}
