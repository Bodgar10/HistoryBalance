
import Foundation
import SwiftUI

public protocol HistoryBalanceViewModelProtocol: ObservableObject {
    
    // MARK: - Initializer
    
    init(configuration: HistoryBalanceConfigurationProtocol, bundleMainApp: Bundle)
}

public protocol HistoryBalanceConfigurationProtocol: AnyObject {
    
    // MARK: - Properties
    
    var config: [String: AnyObject] { get set }
}

public protocol HistoryBalanceCoordinatorProtocol: ObservableObject {

    // MARK: - Properties

    var path: NavigationPath { get set }

    // MARK: - Functions

    init(path: NavigationPath, configuration: HistoryBalanceConfigurationProtocol, bundleMainApp: Bundle?)
    func push(page: HistoryBalancePage)
    func popToRoot()
    func pop()
    
    associatedtype view: View
    func build(page: HistoryBalancePage) -> view
}