import SwiftUI
import Common

struct ShoppingAssistantView: View {
    @StateObject private var vm: ShoppingAssistantViewModel
    @Environment(\.presentationMode) var presentationMode

    init(viewModel: ShoppingAssistantViewModel) {
        _vm = StateObject(wrappedValue: viewModel)
    }

    public var body: some View {
        VStack(spacing: 0) {
            AssistantHeaderView(
                isCatalogLoading: vm.isCatalogLoading,
                hasCatalogError: vm.catalogError != nil,
                onDismiss: { presentationMode.wrappedValue.dismiss() }
            )

            if vm.isCatalogLoading && vm.messages.count <= 1 {
                AssistantCatalogLoadingView()
            } else if let catalogError = vm.catalogError {
                AssistantCatalogErrorView(error: catalogError, onRetry: {
                    Task {
                        await vm.loadCatalog()
                    }
                })
            } else {
                chatArea
            }

            AssistantInputBarView(
                text: $vm.input,
                isLoading: vm.isLoading,
                isCatalogLoading: vm.isCatalogLoading,
                onSend: { vm.send() }
            )
        }
        .environment(\.layoutDirection, .leftToRight)
        .background(AppColors.backgroundSecondary)
        .onAppear {
            Task {
                await vm.loadCatalog()
            }
        }
    }

    // MARK: - Chat Area
    private var chatArea: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(spacing: 14) {
                    ForEach(vm.messages) { message in
                        MessageRow(message: message, products: vm.products(for: message.productIds))
                            .id(message.id)
                    }

                    if vm.isLoading {
                        TypingIndicator()
                            .id("typingIndicator")
                    }

                    if let error = vm.errorMessage {
                        AssistantErrorBubbleView(error: error, onResend: {
                            vm.errorMessage = nil
                            vm.send()
                        })
                        .id("errorBubble")
                    }
                }
                .padding(16)
            }
            .onChange(of: vm.messages.count) { _ in
                scrollToBottom(proxy: proxy)
            }
            .onChange(of: vm.isLoading) { loading in
                if loading {
                    scrollToBottom(proxy: proxy)
                }
            }
        }
        .background(AppColors.backgroundSecondary)
    }

    // MARK: - Helper Navigation / Scroll
    private func scrollToBottom(proxy: ScrollViewProxy) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation {
                if let last = vm.messages.last {
                    proxy.scrollTo(last.id, anchor: .bottom)
                } else if vm.isLoading {
                    proxy.scrollTo("typingIndicator", anchor: .bottom)
                } else if vm.errorMessage != nil {
                    proxy.scrollTo("errorBubble", anchor: .bottom)
                }
            }
        }
    }
}
