import SwiftUI

struct CustomShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 1.9148, y: 3.29345))
        path.addCurve(to: CGPoint(x: 2.35976, y: 3.10447), control1: CGPoint(x: 2.00836, y: 3.24822), control2: CGPoint(x: 2.14821, y: 3.19101))
        path.addLine(to: CGPoint(x: 2.48463, y: 3.05086))
        path.addCurve(to: CGPoint(x: 2.90854, y: 2.62695), control1: CGPoint(x: 2.66863, y: 2.95992), control2: CGPoint(x: 2.8176, y: 2.81095))
        path.addLine(to: CGPoint(x: 3.16464, y: 2.00709))
        path.addLine(to: CGPoint(x: 3.63544, y: 0.856262))
        path.addLine(to: CGPoint(x: 4.3277, y: 0.856262))
        path.addLine(to: CGPoint(x: 4.79849, y: 2.00709))
        path.addCurve(to: CGPoint(x: 5.00099, y: 2.50208), control1: CGPoint(x: 4.86211, y: 2.16259), control2: CGPoint(x: 4.91809, y: 2.29944))
        path.addCurve(to: CGPoint(x: 5.4785, y: 3.05086), control1: CGPoint(x: 5.14554, y: 2.81095), control2: CGPoint(x: 5.2945, y: 2.95992))
        path.addCurve(to: CGPoint(x: 5.60337, y: 3.10446), control1: CGPoint(x: 5.50815, y: 3.06551), control2: CGPoint(x: 5.53989, y: 3.07849))
        path.addCurve(to: CGPoint(x: 6.04833, y: 3.29345), control1: CGPoint(x: 5.81492, y: 3.19101), control2: CGPoint(x: 5.95477, y: 3.24822))
        path.addLine(to: CGPoint(x: 6.11469, y: 3.31364))
        path.addLine(to: CGPoint(x: 7.24919, y: 3.77775))
        path.addLine(to: CGPoint(x: 6.13122, y: 4.92737))
        path.addCurve(to: CGPoint(x: 5.60337, y: 5.14331), control1: CGPoint(x: 5.96685, y: 4.99461), control2: CGPoint(x: 5.82416, y: 5.05298))
        path.addCurve(to: CGPoint(x: 5.05459, y: 5.62082), control1: CGPoint(x: 5.2945, y: 5.28786), control2: CGPoint(x: 5.14554, y: 5.43682))
        path.addCurve(to: CGPoint(x: 4.81779, y: 6.17858), control1: CGPoint(x: 5.03994, y: 5.65046), control2: CGPoint(x: 4.91809, y: 5.94832))
        path.addLine(to: CGPoint(x: 4.79849, y: 6.24068))
        path.addLine(to: CGPoint(x: 4.3277, y: 7.39151))
        path.addLine(to: CGPoint(x: 3.63544, y: 7.39151))
        path.addLine(to: CGPoint(x: 3.16464, y: 6.24068))
        path.addCurve(to: CGPoint(x: 2.96215, y: 5.74569), control1: CGPoint(x: 3.10103, y: 6.08518), control2: CGPoint(x: 3.04504, y: 5.94833))
        path.addCurve(to: CGPoint(x: 2.48463, y: 5.19691), control1: CGPoint(x: 2.8176, y: 5.43682), control2: CGPoint(x: 2.66863, y: 5.28786))
        path.addCurve(to: CGPoint(x: 2.35977, y: 5.14331), control1: CGPoint(x: 2.45499, y: 5.18226), control2: CGPoint(x: 2.42325, y: 5.16928))
        path.addCurve(to: CGPoint(x: 1.9148, y: 3.29345), control1: CGPoint(x: 2.13898, y: 5.05299), control2: CGPoint(x: 1.99628, y: 4.99461))
        path.addLine(to: CGPoint(x: 1.84844, y: 3.31364))
        path.addLine(to: CGPoint(x: 0.713943, y: 3.77775))
        path.addLine(to: CGPoint(x: 1.83191, y: 4.92737))
        path.closeSubpath()
        
        return path
    }
}
