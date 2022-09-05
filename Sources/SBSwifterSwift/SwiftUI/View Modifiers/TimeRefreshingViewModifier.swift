#if canImport(Combine) && canImport(SwiftUI)
import Combine
import SwiftUI

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
fileprivate struct TimeRefreshingViewModifier: ViewModifier {
    
    @Binding private var currentDate: Date
    
    @Environment(\.scenePhase) private var scenePhase
    
    @State private var counter = 0
    
    private let maximumUpdateCount: Int?
    
    private let timer: Publishers.Autoconnect<Timer.TimerPublisher>
    
    private let refreshWhileActive: Bool
    
    init(
        every interval: TimeInterval,
        tolerance: TimeInterval?,
        whileActive: Bool,
        cancelAfter updateCount: Int?,
        currentDate: Binding<Date>
    ) {
        _currentDate = currentDate
        maximumUpdateCount = updateCount
        timer = Timer.publish(every: interval, tolerance: tolerance, on: .main, in: .common).autoconnect()
        refreshWhileActive = whileActive
    }
    
    func body(content: Content) -> some View {
        // must include the currentDate in the view description to get updates
        content
            .opacity(currentDate == .now ? 1 : 1)
            .onReceive(timer) { input in
                if counter == maximumUpdateCount {
                    timer.upstream.connect().cancel()
                } else if !refreshWhileActive || (refreshWhileActive && scenePhase == .active) {
                    currentDate = input
                    counter += 1
                }
            }
    }
}

extension View {
    
    /// Refreshes the current date binding on the interval you prescribe.
    /// - Author: Scott Brenner | SBSwifterSwift
    /// - Parameters:
    ///   - interval: The time interval on which to update the current date binding. For example, a value of 0.5 results in an update approximately every half-second.
    ///   - tolerance: The allowed timing variance when emitting events. Defaults to `nil`, which allows any variance.
    ///   - whileActive: A boolean indicating whether to update the date binding only when the scene phase is active. Defaults to `true`.
    ///   - updateCount: The maximum number of times the current date binding will be updated.
    ///   - currentDate: The date binding that will be updated.
    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
    public func timeRefreshing(
        every interval: TimeInterval,
        tolerance: TimeInterval? = nil,
        whileActive: Bool = true,
        cancelAfter updateCount: Int? = nil,
        currentDate: Binding<Date>
    ) -> some View {
        modifier(
            TimeRefreshingViewModifier(
                every: interval,
                tolerance: tolerance,
                whileActive: whileActive,
                cancelAfter: updateCount,
                currentDate: currentDate
            )
        )
    }
}
#endif
