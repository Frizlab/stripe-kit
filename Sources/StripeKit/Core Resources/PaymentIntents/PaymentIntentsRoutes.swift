//
//  PaymentIntentsRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 4/28/19.
//

import NIO
import NIOHTTP1

public protocol PaymentIntentsRoutes {
    /// Creates a PaymentIntent object.
    ///
    /// - Parameters:
    ///   - amount: A positive integer representing how much to charge in the smallest currency unit (e.g., 100 cents to charge $1.00 or 100 to charge ¥100, a zero-decimal currency). The minimum amount is $0.50 US or equivalent in charge currency.
    ///   - currency: Three-letter ISO currency code, in lowercase. Must be a supported currency.
    ///   - applicationFeeAmount: The amount of the application fee (if any) that will be applied to the payment and transferred to the application owner’s Stripe account. For more information, see the PaymentIntents Connect usage guide.
    ///   - captureMethod: Capture method of this PaymentIntent, one of `automatic` or `manual`.
    ///   - confirm: Set to `true` to attempt to confirm this PaymentIntent immediately. This parameter defaults to `false`. If the payment method attached is a card, a return_url may be provided in case additional authentication is required.
    ///   - confirmationMethod: One of `automatic` (default) or `manual`. /n When the confirmation method is `automatic`, a PaymentIntent can be confirmed using a publishable key. After `next_actions` are handled, no additional confirmation is required to complete the payment. /n When the confirmation method is` manual`, all payment attempts must be made using a secret key. The PaymentIntent will return to the `requires_confirmation` state after handling `next_actions`, and requires your server to initiate each payment attempt with an explicit confirmation. Read the expanded documentation to learn more about manual confirmation.
    ///   - customer: ID of the customer this PaymentIntent is for if one exists.
    ///   - description: An arbitrary string attached to the object. Often useful for displaying to users. This will be unset if you POST an empty value.
    ///   - mandate: ID of the mandate to be used for this payment. This parameter can only be used with confirm=true.
    ///   - mandateData: This hash contains details about the Mandate to create. This parameter can only be used with confirm=true.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    ///   - offSession: Set to true to indicate that the customer is not in your checkout flow during this payment attempt, and therefore is unable to authenticate. This parameter is intended for scenarios where you collect card details and charge them later. This parameter can only be used with confirm=true.
    ///   - onBehalfOf: The Stripe account ID for which these funds are intended. For details, see the PaymentIntents Connect usage guide.
    ///   - paymentMethod: ID of the payment method to attach to this PaymentIntent.
    ///   - paymentMethodOptions: Payment-method-specific configuration for this PaymentIntent.
    ///   - paymentMethodTypes: The list of payment method types that this PaymentIntent is allowed to use. If this is not provided, defaults to `[“card”]`. Valid payment method types include: `card` and `card_present`.
    ///   - receiptEmail: Email address that the receipt for the resulting payment will be sent to.
    ///   - returnUrl: The URL to redirect your customer back to after they authenticate or cancel their payment on the payment method’s app or site. If you’d prefer to redirect to a mobile application, you can alternatively supply an application URI scheme. This parameter can only be used with confirm=true.
    ///   - savePaymentMethod: Set to `true` to save the PaymentIntent’s payment method (either `source` or `payment_method`) to the associated customer. If the payment method is already attached, this parameter does nothing. This parameter defaults to `false` and applies to the payment method passed in the same request or the current payment method attached to the PaymentIntent and must be specified again if a new payment method is added.
    ///   - setupFutureUsage: Indicates that you intend to make future payments with this PaymentIntent’s payment method. If present, the payment method used with this PaymentIntent can be attached to a Customer, even after the transaction completes. Use on_session if you intend to only reuse the payment method when your customer is present in your checkout flow. Use off_session if your customer may or may not be in your checkout flow. For more, learn to save card details after a payment. Stripe uses setup_future_usage to dynamically optimize your payment flow and comply with regional legislation and network rules. For example, if your customer is impacted by SCA, using off_session will ensure that they are authenticated while processing this PaymentIntent. You will then be able to collect off-session payments for this customer.
    ///   - shipping: Shipping information for this PaymentIntent.
    ///   - statementDescriptor: For non-card charges, you can use this value as the complete description that appears on your customers’ statements. Must contain at least one letter, maximum 22 characters.
    ///   - statementDescriptorSuffix: Provides information about a card payment that customers see on their statements. Concatenated with the prefix (shortened descriptor) or statement descriptor that’s set on the account to form the complete statement descriptor. Maximum 22 characters for the concatenated descriptor.
    ///   - transferData: The parameters used to automatically create a Transfer when the payment succeeds. For more information, see the PaymentIntents Connect usage guide.
    ///   - transferGroup: A string that identifies the resulting payment as part of a group. See the PaymentIntents Connect usage guide for details.
    ///   - useStripeSDK: Set to true only when using manual confirmation and the iOS or Android SDKs to handle additional authentication steps.
    /// - Returns: A `StripePaymentIntent`.
    func create(amount: Int,
                currency: StripeCurrency,
                applicationFeeAmount: Int?,
                captureMethod: StripePaymentIntentCaptureMethod?,
                confirm: Bool?,
                confirmationMethod: StripePaymentIntentConfirmationMethod?,
                customer: String?,
                description: String?,
                mandate: String?,
                mandateData: [String: Any]?,
                metadata: [String: String]?,
                offSession: Bool?,
                onBehalfOf: String?,
                paymentMethod: String?,
                paymentMethodOptions: [String: Any]?,
                paymentMethodTypes: [String]?,
                receiptEmail: String?,
                returnUrl: String?,
                savePaymentMethod: Bool?,
                setupFutureUsage: String?,
                shipping: [String: Any]?,
                statementDescriptor: String?,
                statementDescriptorSuffix: String?,
                transferData: [String: Any]?,
                transferGroup: String?,
                useStripeSDK: Bool?) -> EventLoopFuture<StripePaymentIntent>
    
    /// Retrieves the details of a PaymentIntent that has previously been created.
    ///
    /// - Parameter id: The identifier of the paymentintent to be retrieved.
    /// - Returns: A `StripePaymentIntent`.
    func retrieve(intent: String, clientSecret: String?) -> EventLoopFuture<StripePaymentIntent>
    
    /// Updates a PaymentIntent object.
    ///
    /// - Parameters:
    ///   - intent: The identifier of the paymentintent to be updated.
    ///   - amount: A positive integer representing how much to charge in the smallest currency unit (e.g., 100 cents to charge $1.00 or 100 to charge ¥100, a zero-decimal currency). The minimum amount is $0.50 US or equivalent in charge currency.
    ///   - applicationFeeAmount: The amount of the application fee (if any) that will be applied to the payment and transferred to the application owner’s Stripe account. For more information, see the PaymentIntents Connect usage guide.
    ///   - currency: Three-letter ISO currency code, in lowercase. Must be a supported currency.
    ///   - customer: ID of the customer this PaymentIntent is for if one exists.
    ///   - description: An arbitrary string attached to the object. Often useful for displaying to users. This will be unset if you POST an empty value.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    ///   - paymentMethod: ID of the payment method to attach to this PaymentIntent.
    ///   - paymentMethodTypes: The list of payment method types that this PaymentIntent is allowed to use. If this is not provided, defaults to `[“card”]`. Valid payment method types include: `card` and `card_present`.
    ///   - receiptEmail: Email address that the receipt for the resulting payment will be sent to.
    ///   - savePaymentMethod: Set to `true` to save the PaymentIntent’s payment method (either `source` or `payment_method`) to the associated customer. If the payment method is already attached, this parameter does nothing. This parameter defaults to `false` and applies to the payment method passed in the same request or the current payment method attached to the PaymentIntent and must be specified again if a new payment method is added.
    ///   - setupFutureUsage: Indicates that you intend to make future payments with this PaymentIntent’s payment method. If present, the payment method used with this PaymentIntent can be attached to a Customer, even after the transaction completes. Use on_session if you intend to only reuse the payment method when your customer is present in your checkout flow. Use off_session if your customer may or may not be in your checkout flow. Stripe uses setup_future_usage to dynamically optimize your payment flow and comply with regional legislation and network rules. For example, if your customer is impacted by SCA, using off_session will ensure that they are authenticated while processing this PaymentIntent. You will then be able to collect off-session payments for this customer. If setup_future_usage is already set and you are performing a request using a publishable key, you may only update the value from on_session to off_session.
    ///   - shipping: Shipping information for this PaymentIntent.
    ///   - source: ID of the Source object to attach to this PaymentIntent.
    ///   - statementDescriptor: For non-card charges, you can use this value as the complete description that appears on your customers’ statements. Must contain at least one letter, maximum 22 characters.
    ///   - statementDescriptorSuffix: Provides information about a card payment that customers see on their statements. Concatenated with the prefix (shortened descriptor) or statement descriptor that’s set on the account to form the complete statement descriptor. Maximum 22 characters for the concatenated descriptor.
    ///   - transferData: The parameters used to automatically create a Transfer when the payment succeeds. For more information, see the PaymentIntents Connect usage guide.
    ///   - transferGroup: A string that identifies the resulting payment as part of a group. See the PaymentIntents Connect usage guide for details.
    /// - Returns: A `StripePaymentIntent`.
    func update(intent: String,
                amount: Int?,
                applicationFeeAmount: Int?,
                currency: StripeCurrency?,
                customer: String?,
                description: String?,
                metadata: [String: String]?,
                paymentMethod: String?,
                paymentMethodTypes: [String]?,
                receiptEmail: String?,
                savePaymentMethod: Bool?,
                setupFutureUsage: String?,
                shipping: [String: Any]?,
                statementDescriptor: String?,
                statementDescriptorSuffix: String?,
                transferData: [String: Any]?,
                transferGroup: String?) -> EventLoopFuture<StripePaymentIntent>
    
    /// Confirm that your customer intends to pay with current or provided payment method. Upon confirmation, the PaymentIntent will attempt to initiate a payment. /n If the selected payment method requires additional authentication steps, the PaymentIntent will transition to the `requires_action` status and suggest additional actions via `next_action`. If payment fails, the PaymentIntent will transition to the `requires_payment_method` status. If payment succeeds, the PaymentIntent will transition to the `succeeded` status (or `requires_capture`, if `capture_method` is set to `manual`). /n If the `confirmation_method` is `automatic`, payment may be attempted using our client SDKs and the PaymentIntent’s `client_secret`. After `next_action`s are handled by the client, no additional confirmation is required to complete the payment. /n If the `confirmation_method` is `manual`, all payment attempts must be initiated using a secret key. If any actions are required for the payment, the PaymentIntent will return to the `requires_confirmation` state after those actions are completed. Your server needs to then explicitly re-confirm the PaymentIntent to initiate the next payment attempt. Read the expanded documentation to learn more about manual confirmation.
    ///
    /// - Parameters:
    ///   - intent: The identifier of the paymentintent to be confirmed.
    ///   - mandate: ID of the mandate to be used for this payment.
    ///   - mandateData: This hash contains details about the Mandate to create.
    ///   - offSession: Set to true to indicate that the customer is not in your checkout flow during this payment attempt, and therefore is unable to authenticate. This parameter is intended for scenarios where you collect card details and charge them later.
    ///   - paymentMethod: ID of the payment method to attach to this PaymentIntent.
    ///   - paymentMethodOptions: Payment-method-specific configuration for this PaymentIntent.
    ///   - paymentMethodTypes: The list of payment method types (e.g. card) that this PaymentIntent is allowed to use.
    ///   - receiptEmail: Email address that the receipt for the resulting payment will be sent to.
    ///   - returnUrl: The URL to redirect your customer back to after they authenticate or cancel their payment on the payment method’s app or site. If you’d prefer to redirect to a mobile application, you can alternatively supply an application URI scheme. This parameter is only used for cards and other redirect-based payment methods.
    ///   - savePaymentMethod: Set to `true` to save the PaymentIntent’s payment method (either `source` or `payment_method`) to the associated customer. If the payment method is already attached, this parameter does nothing. This parameter defaults to `false` and applies to the payment method passed in the same request or the current payment method attached to the PaymentIntent and must be specified again if a new payment method is added.
    ///   - setupFutureUsage: Indicates that you intend to make future payments with this PaymentIntent’s payment method. If present, the payment method used with this PaymentIntent can be attached to a Customer, even after the transaction completes. Use on_session if you intend to only reuse the payment method when your customer is present in your checkout flow. Use off_session if your customer may or may not be in your checkout flow. Stripe uses setup_future_usage to dynamically optimize your payment flow and comply with regional legislation and network rules. For example, if your customer is impacted by SCA, using off_session will ensure that they are authenticated while processing this PaymentIntent. You will then be able to collect off-session payments for this customer. If setup_future_usage is already set and you are performing a request using a publishable key, you may only update the value from on_session to off_session.
    ///   - shipping: Shipping information for this PaymentIntent.
    ///   - useStripeSDK: Set to true only when using manual confirmation and the iOS or Android SDKs to handle additional authentication steps.
    /// - Returns: A `StripePaymentIntent`.
    func confirm(intent: String,
                 mandate: String?,
                 mandateData: [String: Any]?,
                 offSession: Bool?,
                 paymentMethod: String?,
                 paymentMethodOptions: [String: Any]?,
                 paymentMethodTypes: [String]?,
                 receiptEmail: String?,
                 returnUrl: String?,
                 savePaymentMethod: Bool?,
                 setupFutureUsage: String?,
                 shipping: [String: Any]?,
                 useStripeSDK: Bool?) -> EventLoopFuture<StripePaymentIntent>
    
    /// Capture the funds of an existing uncaptured PaymentIntent when its status is `requires_capture`. /n Uncaptured PaymentIntents will be canceled exactly seven days after they are created. /n Read the expanded documentation to learn more about separate authorization and capture.
    ///
    /// - Parameters:
    ///   - intent: ID of the paymentintent to capture.
    ///   - amountToCapture: The amount to capture from the PaymentIntent, which must be less than or equal to the original amount. Any additional amount will be automatically refunded. Defaults to the full `amount_capturable` if not provided.
    ///   - applicationfeeAmount: The amount of the application fee (if any) that will be applied to the payment and transferred to the application owner’s Stripe account. For more information, see the PaymentIntents Connect usage guide.
    ///   - statementDescriptor: For non-card charges, you can use this value as the complete description that appears on your customers’ statements. Must contain at least one letter, maximum 22 characters.
    ///   - statementDescriptorSuffix: Provides information about a card payment that customers see on their statements. Concatenated with the prefix (shortened descriptor) or statement descriptor that’s set on the account to form the complete statement descriptor. Maximum 22 characters for the concatenated descriptor.
    ///   - transferData: The parameters used to automatically create a Transfer when the payment is captured. For more information, see the PaymentIntents use case for connected accounts.
    /// - Returns: A `StripePaymentIntent`.
    func capture(intent: String,
                 amountToCapture: Int?,
                 applicationFeeAmount: Int?,
                 statementDescriptor: String?,
                 statementDescriptorSuffix: String?,
                 transferData: [String: Any]?) -> EventLoopFuture<StripePaymentIntent>
    
    ///  PaymentIntent object can be canceled when it is in one of these statuses: `requires_payment_method`, `requires_capture`, `requires_confirmation`, `requires_action`. /n Once canceled, no additional charges will be made by the PaymentIntent and any operations on the PaymentIntent will fail with an error. For PaymentIntents with `status='requires_capture'`, the remaining `amount_capturable` will automatically be refunded.
    ///
    /// - Parameters:
    ///   - id: ID of the paymentintent to cancel.
    ///   - cancellationReason:  Reason for canceling this PaymentIntent. If set, possible values are `duplicate`, `fraudulent`, `requested_by_customer`, or `failed_invoice`
    /// - Returns: A `StripePaymentIntent`.
    func cancel(intent: String, cancellationReason: StripePaymentIntentCancellationReason?) -> EventLoopFuture<StripePaymentIntent>
    
    /// Returns a list of PaymentIntents.
    ///
    /// - Parameter filter: A dictionary that contains the filters. More info [here](https://stripe.com/docs/api/payment_intents/list).
    /// - Returns: A `StripePaymentIntentsList`.
    func listAll(filter: [String: Any]?) -> EventLoopFuture<StripePaymentIntentsList>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension PaymentIntentsRoutes {
    public func create(amount: Int,
                       currency: StripeCurrency,
                       applicationFeeAmount: Int? = nil,
                       captureMethod: StripePaymentIntentCaptureMethod? = nil,
                       confirm: Bool? = nil,
                       confirmationMethod: StripePaymentIntentConfirmationMethod? = nil,
                       customer: String? = nil,
                       description: String? = nil,
                       mandate: String? = nil,
                       mandateData: [String: Any]? = nil,
                       metadata: [String: String]? = nil,
                       offSession: Bool? = nil,
                       onBehalfOf: String? = nil,
                       paymentMethod: String? = nil,
                       paymentMethodOptions: [String: Any]? = nil,
                       paymentMethodTypes: [String]? = nil,
                       receiptEmail: String? = nil,
                       returnUrl: String? = nil,
                       savePaymentMethod: Bool? = nil,
                       setupFutureUsage: String? = nil,
                       shipping: [String: Any]? = nil,
                       statementDescriptor: String? = nil,
                       statementDescriptorSuffix: String? = nil,
                       transferData: [String: Any]? = nil,
                       transferGroup: String? = nil,
                       useStripeSDK: Bool? = nil) -> EventLoopFuture<StripePaymentIntent> {
        return create(amount: amount,
                      currency: currency,
                      applicationFeeAmount: applicationFeeAmount,
                      captureMethod: captureMethod,
                      confirm: confirm,
                      confirmationMethod: confirmationMethod,
                      customer: customer,
                      description: description,
                      mandate: mandate,
                      mandateData: mandateData,
                      metadata: metadata,
                      offSession: offSession,
                      onBehalfOf: onBehalfOf,
                      paymentMethod: paymentMethod,
                      paymentMethodOptions: paymentMethodOptions,
                      paymentMethodTypes: paymentMethodTypes,
                      receiptEmail: receiptEmail,
                      returnUrl: returnUrl,
                      savePaymentMethod: savePaymentMethod,
                      setupFutureUsage: setupFutureUsage,
                      shipping: shipping,
                      statementDescriptor: statementDescriptor,
                      statementDescriptorSuffix: statementDescriptorSuffix,
                      transferData: transferData,
                      transferGroup: transferGroup,
                      useStripeSDK: useStripeSDK)
    }
    
    public func retrieve(intent: String, clientSecret: String?) -> EventLoopFuture<StripePaymentIntent> {
        return retrieve(intent: intent, clientSecret: clientSecret)
    }
    
    public func update(intent: String,
                       amount: Int? = nil,
                       applicationFeeAmount: Int? = nil,
                       currency: StripeCurrency? = nil,
                       customer: String? = nil,
                       description: String? = nil,
                       metadata: [String: String]? = nil,
                       paymentMethod: String? = nil,
                       paymentMethodTypes: [String]? = nil,
                       receiptEmail: String? = nil,
                       savePaymentMethod: Bool? = nil,
                       setupFutureUsage: String? = nil,
                       shipping: [String: Any]? = nil,
                       statementDescriptor: String? = nil,
                       statementDescriptorSuffix: String? = nil,
                       transferData: [String: Any]? = nil,
                       transferGroup: String? = nil) -> EventLoopFuture<StripePaymentIntent> {
        return update(intent: intent,
                      amount: amount,
                      applicationFeeAmount: applicationFeeAmount,
                      currency: currency,
                      customer: customer,
                      description: description,
                      metadata: metadata,
                      paymentMethod: paymentMethod,
                      paymentMethodTypes: paymentMethodTypes,
                      receiptEmail: receiptEmail,
                      savePaymentMethod: savePaymentMethod,
                      setupFutureUsage: setupFutureUsage,
                      shipping: shipping,
                      statementDescriptor: statementDescriptor,
                      statementDescriptorSuffix: statementDescriptorSuffix,
                      transferData: transferData,
                      transferGroup: transferGroup)
    }
    
    public func confirm(intent: String,
                        mandate: String? = nil,
                        mandateData: [String: Any]? = nil,
                        offSession: Bool? = nil,
                        paymentMethod: String? = nil,
                        paymentMethodOptions: [String: Any]? = nil,
                        paymentMethodTypes: [String]? = nil,
                        receiptEmail: String? = nil,
                        returnUrl: String? = nil,
                        savePaymentMethod: Bool? = nil,
                        setupFutureUsage: String? = nil,
                        shipping: [String: Any]? = nil,
                        useStripeSDK: Bool? = nil) -> EventLoopFuture<StripePaymentIntent> {
        return confirm(intent: intent,
                       mandate: mandate,
                       mandateData: mandateData,
                       offSession: offSession,
                       paymentMethod: paymentMethod,
                       paymentMethodOptions: paymentMethodOptions,
                       paymentMethodTypes: paymentMethodTypes,
                       receiptEmail: receiptEmail,
                       returnUrl: returnUrl,
                       savePaymentMethod: savePaymentMethod,
                       setupFutureUsage: setupFutureUsage,
                       shipping: shipping,
                       useStripeSDK: useStripeSDK)
    }
    
    public func capture(intent: String,
                        amountToCapture: Int? = nil,
                        applicationFeeAmount: Int? = nil,
                        statementDescriptor: String? = nil,
                        statementDescriptorSuffix: String? = nil,
                        transferData: [String: Any]? = nil) -> EventLoopFuture<StripePaymentIntent> {
        return capture(intent: intent,
                       amountToCapture: amountToCapture,
                       applicationFeeAmount: applicationFeeAmount,
                       statementDescriptor: statementDescriptor,
                       statementDescriptorSuffix: statementDescriptorSuffix,
                       transferData: transferData)
    }
    
    public func cancel(intent: String, cancellationReason: StripePaymentIntentCancellationReason? = nil) -> EventLoopFuture<StripePaymentIntent> {
        return cancel(intent: intent, cancellationReason: cancellationReason)
    }
    
    public func listAll(filter: [String: Any]? = nil) -> EventLoopFuture<StripePaymentIntentsList> {
        return listAll(filter: filter)
    }
}

public struct StripePaymentIntentsRoutes: PaymentIntentsRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let paymentintents = APIBase + APIVersion + "payment_intents"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(amount: Int,
                       currency: StripeCurrency,
                       applicationFeeAmount: Int?,
                       captureMethod: StripePaymentIntentCaptureMethod?,
                       confirm: Bool?,
                       confirmationMethod: StripePaymentIntentConfirmationMethod?,
                       customer: String?,
                       description: String?,
                       mandate: String?,
                       mandateData: [String: Any]?,
                       metadata: [String: String]?,
                       offSession: Bool?,
                       onBehalfOf: String?,
                       paymentMethod: String?,
                       paymentMethodOptions: [String: Any]?,
                       paymentMethodTypes: [String]?,
                       receiptEmail: String?,
                       returnUrl: String?,
                       savePaymentMethod: Bool?,
                       setupFutureUsage: String?,
                       shipping: [String: Any]?,
                       statementDescriptor: String?,
                       statementDescriptorSuffix: String?,
                       transferData: [String: Any]?,
                       transferGroup: String?,
                       useStripeSDK: Bool?) -> EventLoopFuture<StripePaymentIntent> {
        var body: [String: Any] = ["amount": amount,
                                   "currency": currency.rawValue]
        
        if let applicationfeeAmount = applicationFeeAmount {
            body["application_fee_amount"] = applicationfeeAmount
        }
        
        if let captureMethod = captureMethod {
            body["capture_method"] = captureMethod.rawValue
        }
        
        if let confirm = confirm {
            body["confirm"] = confirm
        }
        
        if let confirmationMethod = confirmationMethod {
            body["confirmation_method"] = confirmationMethod.rawValue
        }
        
        if let customer = customer {
            body["customer"] = customer
        }
        
        if let description = description {
            body["description"] = description
        }
        
        if let mandate = mandate {
            body["mandate"] = mandate
        }
        
        if let mandateData = mandateData {
            mandateData.forEach { body["mandate_data[\($0)]"] = $1 }
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let offSession = offSession {
            body["off_session"] = offSession
        }
        
        if let onBehalfOf = onBehalfOf {
            body["on_behalf_of"] = onBehalfOf
        }
        
        if let paymentMethod = paymentMethod {
            body["payment_method"] = paymentMethod
        }
        
        if let paymentMethodOptions = paymentMethodOptions {
            paymentMethodOptions.forEach { body["payment_method_options[\($0)]"] = $1 }
        }
        
        if let paymentMethodTypes = paymentMethodTypes {
            body["payment_method_types"] = paymentMethodTypes
        }
        
        if let receiptEmail = receiptEmail {
            body["receipt_email"] = receiptEmail
        }
        
        if let returnUrl = returnUrl {
            body["return_url"] = returnUrl
        }
        
        if let savePaymentMethod = savePaymentMethod {
            body["save_payment_method"] = savePaymentMethod
        }
        
        if let setupFutureUsage = setupFutureUsage {
            body["setup_future_usage"] = setupFutureUsage
        }
        
        if let shipping = shipping {
            shipping.forEach { body["shipping[\($0)]"] = $1 }
        }
        
        if let statementDescriptor = statementDescriptor {
            body["statement_descriptor"] = statementDescriptor
        }
        
        if let statementDescriptorSuffix = statementDescriptorSuffix {
            body["statement_descriptor_suffix"] = statementDescriptorSuffix
        }
        
        if let transferData = transferData {
            transferData.forEach { body["transfer_data[\($0)]"] = $1 }
        }
        
        if let transferGroup = transferGroup {
            body["transfer_group"] = transferGroup
        }
        
        if let useStripeSDK = useStripeSDK {
            body["use_stripe_sdk"] = useStripeSDK
        }
        
        return apiHandler.send(method: .POST, path: paymentintents, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(intent: String, clientSecret: String?) -> EventLoopFuture<StripePaymentIntent> {
        var query = ""
        if let clientSecret = clientSecret {
            query += "client_secret=\(clientSecret)"
        }
        return apiHandler.send(method: .GET, path: "\(paymentintents)/\(intent)", query: query)
    }
    
    public func update(intent: String,
                       amount: Int?,
                       applicationFeeAmount: Int?,
                       currency: StripeCurrency?,
                       customer: String?,
                       description: String?,
                       metadata: [String: String]?,
                       paymentMethod: String?,
                       paymentMethodTypes: [String]?,
                       receiptEmail: String?,
                       savePaymentMethod: Bool?,
                       setupFutureUsage: String?,
                       shipping: [String: Any]?,
                       statementDescriptor: String?,
                       statementDescriptorSuffix: String?,
                       transferData: [String: Any]?,
                       transferGroup: String?) -> EventLoopFuture<StripePaymentIntent> {
        var body: [String: Any] = [:]
        
        if let amount = amount {
            body["amount"] = amount
        }
        
        if let applicationfeeAmount = applicationFeeAmount {
            body["application_fee_amount"] = applicationfeeAmount
        }
        
        if let currency = currency {
            body["currency"] = currency.rawValue
        }
        
        if let customer = customer {
            body["customer"] = customer
        }
        
        if let description = description {
            body["description"] = description
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let paymentMethod = paymentMethod {
            body["payment_method"] = paymentMethod
        }
        
        if let paymentMethodTypes = paymentMethodTypes {
            body["payment_method_types"] = paymentMethodTypes
        }
        
        if let receiptEmail = receiptEmail {
            body["receipt_email"] = receiptEmail
        }
        
        if let savePaymentMethod = savePaymentMethod {
            body["save_payment_method"] = savePaymentMethod
        }
        
        if let setupFutureUsage = setupFutureUsage {
            body["setup_future_usage"] = setupFutureUsage
        }
        
        if let shipping = shipping {
            shipping.forEach { body["shipping[\($0)]"] = $1 }
        }
        
        if let statementDescriptor = statementDescriptor {
            body["statement_descriptor"] = statementDescriptor
        }
        
        if let statementDescriptorSuffix = statementDescriptorSuffix {
            body["statement_descriptor_suffix"] = statementDescriptorSuffix
        }
        
        if let transferData = transferData {
            transferData.forEach { body["transfer_data[\($0)]"] = $1 }
        }
        
        if let transferGroup = transferGroup {
            body["transfer_group"] = transferGroup
        }
        
        return apiHandler.send(method: .POST, path: "\(paymentintents)/\(intent)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func confirm(intent: String,
                        mandate: String?,
                        mandateData: [String: Any]?,
                        offSession: Bool?,
                        paymentMethod: String?,
                        paymentMethodOptions: [String: Any]?,
                        paymentMethodTypes: [String]?,
                        receiptEmail: String?,
                        returnUrl: String?,
                        savePaymentMethod: Bool?,
                        setupFutureUsage: String?,
                        shipping: [String: Any]?,
                        useStripeSDK: Bool?) -> EventLoopFuture<StripePaymentIntent> {
        var body: [String: Any] = [:]
        
        if let mandate = mandate {
            body["mandate"] = mandate
        }
        
        if let mandateData = mandateData {
            mandateData.forEach { body["mandate_data[\($0)]"] = $1 }
        }
        
        if let offSession = offSession {
            body["off_session"] = offSession
        }
        
        if let paymentMethod = paymentMethod {
            body["payment_method"] = paymentMethod
        }
        
        if let paymentMethodOptions = paymentMethodOptions {
            paymentMethodOptions.forEach { body["payment_method_options[\($0)]"] = $1 }
        }
        
        if let paymentMethodTypes = paymentMethodTypes {
            body["payment_method_types"] = paymentMethodTypes
        }
        
        if let receiptEmail = receiptEmail {
            body["receipt_email"] = receiptEmail
        }
        
        if let returnUrl = returnUrl {
            body["return_url"] = returnUrl
        }
        
        if let savePaymentMethod = savePaymentMethod {
            body["save_payment_method"] = savePaymentMethod
        }
        
        if let setupFutureUsage = setupFutureUsage {
            body["setup_future_usage"] = setupFutureUsage
        }
        
        if let shipping = shipping {
            shipping.forEach { body["shipping[\($0)]"] = $1 }
        }
        
        if let useStripeSDK = useStripeSDK {
            body["use_stripe_sdk"] = useStripeSDK
        }
        
        return apiHandler.send(method: .POST, path: "\(paymentintents)/\(intent)/confirm", body: .string(body.queryParameters), headers: headers)
    }
    
    public func capture(intent: String,
                        amountToCapture: Int?,
                        applicationFeeAmount: Int?,
                        statementDescriptor: String?,
                        statementDescriptorSuffix: String?,
                        transferData: [String: Any]?) -> EventLoopFuture<StripePaymentIntent> {
        var body: [String: Any] = [:]
        
        if let amountToCapture = amountToCapture {
            body["amount_to_capture"] = amountToCapture
        }
        
        if let applicationFeeAmount = applicationFeeAmount {
            body["application_fee_amount"] = applicationFeeAmount
        }

        if let statementDescriptor = statementDescriptor {
            body["statement_descriptor"] = statementDescriptor
        }
        
        if let statementDescriptorSuffix = statementDescriptorSuffix {
            body["statement_descriptor_suffix"] = statementDescriptorSuffix
        }
        
        if let transferData = transferData {
            transferData.forEach { body["transfer_data[\($0)]"] = $1 }
        }
        
        return apiHandler.send(method: .POST, path: "\(paymentintents)/\(intent)/capture", body: .string(body.queryParameters), headers: headers)
    }
    
    public func cancel(intent: String, cancellationReason: StripePaymentIntentCancellationReason?) -> EventLoopFuture<StripePaymentIntent> {
        var body: [String: Any] = [:]
        
        if let cancellationReason = cancellationReason {
            body["cancellation_reason"] = cancellationReason.rawValue
        }
        
        return apiHandler.send(method: .POST, path: "\(paymentintents)/\(intent)/cancel", body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(filter: [String: Any]?) -> EventLoopFuture<StripePaymentIntentsList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return apiHandler.send(method: .GET, path: paymentintents, query: queryParams, headers: headers)
    }
}