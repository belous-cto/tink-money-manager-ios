import TinkMoneyManagerUI
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    let accentColor = UIColor(red: 1.0/255, green: 167.0/255.0, blue: 106.0/255.0, alpha: 1.0)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {


        let configuration = TinkMoneyManagerConfiguration(clientID: "YOUR_CLIENT_ID")
        Tink.configure(with: configuration)
        Tink.shared.userSession = .accessToken("YOU_ACCESS_TOKEN")

        setupAppearance()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = initiateTabBarController()
        window?.makeKeyAndVisible()

        return true
    }

    func setupAppearance() {
        let colorProvider = ColorProvider()

        colorProvider.accent = accentColor
        colorProvider.accentBackground = UIColor(red: 0.17647058823529413, green: 0.20392156862745098, blue: 0.21176470588235294, alpha: 0.15000000596046448)
        colorProvider.background = UIColor(red: 0.9686274509803922, green: 0.9686274509803922, blue: 0.9725490196078431, alpha: 1.0)
        colorProvider.secondaryBackground = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        colorProvider.label = UIColor(red: 0.17647058823529413, green: 0.20392156862745098, blue: 0.21176470588235294, alpha: 1.0)
        colorProvider.secondaryLabel = UIColor(red: 0.20000000298023224, green: 0.20399999618530273, blue: 0.2240000069141388, alpha: 0.5)
        colorProvider.button = UIColor(red: 0.03529411764705882, green: 0.5176470588235295, blue: 0.8901960784313725, alpha: 1.0)
        colorProvider.buttonLabel = UIColor(red: 0.968999981880188, green: 0.9800000190734863, blue: 0.984000027179718, alpha: 1.0)
        colorProvider.expenses = UIColor(red: 108.0/255.0, green: 78.0/255.0, blue: 230.0/255.0, alpha: 1.0)
        colorProvider.income = accentColor
        colorProvider.transfers = UIColor(red: 0.17647058823529413, green: 0.20392156862745098, blue: 0.21176470588235294, alpha: 1.0)
        colorProvider.uncategorized = UIColor(red: 0.17647058823529413, green: 0.20392156862745098, blue: 0.21176470588235294, alpha: 1.0)
        colorProvider.separator = UIColor(red: 0.8669999837875366, green: 0.875, blue: 0.906000018119812, alpha: 1.0)
        colorProvider.secondaryButton = UIColor(red: 0.03529411764705882, green: 0.5176470588235295, blue: 0.8901960784313725, alpha: 1.0)
        colorProvider.tertiaryButton = accentColor
        colorProvider.warning = UIColor(red: 0.9921568627450981, green: 0.796078431372549, blue: 0.43137254901960786, alpha: 1.0)
        colorProvider.critical = UIColor(red: 0.8392156862745098, green: 0.18823529411764706, blue: 0.19215686274509805, alpha: 1.0)
        colorProvider.groupedBackground = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        colorProvider.secondaryGroupedBackground = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        colorProvider.leftToSpend = UIColor(red: 254.0/255.0, green: 203.0/255.0, blue: 75.0/255.0, alpha: 1.0)

        let fontName = "TrebuchetMS-Bold"

        let fonts = FontProvider()
        fonts.lightFont = .custom(fontName)
        fonts.regularFont = .custom(fontName)
        fonts.semiBoldFont = .custom(fontName)
        fonts.boldFont = .custom(fontName)

        Appearance.provider = AppearanceProvider(colors: colorProvider, fonts: fonts)

        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: fontName, size: 12)!], for: .normal)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: fontName, size: 18)!]
    }

    func initiateFinanceOverview() -> FinanceOverviewViewController {
        let overviewViewController = FinanceOverviewViewController(tink: Tink.shared, features: [.statistics([.expenses, .leftToSpend, .income]), .accounts, .latestTransactions, .budgets])

        overviewViewController.title = "Overview"
        overviewViewController.tabBarItem = UITabBarItem(title: "Overview", image: UIImage(systemName: "chart.pie.fill"), tag: 0)

        return overviewViewController
    }

    func initiateAccounts() -> AccountsViewController {
        let accountsViewController = AccountsViewController(tink: Tink.shared, grouping: .kind, predicate: .all)

        accountsViewController.title = "Accounts"
        accountsViewController.tabBarItem = UITabBarItem(title: "Accounts", image: UIImage(systemName: "wallet.bifold"), tag: 0)

        return accountsViewController
    }

    func initiateTransactions() -> TransactionsViewController {
        let transactionsViewController = TransactionsViewController(tink: Tink.shared)

        transactionsViewController.title = "Transactions"
        transactionsViewController.tabBarItem = UITabBarItem(title: "Transactions", image: UIImage(systemName: "list.dash"), tag: 0)

        return transactionsViewController
    }

    func initiateTabBarController() -> UITabBarController {
        let overviewViewController = initiateFinanceOverview()
        let accountsViewController = initiateAccounts()
        let transactionsViewController = initiateTransactions()

        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = accentColor
        tabBarController.setViewControllers([
            UINavigationController(rootViewController: overviewViewController),
            UINavigationController(rootViewController: accountsViewController),
            UINavigationController(rootViewController: transactionsViewController)
        ], animated: false)

        return tabBarController
    }
}
