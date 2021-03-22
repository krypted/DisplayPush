//
//  StoredURLTVC.swift
//  NotificationContentRead
//
//

import UIKit

//MARK: - Class StoredURLTVC
class StoredURLTVC: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    
    public static var identifier: String {return String(describing: self)}
    public static var nib: UINib {return UINib(nibName: identifier, bundle: nil)}
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}
