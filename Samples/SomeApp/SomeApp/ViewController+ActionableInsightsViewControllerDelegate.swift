import UIKit
import TinkMoneyManagerUI

extension ViewController: ActionableInsightsViewControllerDelegate {
    func actionableInsightsViewController(_ viewController: TinkMoneyManagerUI.ActionableInsightsViewController, refreshCredentialsWithID credentialsID: TinkMoneyManagerUI.Credentials.ID, completionHandler: @escaping (Result<Void, any Error>) -> Void) {

    }

    func actionableInsightsViewController(_ viewController: TinkMoneyManagerUI.ActionableInsightsViewController, showLeftToSpendForMonth month: TinkMoneyManagerUI.Month) {

    }

    func actionableInsightsViewController(_ viewController: TinkMoneyManagerUI.ActionableInsightsViewController, initiateTransferFromAccount sourceIdentity: TinkMoneyManagerUI.TransferIdentity?, to destinationIdentity: TinkMoneyManagerUI.TransferIdentity?, amount: Double?, currencyCode: String?, completionHandler: @escaping (Result<Void, any Error>) -> Void) {

    }
}
