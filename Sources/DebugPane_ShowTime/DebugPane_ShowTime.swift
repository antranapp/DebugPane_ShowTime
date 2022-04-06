//
// Copyright © 2021 An Tran. All rights reserved.
//

import Foundation
import ShowTime
import SwiftUI
import TweakPane
import Combine

public struct ShowTimeBlade: Blade {
    fileprivate static let settingKey = "app.antran.debugpane.showtime"
    public var name: String? = "ShowTime"
    
    public init() {
        ShowTime.enabled = UserDefaults.standard.bool(forKey: ShowTimeBlade.settingKey) ? .always : .never
    }
    
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
            enableShowTime = ShowTime.enabled == .always
            
            cancellable = $enableShowTime.dropFirst().sink { value in
                ShowTime.enabled = value ? .always : .never
                UserDefaults.standard.set(value, forKey: ShowTimeBlade.settingKey)
            }
        }
    }
}

extension ShowTimeBlade {
    public static func setup() {
        ShowTime.enabled = UserDefaults.standard.bool(forKey: ShowTimeBlade.settingKey) ? .always : .never
    }
}
