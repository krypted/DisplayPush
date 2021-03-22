//
//  ViewController.swift
//  NotificationContentRead
//
//

import UIKit
import SafariServices

//MARK: - Class ViewController
class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Variable declaration(s)
    var arrOfURLs: [String] = []
    
    deinit {
        removeObservers()
    }
}

//MARK: UIViewController method(s) & propertie(s)
extension ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addObservers()
        prepareUIs()
    }
}

//MARK: Observer(s)
extension ViewController {
    
    func addObservers() {
        _defaultNotificationCenter.addObserver(self, selector: #selector(didRefreshList(_:)), name: nfPushReceived, object: nil)
        _defaultNotificationCenter.addObserver(self, selector: #selector(didRefreshList(_:)), name: nfApplicationBecomeActive, object: nil)
    }
    
    @objc func didRefreshList(_ notification: Notification) {
        prepareModels()
    }
    
    func removeObservers() {
        _defaultNotificationCenter.removeObserver(self, name: nfPushReceived, object: nil)
        _defaultNotificationCenter.removeObserver(self, name: nfApplicationBecomeActive, object: nil)
    }
}

//MARK: UIRelated
extension ViewController {
    
    func prepareUIs() {
        prepareModels()
        registeredNIBs()
    }
    
    func prepareModels() {
        if let urls = fetchStoredNotifications() {
            arrOfURLs = urls.reversed()
        }
        tableView.reloadData()
    }
    
    func registeredNIBs() {
        tableView.register(StoredURLTVC.nib, forCellReuseIdentifier: StoredURLTVC.identifier)
    }
}

//MARK: UITableView
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        .leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        .leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrOfURLs.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        84
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: StoredURLTVC.identifier, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell is StoredURLTVC {
            let cellStoredURL = cell as! StoredURLTVC
            cellStoredURL.lblTitle.text = arrOfURLs[indexPath.row]
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .automatic)
        guard let url = URL(string: arrOfURLs[indexPath.row]) else{return}
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        let vc = SFSafariViewController(url: url, configuration: config)
        present(vc, animated: true)
    }
}
