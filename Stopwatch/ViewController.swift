//
//  ViewController.swift
//  Stopwatch
//
//  Created by Sipan on 2020-05-18.
//  Copyright © 2020 Sipan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var timeCountBackgroundView: UIView!
    @IBOutlet weak var timeCountLabel: UILabel!
    @IBOutlet weak var lapCountTableView: UITableView!
    private var lapManager: LapManaging = LapManager()

    private var laps: [Float] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        timeCountBackgroundView.layer.borderWidth = 3
        timeCountBackgroundView.layer.borderColor = UIColor.black.cgColor
        timeCountBackgroundView.layer.cornerRadius = timeCountBackgroundView.frame.width / 2
        lapManager.delegate = self
        lapCountTableView.delegate = self
        lapCountTableView.dataSource = self
    }

    @IBAction func startButtonTapped(_ sender: Any) {
        lapManager.startTimer()
    }

    @IBAction func stopButtonTapped(_ sender: UIButton) {
        lapManager.stopTimer()
    }

    @IBAction func lapButtonTapped(_ sender: Any) {
        lapManager.addLap()
    }

}

extension ViewController: UITableViewDelegate {

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        lapManager.laps.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = lapManager.laps[indexPath.row]
        return cell
    }
}

extension ViewController: LapManagerDelegate {

    func timerElapsedWith(_ time: String){
        timeCountLabel.text = time
    }

    func lapAdded() {
        lapCountTableView.reloadData()
    }
}

