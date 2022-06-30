import Foundation
import UIKit
import StoreKit

//var products: [SKProduct]?
private let allSubscriptionsIdentifiers: Set<String> = [
"subscription.basic",
"subscription.premium"
]
private var selected = ""
class StoreKitManager: NSObject {

    static let sharedInstance = StoreKitManager()

    func getProducts() {
      let request = SKProductsRequest(productIdentifiers: allSubscriptionsIdentifiers)
      request.delegate = self
      request.start()
    }
    
    func purchase(product: SKProduct) -> Bool {
        startObserving()
        selected = product.productIdentifier
         let payment = SKPayment(product: product)
         SKPaymentQueue.default().add(payment)
       return true
     }
}

extension StoreKitManager: SKProductsRequestDelegate, SKRequestDelegate, SKPaymentTransactionObserver {
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print("recevied products")
        ProductsDB.shared.items = response.products
  }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        print("error")
    }
    
    func requestDidFinish(_ request: SKRequest) {
           print("request did finish ")
             
         }
 
    func startObserving() {
        SKPaymentQueue.default().add(self)
    }
     
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            if transaction.error != nil {
                print("error: \(transaction.error?.localizedDescription)")
            }
            print("payment")
            switch transaction.transactionState {
            case .purchasing:
                print("handle purchasing state")
                break;
            case .purchased:
                print("handle purchased state")
                print(selected)
                break;
            case .restored:
                print("handle restored state")
                break;
            case .failed:
                print("handle failed state")
                break;
            case .deferred:
                print("handle deferred state")
                break;
            @unknown default:
                print("Fatal Error");
            }
        }
    }

}
final class ProductsDB: ObservableObject, Identifiable {
  static let shared = ProductsDB()
  var items: [SKProduct] = [] {
    willSet {
      DispatchQueue.main.async {
        self.objectWillChange.send()
      }
    }
  }

}


