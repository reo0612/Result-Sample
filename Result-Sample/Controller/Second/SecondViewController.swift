
import UIKit

final class SecondViewController: UIViewController {
    
    @IBOutlet private var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: TableViewCell.className, bundle: nil), forCellReuseIdentifier: TableViewCell.className)
        }
    }
    
    private var githubs: [GithubModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getGithub()
    }
    
    private func getGithub() {
        // Result型では、成功か失敗かの2択で返ってくる
        DataRequest.shared.githubApi { (result) in
            switch result {
            // 成功時
            case .success(let githubs):
                self.githubs = githubs
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            // 失敗時
            case .failure(let error):
                Alert.okAlert(vc: self, title: error.localizedDescription, message: "")
            }
        }
    }
}

extension SecondViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        githubs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.className, for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        let github = githubs[indexPath.row]
        cell.configure(github: github)
        return cell
    }
}
