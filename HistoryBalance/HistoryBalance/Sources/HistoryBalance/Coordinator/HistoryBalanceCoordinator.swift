
import Foundation
import SwiftUI

public enum HistoryBalancePage: Hashable {
    case root
}

@available(iOS 16, *)
public class HistoryBalanceCoordinator: HistoryBalanceCoordinatorProtocol {

    // MARK: - Properties

    @Published public var path = NavigationPath()
    private let configuration: HistoryBalanceConfigurationProtocol
    private let bundleMainApp: Bundle?

    // MARK: - Initializer

    public required init(path: NavigationPath = NavigationPath(), configuration: HistoryBalanceConfigurationProtocol, bundleMainApp: Bundle? = nil) {
        self.path = path
        self.configuration = configuration
        self.bundleMainApp = bundleMainApp
    }
    
    // MARK: - Functions

    public func push(page: HistoryBalancePage) {
        path.append(page)
    }
    
    public func popToRoot() {
        path.removeLast(path.count)
    }
    
    public func pop() {
        path.removeLast()
    }

    @ViewBuilder public func build(page: HistoryBalancePage) -> some View {
        switch page {
        case .root:
            HistoryBalanceView(
                viewModel: HistoryBalanceViewModel(
                    configuration: configuration,
                    bundleMainApp: bundleMainApp ?? .main
                )
            )
        }
    }
}