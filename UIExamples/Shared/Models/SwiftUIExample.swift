//import UIKit
import SwiftUI

struct SwiftUIExample {
    let title: String
    let background: UIColor
    let sfSymbol: String
    var view: AnyView

    init(title: String, background: UIColor, sfSymbol: String, view: any View) {
        self.title = title
        self.background = background
        self.sfSymbol = sfSymbol
        self.view = AnyView(view)
    }
}
