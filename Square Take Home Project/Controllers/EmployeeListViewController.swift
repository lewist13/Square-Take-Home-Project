import UIKit

/// UIKit wrapper that exposes the Swift Employee Directory implementation.
class EmployeeListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    static let viewController = EmployeeListViewController()
    
    private(set) var viewModel: NetworkManager!
    
    var tableView: UITableView!
    var tableRefresh: UIRefreshControl!
    var navBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewModel()
        setupNavigationBar()
        createTableView()
        createRefreshControl()
        fetchEmployeeData(urlString: NetworkManager.shared.fullEndpoint)
    }
    
    // MARK: Setup Views
    
    // Create Navigation Bar - includes sorting feature
    func setupNavigationBar() {
        navBar = UINavigationBar()
        view.addSubview(navBar)

        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        navBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.navBarLeading).isActive = true
        navBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Constants.navBarTrailing).isActive = true

        var menuItems: [UIAction] {
            return [
                UIAction(title: Constants.menuItemsNameSort) { (_) in
                    self.sortByName()
                },
                UIAction(title: Constants.menuItemsTeamSort) { (_) in
                    self.sortByTeam()
                }
            ]
        }

        var menu: UIMenu {
            return UIMenu(title: Constants.uiMenuTitle, image: nil, identifier: nil, options: [], children: menuItems)
        }

        let navItem = UINavigationItem(title: Constants.navItemTitle)
        navItem.rightBarButtonItem = UIBarButtonItem(title: Constants.navItemRightBarTitle, image: nil, primaryAction: nil, menu: menu)

        navBar.setItems([navItem], animated: false)
        
        navigationItem.title = Constants.navItemTitle
    }

    /// Creates and handles reloading employee data when refreshing
    func createRefreshControl() {
        tableRefresh = UIRefreshControl()
        tableRefresh.tintColor = .gray
        tableRefresh.addTarget(self, action: #selector(handleRefreshList(_:)), for: .valueChanged)

        self.tableView.refreshControl = tableRefresh
    }
    
    /// Starts reload, handles content display, ends reload
    func refreshTableAfterCellExpansion() {
        self.tableView.beginUpdates()
        self.tableView.setNeedsDisplay()
        self.tableView.endUpdates()
    }

    /// Clears and fetches employee data upon refresh
    @objc func handleRefreshList(_ tableRefresh: UIRefreshControl) {
        viewModel.clearEmployeeList()
        fetchEmployeeData(urlString: NetworkManager.shared.fullEndpoint)
        tableRefresh.endRefreshing()
    }
    
    /// Sets up the Table View under the Navigation Bar
    func createTableView() {
        tableView = UITableView()
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: navBar.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.tableViewLeading).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Constants.tableViewTrailing).isActive = true
        
        tableView.register(EmployeeTableViewCell.self,
                           forCellReuseIdentifier: Constants.cellReuseIdentifier)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: UITableViewDataSource
    
    /// Creates rows of cells determined by the amount of employees
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.employees.count
    }
    
    /// Creates each cell view for specific employee data
    ///  - **Data**:
    ///   - nameLabel: The employee's full name
    ///   - teamLabel: The employee's team name
    ///   - emailLabel: The employee's email address
    ///   - profileImageView: The employee's profile image
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellReuseIdentifier, for: indexPath) as! EmployeeTableViewCell
        let employeeData = viewModel.employees[indexPath.row]
        cell.nameLabel.text = employeeData.fullName
        cell.teamLabel.text = employeeData.teamName + " Team"
        cell.emailLabel.text = employeeData.emailAddress
        if employeeData.smallPhotoUrl != nil {
            cell.profileImageView.loadImage(urlString: employeeData.smallPhotoUrl!)
        }
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    /// Deselects each cell containing the team name
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("\(indexPath.row): \(viewModel.employees[indexPath.row].fullName), \(viewModel.employees[indexPath.row].teamName)")
    }
    
    /// Sets height for each table view cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.tableViewRowHeight
    }
    
    // MARK: Helper Methods
    /// Creates new view model instance
    func setViewModel() {
        viewModel = NetworkManager.init()
    }
    
    /// Creates a new list of employee data upon being cleared
    func newEmployeeList(newEmployeeList: [Employee]) {
        viewModel.clearEmployeeList()

        for employee in newEmployeeList {
            self.viewModel.addEmployee(newEmployee: employee)
        }
        
        self.tableView.reloadData()
    }
    
    /// Fetches employee data from JSON Endpoint
    func fetchEmployeeData(urlString: String) {
        viewModel.fetchEmployeeData(url: urlString) { (newEmployeeList, error) in
            guard error == nil else {
                print(error ?? ErrorMessage.employeeNotFetched)
                return
            }
            
            DispatchQueue.main.sync {
                self.newEmployeeList(newEmployeeList: newEmployeeList!)
            }
        }
    }
    
    /// Creates the name sorting feature
    @objc func sortByName() {
        let newSortedEmployeeList: [Employee] = self.viewModel.employees.sorted() { $0.fullName < $1.fullName }
        newEmployeeList(newEmployeeList: newSortedEmployeeList)

    }
    
    /// Creates the team sorting feature
    @objc func sortByTeam() {
        let newSortedEmployeeList: [Employee] = self.viewModel.employees.sorted() { $0.teamName < $1.teamName }
        newEmployeeList(newEmployeeList: newSortedEmployeeList)
    }
    
    // MARK: - TableView / Navigation Bar / ContainerView Properties
    struct Constants {
        static let navItemTitle: String = "Our Employees"
        static let menuItemsNameSort: String = "Name"
        static let menuItemsTeamSort: String = "Team"
        static let uiMenuTitle: String = "Sort by"
        static let navItemRightBarTitle: String = "Sort"
        static let cellReuseIdentifier: String = "EmployeeTableViewCell"
        static let navBarLeading: CGFloat = 10.0
        static let navBarTrailing: CGFloat = -10.0
        static let tableViewLeading: CGFloat = 10.0
        static let tableViewTrailing: CGFloat = -10.0
        static let tableViewRowHeight: CGFloat = 100
        static let imageCornerRadius: CGFloat = 15.0
        static let nameLabelFontSize: CGFloat = 20.0
        static let teamLabelFontSize: CGFloat = 17.0
        static let emailLabelFontSize: CGFloat = 17.0
        static let profileImageLeading: CGFloat = 10.0
        static let profileImageWidth: CGFloat = 70.0
        static let profileImageHeight: CGFloat = 70.0
        static let containerViewLeading: CGFloat = 10.0
        static let containerViewTrailing: CGFloat = -10.0
        static let containerViewHeight: CGFloat = 80.0
        static let nameLabelTop: CGFloat = 10.0
        static let emailLabelTop: CGFloat = 20.0
    }
}
