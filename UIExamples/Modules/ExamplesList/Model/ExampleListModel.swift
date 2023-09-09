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
                title: "Notification Access v3",
                background: UIColor(hex: 0x840D33),
                sfSymbol: "app.badge.fill",
                view: NotificationSetupView3()
            ),
            SwiftUIExample(
                title: "Notification Access v2",
                background: UIColor(hex: 0x840D98),
                sfSymbol: "app.badge.fill",
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
                title: "Nice Button",
                background: UIColor(hex: 0x0a84ff),
                sfSymbol: "cursorarrow",
                view: NiceButtonExample()
            )
        ])
    }
    
}
