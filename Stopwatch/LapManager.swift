import Foundation

protocol LapManaging {
    var laps: [String] { get set }
    var delegate: LapManagerDelegate? { get set }
    func startTimer()
    func stopTimer()
    func addLap()
}

protocol LapManagerDelegate: class {
    func timerElapsedWith(_ time: String)
    func lapAdded()
}


class LapManager: LapManaging {
    var delegate: LapManagerDelegate?
    var laps: [String] = []

    private var timer: Timer?
    private var startDate: Date?

    func startTimer() {
        guard timer == nil else { return }
        startDate = Date()
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (timern) in
            if let startDate = self.startDate {
                let currentTime = Date()
                let elapsedTime = currentTime.timeIntervalSince(startDate)
                let timeString = self.createTimeStringFrom(interval: elapsedTime)
                self.delegate?.timerElapsedWith(timeString)
            } else {
                self.startDate = Date()
            }
        })
        timer?.fire()
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    func addLap() {
        if let startDate = self.startDate {
            let currentTime = Date()
            let elapsedTime = currentTime.timeIntervalSince(startDate)
            let timeString = self.createTimeStringFrom(interval: elapsedTime)
            laps.append(timeString)
            self.delegate?.lapAdded()
        }
    }

    private func createTimeStringFrom(interval: TimeInterval) -> String {
        let formater = DateFormatter()
        formater.dateFormat = "mm:ss:SS"
        let date = Date(timeIntervalSince1970: interval)
        return formater.string(from: date)

    }
}
