
import Combine
import Foundation
import SwiftUI

public class HistoryBalanceViewModel: HistoryBalanceViewModelProtocol {

    // MARK: - Properties

    private let configuration: HistoryBalanceConfigurationProtocol
    private let bundleMainApp: Bundle

    // MARK: - Initializer

    public required init(configuration: HistoryBalanceConfigurationProtocol, bundleMainApp: Bundle) {
        self.configuration = configuration
        self.bundleMainApp = bundleMainApp
    }
}