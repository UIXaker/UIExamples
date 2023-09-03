import SwiftUI

struct CircleSmallButton: ButtonStyle {
    @State var icon: String
    private let blurTint: UIColor = .secondarySystemBackground.withAlphaComponent(0)
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Circle()
                .foregroundColor(.secondary.opacity(0.4))
                .overlay(
                    configuration.isPressed ? Color.black.opacity(0.15) : Color.clear
                )                .clipShape(Circle())
                .frame(width: 30, height: 30)

            BlurView(colorTint: blurTint)
                .clipShape(Circle())
                .frame(width: 30, height: 30)
            
            Image(systemName: icon)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.primary)
        }
        .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
        .frame(width: 64, height: 64)
        .contentShape(Rectangle())
        .animation(.spring().speed(1.5))
    }
}

struct BlurView: UIViewRepresentable {
    @Environment(\.colorScheme) var colorScheme
    var style: UIBlurEffect.Style?
    var colorTint: UIColor?
    
    private var blurStyle: UIBlurEffect.Style {
        if let blur = style {
            return blur
        }
        return colorScheme == .dark ? .dark : .light
    }
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
        
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: blurStyle)
        
        if let colorTint = colorTint {
            uiView.ios14_colorTint = colorTint
        }
    }
}

struct CircleSmallButton_Previews: PreviewProvider {
    static var previews: some View {
        Button { } label: { }
            .buttonStyle(CircleSmallButton(icon: "xmark"))
    }
}


extension UIVisualEffectView {
    var ios14_blurRadius: CGFloat {
        get {
            return gaussianBlur?.requestedValues?["inputRadius"] as? CGFloat ?? 0
        }
        set {
            prepareForChanges()
            gaussianBlur?.requestedValues?["inputRadius"] = newValue
            applyChanges()
        }
    }
    var ios14_colorTint: UIColor? {
        get {
            return sourceOver?.value(forKeyPath: "color") as? UIColor
        }
        set {
            prepareForChanges()
            sourceOver?.setValue(newValue, forKeyPath: "color")
            sourceOver?.perform(Selector(("applyRequestedEffectToView:")), with: overlayView)
            applyChanges()
            overlayView?.backgroundColor = newValue
        }
    }
}

private extension UIVisualEffectView {
    var backdropView: UIView? {
        return subview(of: NSClassFromString("_UIVisualEffectBackdropView"))
    }
    var overlayView: UIView? {
        return subview(of: NSClassFromString("_UIVisualEffectSubview"))
    }
    var gaussianBlur: NSObject? {
        return backdropView?.value(forKey: "filters", withFilterType: "gaussianBlur")
    }
    var sourceOver: NSObject? {
        return overlayView?.value(forKey: "viewEffects", withFilterType: "sourceOver")
    }
    func prepareForChanges() {
        self.effect = UIBlurEffect(style: .light)
        gaussianBlur?.setValue(1.0, forKeyPath: "requestedScaleHint")
    }
    func applyChanges() {
        backdropView?.perform(Selector(("applyRequestedFilterEffects")))
    }
}

private extension NSObject {
    var requestedValues: [String: Any]? {
        get { return value(forKeyPath: "requestedValues") as? [String: Any] }
        set { setValue(newValue, forKeyPath: "requestedValues") }
    }
    func value(forKey key: String, withFilterType filterType: String) -> NSObject? {
        return (value(forKeyPath: key) as? [NSObject])?.first { $0.value(forKeyPath: "filterType") as? String == filterType }
    }
}

private extension UIView {
    func subview(of classType: AnyClass?) -> UIView? {
        return subviews.first { type(of: $0) == classType }
    }
}
