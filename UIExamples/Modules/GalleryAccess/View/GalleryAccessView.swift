import SwiftUI

struct GalleryAccessView: View {
    @Environment(\.dismiss) private var dismiss
    let blurHeight = 150.0
    let openSettingsButtonHeight = 48.0
    let blurTint: UIColor = .secondarySystemBackground.withAlphaComponent(0)
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                VStack {
                    GeometryReader { scrollViewGeometry in
                        ScrollView {
                            VStack(spacing: 18) {
                                Spacer(minLength: geometry.safeAreaInsets.top)
                                
                                Text(LocalizedStringKey("access-restricted_title"))
                                    .font(.system(size: 34, weight: .bold))
                                    .multilineTextAlignment(.center)
                                    .padding(.top, 20)
                                    .padding(.bottom, -2)
                                    .fixedSize(horizontal: false, vertical: true)
                                
                                StepView(type: .first) { }
                                    .padding(.horizontal, 0)
                                
                                StepView(type: .second) {
                                    SettingsView(imageName: "app-photos", primaryText: LocalizedStringKey("access-restricted_settings_app-photos"), secondaryText: LocalizedStringKey("access-restricted_settings_app-photos_none"))
                                        .clipShape(RoundedRectangle(cornerRadius: 14))
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 14)
                                                .stroke(Color.primary.opacity(0.2), lineWidth: 0.5)
                                        }
                                }
                                .padding(.horizontal, 0)
                                
                                StepView(type: .third) {
                                    SettingsTableView()
                                        .clipShape(RoundedRectangle(cornerRadius: 14))
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 14)
                                                .stroke(Color.primary.opacity(0.2), lineWidth: 0.5)
                                        }
                                }
                                .padding(.horizontal, 0)
                                
                                StepView(type: .fourth) { }
                                    .padding(.horizontal, 0)
                                
                                Spacer().frame(height: openSettingsButtonHeight + 20)
                            }
                            .padding(.horizontal, 40)
                            .padding(.bottom, blurHeight)
                            .frame(width: scrollViewGeometry.size.width)
                            .frame(minHeight: scrollViewGeometry.size.height)
                        }
                        .scrollIndicators(.never)
                    }
                }
                
                ZStack() {
                    BlurView(colorTint: blurTint)
                        .mask({
                            LinearGradient(
                                gradient: Gradient(colors: [.clear, .black]),
                                startPoint: UnitPoint(x: 0, y: 0.1),
                                endPoint: UnitPoint(x: 0, y: 0.4)
                            )
                        })
                        .frame(height: blurHeight + geometry.safeAreaInsets.bottom)
                        

                    Button(action: {
                        if let url = URL(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        Text(LocalizedStringKey("access-restricted_btn"))
                            .foregroundColor(.white)
                    }
                    .buttonStyle(NiceButton(color: .blue))
                    .frame(height: openSettingsButtonHeight)
                    .padding(.horizontal, 40)
                    .offset(y: -geometry.safeAreaInsets.bottom/2 + (blurHeight - openSettingsButtonHeight)/2 - 40)
                }
                .offset(y: geometry.size.height + geometry.safeAreaInsets.top - blurHeight)
                
                Button {
                    dismiss()
                } label: { }
                    .buttonStyle(CircleSmallButton(icon: "xmark"))
                    .offset(y: geometry.safeAreaInsets.top)
                
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

private func openSettings() {
    guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
    if UIApplication.shared.canOpenURL(settingsURL) {
        UIApplication.shared.open(settingsURL)
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct StepView<Content: View>: View {
    let type: StepType
    let settingsView: Content
    
    enum StepType: Int {
        case first = 1
        case second
        case third
        case fourth
        
        var index: String {
            return self.rawValue.description
        }
        
        var stringKey: LocalizedStringKey {
            switch self {
            case .first: return LocalizedStringKey("access-restricted_step-1")
            case .second: return LocalizedStringKey("access-restricted_step-2")
            case .third:
                if #available(iOS 17.0, *) {
                    return LocalizedStringKey("access-restricted_step-3-ios17")
                }
                
                return LocalizedStringKey("access-restricted_step-3")
            case .fourth: return LocalizedStringKey("access-restricted_step-4")
            }
        }
    }
    
    init(type: StepType, @ViewBuilder settingsView: () -> Content) {
        self.type = type
        self.settingsView = settingsView()
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 10) {
                Circle()
                    .foregroundColor(.blue)
                    .frame(width: 24, height: 24)
                    .overlay(
                        Text(type.index)
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                    )

                
                VStack(alignment: .leading) {
                    Text(type.stringKey)
                        .padding(.top, 2)
                        .font(.system(size: 18))
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    settingsView
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
    }
}

struct SettingsTableView: View {
    var tableTitle: String {
        if #available(iOS 17.0, *) {
            return "access-restricted_settings_tableview-group_title-ios17"
        } else {
            return "access-restricted_settings_tableview-group_title"
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(LocalizedStringKey(tableTitle))
                .font(.system(size: 11, weight: .regular))
                .foregroundColor(.secondary)
                .padding(.top, 10)
                .padding(.leading, 14)
                .padding(.bottom, 8)
                .textCase(.uppercase)
            
            if #available(iOS 17.0, *) {
                TableRowView(
                    primaryText: "access-restricted_settings_tableview-group_none"
                )
            } else {
                TableRowView(
                    primaryText: "access-restricted_settings_tableview-group_selected"
                )
            }

            SeparatorView()
            
            if #available(iOS 17.0, *) {
                TableRowView(
                    primaryText: "access-restricted_settings_tableview-group_selected-ios17",
                    subtitle: "access-restricted_settings_tableview-group_selected-ios17_subtitle"
                )
            } else {
                TableRowView(
                    primaryText: "access-restricted_settings_tableview-group_all",
                    secondarySymbol: "checkmark"
                )
            }
            
            SeparatorView()
            
            if #available(iOS 17.0, *) {
                TableRowView(
                    primaryText: "access-restricted_settings_tableview-group_all-ios17",
                    secondarySymbol: "checkmark",
                    subtitle: "access-restricted_settings_tableview-group_all-ios17_subtitle"
                )
            } else {
                TableRowView(
                    primaryText: "access-restricted_settings_tableview-group_none"
                )
            }
        }
        .background(Color(.systemGroupedBackground))
    }
}

struct TableRowView: View {
    var primaryText: LocalizedStringKey
    var secondarySymbol: String?
    var subtitle: LocalizedStringKey?
    
    init(primaryText: String, secondarySymbol: String? = nil, subtitle: String? = nil) {
        self.primaryText = LocalizedStringKey(primaryText)
        self.secondarySymbol = secondarySymbol
        
        if let subtitle {
            self.subtitle = LocalizedStringKey(subtitle)
        }
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(primaryText)
                        .font(.system(size: 16, weight: .regular))
                        .padding(.leading, 14)
                    
                    Spacer()
                }
                
                if let subtitle {
                    Text(subtitle)
                        .font(.system(size: 11, weight: .regular))
                        .foregroundColor(.secondary)
                        .padding(.leading, 14)
                        .offset(y: 2)
                        .padding(.bottom, 1)
                }
            }
            
            if let secondarySymbol {
                Image(systemName: secondarySymbol)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.blue)
                    .padding(.trailing, 14)
                    .padding(.bottom, 2)
            }
        }
        .padding(.vertical, 10)
        .background(Color(.secondarySystemGroupedBackground))
    }
}

struct SeparatorView: View {
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(Color(.secondarySystemGroupedBackground))
                    .frame(height: 0.33)
            Rectangle()
                .foregroundColor(Color.gray.opacity(0.8))
                .frame(maxWidth: .infinity)
                .frame(height: 0.33)
                .padding(.leading, 14)
        }}
}



struct SettingsView: View {
    var imageName: String
    var primaryText: LocalizedStringKey
    var secondaryText: LocalizedStringKey
    
    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 22, height: 22)
            
            Text(primaryText)
                .font(.system(size: 16, weight: .regular))
            
            Spacer()
            
            HStack(spacing: 6) {
                Text(secondaryText)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.secondary)
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
                    .font(.system(size: 14, weight: .regular))
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 10)
        .background(Color(.secondarySystemGroupedBackground))
    }
}


struct GalleryAccessView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryAccessView()
    }
}
