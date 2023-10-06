import Foundation

class ProgressConverter {
    let minValue: Double
    let maxValue: Double
    
    init(minValue: Double, maxValue: Double) {
        self.minValue = minValue
        self.maxValue = maxValue
    }
    
    func convertWithEaseOut(_ value: Double) -> Double {
        let progress = progress(forValue: value)
        let converted = easeOutQuad(progress)
        let value = self.value(forProgress: converted)
        
        return value
    }
    
    private func progress(forValue value: Double) -> Double {
        (value - minValue) / (maxValue - minValue)
    }
    
    private func value(forProgress progress: Double) -> Double {
        minValue + (progress * (maxValue - minValue))
    }
    
    private func easeOutQuad(_ x: Double) -> Double {
        1 - pow(1 - x, 4)
    }
}
