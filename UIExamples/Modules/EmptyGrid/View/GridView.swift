import SwiftUI

struct GridView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var glowingCells: Set<GridPosition> = []
    @State private var currentCellPosition: GridPosition?
    
    private let cellSize: CGFloat = 96
    private let gridSize: Int = 10
    private let setColors: Set<Color> = [.yellow, .blue, .pink, .brown, .red, .green, .orange, .cyan, .mint, .indigo]
    var glowingColorOpacityRange: ClosedRange<Double> {
        return colorScheme == .dark ? 0.7...1 : 0.15...0.4
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ForEach(0..<gridSize) { row in
                    HStack(spacing: 0) {
                        ForEach(0..<gridSize) { column in
                            let position = GridPosition(row: row, column: column)
                            GridCell(isGlowing: glowingCells.contains(position), cellSize: cellSize, glowingColorOpacityRange: glowingColorOpacityRange, colors: setColors)
                        }
                    }
                }
            }
            .rotationEffect(.degrees(45), anchor: .center)
            .onAppear(perform: startGlowAnimation)
            .onChange(of: currentCellPosition) { newValue in
                if let position = newValue {
                    let randomPositions = generateRandomGridPositions(maxCount: 7, excluding: position)
                    glowingCells = Set(randomPositions)
                }
            }
            let borderWidth = CGFloat(110.0)
            let offset = CGFloat(20.0)
            let width = UIScreen.main.bounds.width - offset
            let height = UIScreen.main.bounds.height - offset
            let rect = CGRect(x: width / 2.0 + 50.0 + offset,
                              y: 1.3 + (offset / 2.0),
                              width: width,
                              height: height)
            
            Path(roundedRect: rect, cornerRadius: 80.0)
                .stroke(.background, style: .init(lineWidth: borderWidth))
                .blur(radius: 70.0)
            
        }
        
        
    }
    
    func startGlowAnimation() {
        currentCellPosition = generateRandomGridPosition(excluding: currentCellPosition)
        
        var randomPositions = generateRandomGridPositions(maxCount: 7, excluding: currentCellPosition)
        
        let animation = Animation.easeInOut(duration: 2).repeatForever()
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            withAnimation(animation) {
                randomPositions.removeAll(where: { glowingCells.contains($0) })
                glowingCells = Set(randomPositions)
            }
            
            if randomPositions.isEmpty {
                timer.invalidate()
                startGlowAnimation()
            }
        }
    }
    
    
    func generateRandomGridPositions(maxCount: Int, excluding position: GridPosition?) -> [GridPosition] {
        var positions: [GridPosition] = []
        
        while positions.count < maxCount {
            let randomPosition = generateRandomGridPosition(excluding: position)
            
            if !positions.contains(randomPosition) && !isNeighborPosition(randomPosition, of: position) {
                positions.append(randomPosition)
            }
        }
        
        return positions
    }
    
    func generateRandomGridPosition(excluding position: GridPosition?) -> GridPosition {
        let maxRow = gridSize - 1
        let maxColumn = gridSize - 1
        
        var randomPosition: GridPosition
        
        repeat {
            let row = Int.random(in: 0...maxRow)
            let column = Int.random(in: 0...maxColumn)
            randomPosition = GridPosition(row: row, column: column)
        } while randomPosition == position
        
        return randomPosition
    }
    
    func isNeighborPosition(_ position: GridPosition, of centerPosition: GridPosition?) -> Bool {
        guard let center = centerPosition else {
            return false
        }
        
        let rowDifference = abs(position.row - center.row)
        let columnDifference = abs(position.column - center.column)
        
        return (rowDifference == 0 && columnDifference == 1) || (rowDifference == 1 && columnDifference == 0)
    }
}

struct GridCell: View {
    let isGlowing: Bool
    let cellSize: CGFloat
    let glowingColorOpacityRange: ClosedRange<Double>
    let colors: Set<Color>
    
    var body: some View {
        RoundedRectangle(cornerRadius: 0)
            .stroke(Color.primary.opacity(0.13), lineWidth: 1)
            .frame(width: cellSize, height: cellSize)
            .background(
                RoundedRectangle(cornerRadius: 0)
                    .fill(isGlowing ? colors.randomElement()!.opacity(randomGlowingColorOpacity()) : Color.clear)
                    .opacity(isGlowing ? 0 : 1)
                    .animation(Animation.linear(duration: 2).delay(isGlowing ? 0.3 : 0), value: isGlowing)
            )
    }
    
    func randomGlowingColorOpacity() -> Double {
        Double.random(in: glowingColorOpacityRange)
    }
}

struct GridPosition: Hashable {
    let row: Int
    let column: Int
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView()
    }
}
