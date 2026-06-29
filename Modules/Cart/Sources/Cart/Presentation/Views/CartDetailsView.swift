import SwiftUI

struct CartDetailsView: View {
    @StateObject private var viewModel: CartViewModel

    init(viewModel: CartViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        EmptyView()
    }
}
