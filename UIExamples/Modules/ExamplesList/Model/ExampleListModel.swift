import Foundation
import SwiftUI

struct ExampleListModel {
    
    private var _swiftUIExamples: [SwiftUIExample]
    var swiftUIExamples: [SwiftUIExample] { return _swiftUIExamples }

    // MARK: Initialization

    init(swiftUIExamples: [SwiftUIExample]) {
        _swiftUIExamples = swiftUIExamples
    }
    
    static var initial: ExampleListModel {
        return ExampleListModel(swiftUIExamples: [
            SwiftUIExample(
                title: "Particle Button",
                background: UIColor(hex: 0xED9B3F),
                sfSymbol: "wand.and.stars",
                view: ParticleView()
            ),
            SwiftUIExample(
                title: "Loading View",
                background: UIColor(hex: 0xFA15FF),
                sfSymbol: "moon.stars",
                view: LoadingView()
            ),
            SwiftUIExample(
                title: "Empty Grid View",
                background: UIColor(hex: 0x3BFF1B),
                sfSymbol: "grid",
                view: EmptyGridView()
            ),
            SwiftUIExample(
                title: "Notification Access v3",
                background: UIColor(hex: 0xFF961B),
                sfSymbol: "rectangle.stack",
                view: NotificationSetupView3()
            ),
            SwiftUIExample(
                title: "Notification Access v2",
                background: UIColor(hex: 0x840D98),
                sfSymbol: "rectangle.grid.1x2",
                view: NotificationSetupView2()
            ),
            SwiftUIExample(
                title: "Notification Access",
                background: UIColor(hex: 0xFF1B1B),
                sfSymbol: "app.badge",
                view: NotificationSetupView()
            ),
            SwiftUIExample(
                title: "Gallery Access",
                background: UIColor(hex: 0x1B24FF),
                sfSymbol: "lock.rectangle.on.rectangle.fill",
                view: GalleryAccessView()
            ),
            SwiftUIExample(
                title: "Nice Button Style",
                background: UIColor(hex: 0x0a84ff),
                sfSymbol: "cursorarrow",
                view: NiceButtonExample()
            )
        ])
    }
    
}
