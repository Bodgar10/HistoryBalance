//
//  HistoryCoordinator.swift
//
//
//  Created by Bodgar Espinosa Miranda on 09/10/24.
//

import Foundation
import SwiftUI

public class HistoryCoordinator {
    
    public init() {}
    
    @ViewBuilder public func start() -> some View {
        HistoryBalanceView(viewModel: HistoryBalanceViewModel())
    }
    
}
