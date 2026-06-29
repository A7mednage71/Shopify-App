@preconcurrency import MarktekNetworking

extension CartUserErrorDataModel {
    init(userError: CreateCartMutation.Data.CartCreate.UserError) {
        self.init(code: userError.code?.rawValue, field: userError.field, message: userError.message)
    }

    init(userError: AddCartLinesMutation.Data.CartLinesAdd.UserError) {
        self.init(code: userError.code?.rawValue, field: userError.field, message: userError.message)
    }

    init(userError: UpdateCartLinesMutation.Data.CartLinesUpdate.UserError) {
        self.init(code: userError.code?.rawValue, field: userError.field, message: userError.message)
    }

    init(userError: RemoveCartLinesMutation.Data.CartLinesRemove.UserError) {
        self.init(code: userError.code?.rawValue, field: userError.field, message: userError.message)
    }

    init(userError: ApplyDiscountCodeMutation.Data.CartDiscountCodesUpdate.UserError) {
        self.init(code: userError.code?.rawValue, field: userError.field, message: userError.message)
    }

    private init(code: String?, field: [String]?, message: String) {
        self.code = code
        self.field = field ?? []
        self.message = message
    }
}
