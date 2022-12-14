import Foundation
import UIKit

/// UIKit class EmployeeTableViewCell that creates each label and sets them up within the Table View
class EmployeeTableViewCell : UITableViewCell {
    
    // MARK: Initilizaton of View Cells
    
    let profileImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = EmployeeListViewController.Constants.imageCornerRadius
        image.layer.masksToBounds = true
        
        return image
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: EmployeeListViewController.Constants.nameLabelFontSize)

        return label
    }()
    
    let teamLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.font = UIFont.systemFont(ofSize: EmployeeListViewController.Constants.teamLabelFontSize)
        
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: EmployeeListViewController.Constants.emailLabelFontSize)
        
        return label
    }()
    
    let containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false

        return containerView
    }()
    
    // MARK: Init
    // Creates a new instance of each already set up view
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    // MARK: UI Setup
    /// Sets up each view within the container view
    func setupViews() {
        self.contentView.addSubview(profileImageView)
        self.containerView.addSubview(nameLabel)
        self.containerView.addSubview(teamLabel)
        self.containerView.addSubview(emailLabel)
        self.contentView.addSubview(containerView)
        
        profileImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant: EmployeeListViewController.Constants.profileImageLeading).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: EmployeeListViewController.Constants.profileImageWidth).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: EmployeeListViewController.Constants.profileImageHeight).isActive = true
        
        containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo:self.profileImageView.trailingAnchor, constant: EmployeeListViewController.Constants.containerViewLeading).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant: EmployeeListViewController.Constants.containerViewTrailing).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: EmployeeListViewController.Constants.containerViewHeight).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo:self.containerView.topAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: EmployeeListViewController.Constants.nameLabelTop).isActive = true
        
        teamLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        teamLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
        teamLabel.topAnchor.constraint(equalTo:self.nameLabel.bottomAnchor).isActive = true
        
        emailLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        emailLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
        emailLabel.topAnchor.constraint(equalTo:self.teamLabel.bottomAnchor, constant: EmployeeListViewController.Constants.emailLabelTop).isActive = true
    }
    
}
