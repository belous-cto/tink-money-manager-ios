import UIKit
import TinkMoneyManagerUI

class ViewController: UIViewController {

    // Initialization of SDK used in this method only as an example and not recommended in production,
    // most probably you would need to do this in the different place/methods of you app.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        setupAppearance()

        let config = TinkMoneyManagerConfiguration(clientID: "YOUR_CLIENT_ID_FROM_TINK_CONSOLE")
        let tink = Tink(configuration: config)
        tink.userSession = .accessToken("USER_ACCESS_TOKEN_HERE")
        tink.refresh()

        let financeOverview = FinanceOverviewViewController(tink: tink, features: [
            .actionableInsights(delegate: self),
            .statistics([.expenses, .income]),
            .latestTransactions,
            .budgets,
            .recommendedBudgets
        ])

        // Usage of the separate features:
        // let transactions = TransactionsViewController(tink: tink)
        // let accounts = AccountsViewController(tink: tink)

        // There is an alternative way to initialize and use the SDK with using Tink shared singleton.
        // The same result can be achieved by using the following code:
        // Tink.configure(with: config)
        // Tink.shared.userSession = .accessToken("accessToken")
        // The benifit of this approach is that you will not need to manage the lifetime of the `Tink` instance on your own
        // and you will be able to use the features of the SDK without providing `tink` argument to them like this:
        // let financeOverview = FinanceOverviewViewController(features: [])
        // or
        // TransactionsViewController()
        // In this case all the features (screens) will use the shared Tink object.

        let navigationController = UINavigationController(rootViewController: financeOverview)
        financeOverview.title = "Money Manager"

        // To change the appearance of the navigation bar:
        // let appearance = UINavigationBarAppearance()
        // appearance.configureWithOpaqueBackground()
        // appearance.backgroundColor = .systemBackground
        // navigationController.navigationBar.standardAppearance = appearance
        // navigationController.navigationBar.scrollEdgeAppearance = navigationController.navigationBar.standardAppearance

        present(navigationController, animated: true)
    }
}

extension ViewController {
    func setupAppearance() {
        let colors = ColorProvider()

        let accentColor = UIColor(red: 1.0/255, green: 167.0/255.0, blue: 106.0/255.0, alpha: 1.0)

        colors.accent = accentColor
        colors.accentBackground = UIColor(red: 0.17647058823529413, green: 0.20392156862745098, blue: 0.21176470588235294, alpha: 0.15000000596046448)
        colors.background = UIColor(red: 0.9686274509803922, green: 0.9686274509803922, blue: 0.9725490196078431, alpha: 1.0)
        colors.secondaryBackground = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        colors.label = UIColor(red: 0.17647058823529413, green: 0.20392156862745098, blue: 0.21176470588235294, alpha: 1.0)
        colors.secondaryLabel = UIColor(red: 0.20000000298023224, green: 0.20399999618530273, blue: 0.2240000069141388, alpha: 0.5)
        colors.button = UIColor(red: 0.03529411764705882, green: 0.5176470588235295, blue: 0.8901960784313725, alpha: 1.0)
        colors.buttonLabel = UIColor(red: 0.968999981880188, green: 0.9800000190734863, blue: 0.984000027179718, alpha: 1.0)
        colors.expenses = UIColor(red: 108.0/255.0, green: 78.0/255.0, blue: 230.0/255.0, alpha: 1.0)
        colors.income = accentColor
        colors.transfers = UIColor(red: 0.17647058823529413, green: 0.20392156862745098, blue: 0.21176470588235294, alpha: 1.0)
        colors.uncategorized = UIColor(red: 0.17647058823529413, green: 0.20392156862745098, blue: 0.21176470588235294, alpha: 1.0)
        colors.separator = UIColor(red: 0.8669999837875366, green: 0.875, blue: 0.906000018119812, alpha: 1.0)
        colors.secondaryButton = UIColor(red: 0.03529411764705882, green: 0.5176470588235295, blue: 0.8901960784313725, alpha: 1.0)
        colors.tertiaryButton = accentColor
        colors.warning = UIColor(red: 0.9921568627450981, green: 0.796078431372549, blue: 0.43137254901960786, alpha: 1.0)
        colors.critical = UIColor(red: 0.8392156862745098, green: 0.18823529411764706, blue: 0.19215686274509805, alpha: 1.0)
        colors.groupedBackground = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        colors.secondaryGroupedBackground = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        colors.leftToSpend = UIColor(red: 254.0/255.0, green: 203.0/255.0, blue: 75.0/255.0, alpha: 1.0)

        let fontName = "TrebuchetMS-Bold"

        let fonts = FontProvider()
        fonts.lightFont = .custom(fontName)
        fonts.regularFont = .custom(fontName)
        fonts.semiBoldFont = .custom(fontName)
        fonts.boldFont = .custom(fontName)

        let icons = IconProvider()
        icons.exclude = UIImage(systemName: "xmark")!

        Appearance.provider = AppearanceProvider(colors: colors, fonts: fonts, icons: icons)
    }
}
