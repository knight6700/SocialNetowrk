import SwiftUI
import Combine

struct LoadingThreeBalls: View {
    
    let timer: Publishers.Autoconnect<Timer.TimerPublisher>
    let timing: Double
    
    static let maxCounter = 3
    @State var counter = 0
    
    let frame: CGSize
    let primaryColor: Color
    
    init(color: Color = .horizon(.blackColor), size: CGFloat = 50, speed: Double = 0.5) {
        timing = speed
        timer = Timer.publish(every: timing, on: .main, in: .common).autoconnect()
        frame = CGSize(width: size, height: size)
        primaryColor = color
    }

    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<LoadingThreeBalls.maxCounter, id: \.self) { index in
                Circle()
                    .scale(counter == index ? 1.0 : 0.5)
                    .fill(primaryColor)
            }
        }
        .frame(width: frame.width, height: frame.height, alignment: .center)
        .onReceive(timer, perform: { _ in
            withAnimation(.linear(duration: timing)) {
                counter = counter == (LoadingThreeBalls.maxCounter - 1) ? 0 : counter + 1
            }
        })
    }
}

struct LoadingThreeBalls_Previews: PreviewProvider {
    static var previews: some View {
        LoadingThreeBalls()
    }
}
