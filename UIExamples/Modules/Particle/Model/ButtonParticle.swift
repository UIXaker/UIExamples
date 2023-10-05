import SwiftUI

struct ButtonParticle: Hashable {
    enum ParticleType {
        case up
        case down
    }
    
    enum OpacityType {
        case appearing
        case disappearing
    }
    
    enum ShapeType {
        case circle
        case star
    }
    
    enum RotationType {
        case onAxis
        case offAxis
    }
    
    let type: ParticleType
    let shape: ShapeType
    let rotationType: RotationType
    var rotation: Angle
    var opacityType: OpacityType
    var dalay: CGFloat
    var x: CGFloat
    var y: CGFloat
    var speed: CGFloat
    var easingAngle: Angle
    var realAngle: Angle
    var radius: CGFloat
    var color: Color
    var opacity: Double
    var width: CGFloat
    var height: CGFloat
}
