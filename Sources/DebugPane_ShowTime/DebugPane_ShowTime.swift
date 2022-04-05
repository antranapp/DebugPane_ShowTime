//
// Copyright © 2021 An Tran. All rights reserved.
//

import Foundation
import ShowTime
import SwiftUI
import TweakPane
import Combine

public struct ShowTimeBlade: Blade {
    public var name: String? = "ShowTime"
    
    public init() {}
    
    public func render() -> AnyView {
        AnyView(ContentView())
    }
}

private struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        InputBlade(name: "Toggle ShowTime", binding: InputBinding($viewModel.enableShowTime)).render()
    }
}

extension ContentView {
    final class ViewModel: ObservableObject {
        @Published var enableShowTime: Bool = false
        
        private var cancellable: AnyCancellable?
        
        init() {
            cancellable = $enableShowTime.sink { value in
                ShowTime.enabled = value ? .always : .never
            }
        }
    }
}
