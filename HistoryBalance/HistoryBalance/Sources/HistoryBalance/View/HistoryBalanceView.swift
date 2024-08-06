
import Foundation
import SwiftUI

public struct HistoryBalanceView<VM>: View where VM: HistoryBalanceViewModelProtocol {

    // MARK: - Properties

    @ObservedObject var viewModel: VM

    // MARK: - Initialize

    public init( viewModel: VM) {
        self.viewModel = viewModel    
    }

    public var body: some View {
        Text("HistoryBalance View")
    }
}

struct HistoryBalanceView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryBalanceView(viewModel: HistoryBalanceViewModel(configuration: configMock(), bundleMainApp: .main))
    }
}

class configMock: HistoryBalanceConfigurationProtocol {
    var config: [String : AnyObject] = ["Any" : "Any" as AnyObject]
}