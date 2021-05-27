//
//  ViewController.swift
//  blackjack21
//
//  Created by Lai Po Ying on 2021/5/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var betLabel: UILabel!
    @IBOutlet weak var betSegmentedControl: UISegmentedControl!
    @IBOutlet weak var betStepper: UIStepper!
    @IBOutlet weak var chipLabel: UILabel!
    @IBOutlet weak var bankerCard1ImageView: UIImageView!
    @IBOutlet weak var bankerCard2ImageView: UIImageView!
    @IBOutlet weak var bankerCard3ImageView: UIImageView!
    @IBOutlet weak var bankerCard4ImageView: UIImageView!
    @IBOutlet weak var bankerCard5ImageView: UIImageView!
    @IBOutlet weak var playerCard1ImageView: UIImageView!
    @IBOutlet weak var playerCard2ImageView: UIImageView!
    @IBOutlet weak var playerCard3ImageView: UIImageView!
    @IBOutlet weak var playerCard4ImageView: UIImageView!
    @IBOutlet weak var playerCard5ImageView: UIImageView!
    @IBOutlet weak var bankerPointLabel: UILabel!
    @IBOutlet weak var playerPointLabel: UILabel!
    @IBOutlet weak var playerHoleCardButton: UIButton!
    @IBOutlet weak var cardTabelView: UIView!
    @IBOutlet weak var betView: UIView!
    
    var bet = 0
    var chip = 1000
    var bankerCard1Index:Int?
    var bankerCard2Index:Int?
    var bankerCard3Index:Int?
    var bankerCard4Index:Int?
    var bankerCard5Index:Int?
    var playerCard1Index:Int?
    var playerCard2Index:Int?
    var playerCard3Index:Int?
    var playerCard4Index:Int?
    var playerCard5Index:Int?
    var bankerPoint = 0
    var playerPoint = 0
    
    let card: [String] = ["d01", "d02", "d03", "d04", "d05", "d06", "d07", "d08", "d09", "d10", "d11", "d12", "d13", "c01", "c02", "c03", "c04", "c05", "c06", "c07", "c08", "c09", "c10", "c11", "c12", "c13", "h01", "h02", "h03", "h04", "h05", "h06", "h07", "h08", "h09", "h10", "h11", "h12", "h13", "s01", "s02", "s03", "s04", "s05", "s06", "s07", "s08", "s09", "s10", "s11", "s12", "s13"]
    let cardPoint: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10]
    func backToDefault () {
        bankerPoint = 0
        playerPoint = 0
        bet = 0
        betLabel.text = "\(bet)"
        betSegmentedControl.selectedSegmentIndex = 0
        betStepper.value = 0
        betStepper.isEnabled = true
        
        playerCard1ImageView.image = nil
        playerCard2ImageView.image = nil
        playerCard3ImageView.image = nil
        playerCard4ImageView.image = nil
        playerCard5ImageView.image = nil
        bankerCard1ImageView.image = nil
        bankerCard2ImageView.image = nil
        bankerCard3ImageView.image = nil
        bankerCard4ImageView.image = nil
        bankerCard5ImageView.image = nil
        
        playerCard3ImageView.isHidden = true
        playerCard4ImageView.isHidden = true
        playerCard5ImageView.isHidden = true
        bankerCard3ImageView.isHidden = true
        bankerCard4ImageView.isHidden = true
        bankerCard5ImageView.isHidden = true

        bankerCard1Index = nil
        bankerCard2Index = nil
        bankerCard3Index = nil
        bankerCard4Index = nil
        bankerCard5Index = nil
        playerCard1Index = nil
        playerCard2Index = nil
        playerCard3Index = nil
        playerCard4Index = nil
        playerCard5Index = nil
        
        bankerCard1Index = Int.random(in: 0...51)
        playerCard1Index = Int.random(in: 0...51)
        bankerCard2Index = Int.random(in: 0...51)
        playerCard2Index = Int.random(in: 0...51)
        bankerCard1ImageView.image = UIImage(named: "Image")
        repeat {
            playerCard1Index = Int.random(in: 0...51)
        } while playerCard1Index == bankerCard1Index
        playerCard1ImageView.image = UIImage(named: card[playerCard1Index!])
        playerHoleCardButton.setImage(playerCard1ImageView.image, for: .highlighted)
        playerHoleCardButton.isHidden = false
        playerPoint += cardPoint[playerCard1Index!]
        playerPointLabel.text = "\(playerPoint)"
        repeat {
            bankerCard2Index = Int.random(in: 0...51)
        } while bankerCard2Index == bankerCard1Index || bankerCard2Index == playerCard1Index
        bankerCard2ImageView.image = UIImage(named: card[bankerCard2Index!])
        bankerPoint += cardPoint[bankerCard2Index!]
        bankerPointLabel.text = "\(bankerPoint)"
        bankerPointLabel.textColor = UIColor.black
        repeat {
            playerCard2Index = Int.random(in: 0...51)
        } while playerCard2Index == bankerCard1Index || playerCard2Index == playerCard1Index || playerCard2Index == bankerCard2Index
        playerCard2ImageView.image = UIImage(named: card[playerCard2Index!])
        playerPoint += cardPoint[playerCard2Index!]
        playerPointLabel.text = "\(playerPoint)"
        playerPointLabel.textColor = UIColor.black
        
        
    }
    
    func loseMessageAlert() {
        let alert = UIAlertController(title: "YOU LOSE", message: "Your point is \(playerPoint)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Next round", style: .default, handler: {
            action in
            self.chip -= self.bet
            self.chipLabel.text = "$ \(self.chip)"
            self.backToDefault()
            if self.chip == 0 {
                let loseAllMoneyAlert = UIAlertController(title: "OMG", message: "YOU LOSE ALL MONEY", preferredStyle: .alert)
                let action = UIAlertAction(title: "TRY AGAIN", style: .default, handler: {
                    action in
                    self.chip = 1000
                    self.chipLabel.text = "$ \(self.chip)"
                })
                loseAllMoneyAlert.addAction(action)
                self.present(loseAllMoneyAlert, animated: true, completion: nil)
            }
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    func winMessageAlert() {
        let alert = UIAlertController(title: "YOU WIN", message: "Your point is \(playerPoint) and Banker point is \(bankerPoint)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Next round", style: .default, handler: {
            action in
            self.chip += self.bet
            self.chipLabel.text = "$ \(self.chip)"
            self.backToDefault()
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    func tieMessageAlert() {
        let alert = UIAlertController(title: "TIE", message: "Your point is \(playerPoint) and Banker point is \(bankerPoint)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Next round", style: .default, handler: {
            action in
            self.backToDefault()
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        cardTabelView.layer.borderColor = CGColor(srgbRed: 255/255, green: 249/255, blue: 135/255, alpha: 1)
        cardTabelView.layer.borderWidth = 3
        cardTabelView.layer.cornerRadius = 5
        
        betView.layer.borderColor = UIColor.systemGray.cgColor
        betView.layer.borderWidth = 3
        betView.layer.cornerRadius = 5
        
        bankerCard1Index = Int.random(in: 0...51)
        playerCard1Index = Int.random(in: 0...51)
        bankerCard2Index = Int.random(in: 0...51)
        playerCard2Index = Int.random(in: 0...51)
        bankerCard1ImageView.image = UIImage(named: "Image")
        repeat {
            playerCard1Index = Int.random(in: 0...51)
        } while playerCard1Index == bankerCard1Index
        playerCard1ImageView.image = UIImage(named: card[playerCard1Index!])
        playerHoleCardButton.setImage(playerCard1ImageView.image, for: .highlighted)
        playerPoint += cardPoint[playerCard1Index!]
        playerPointLabel.text = "\(playerPoint)"
        repeat {
            bankerCard2Index = Int.random(in: 0...51)
        } while bankerCard2Index == bankerCard1Index || bankerCard2Index == playerCard1Index
        bankerCard2ImageView.image = UIImage(named: card[bankerCard2Index!])
        bankerPoint += cardPoint[bankerCard2Index!]
        bankerPointLabel.text = "\(bankerPoint)"
        repeat {
            playerCard2Index = Int.random(in: 0...51)
        } while playerCard2Index == bankerCard1Index || playerCard2Index == playerCard1Index || playerCard2Index == bankerCard2Index
        playerCard2ImageView.image = UIImage(named: card[playerCard2Index!])
        playerPoint += cardPoint[playerCard2Index!]
        playerPointLabel.text = "\(playerPoint)"
        
        
    }
    @IBAction func betStepperChanged(_ sender: UIStepper) {
        
        if betSegmentedControl.selectedSegmentIndex == 0 {
            bet += 1 * Int(betStepper.value)
            if bet >= 0, bet <= chip {
                betLabel.text = "\(bet)"
                betStepper.value = 0
            }
            else if bet > chip {
                bet -= 1
                betLabel.text = "\(bet)"
                betStepper.value = 0
            }
            else {
                bet += 1
                betLabel.text = "\(bet)"
                betStepper.value = 0
            }
            
        }
        else if betSegmentedControl.selectedSegmentIndex == 1 {
            bet += 10 * Int(betStepper.value)
            if bet >= 0, bet <= chip {
                betLabel.text = "\(bet)"
                betStepper.value = 0
            }
            else if bet > chip {
                bet -= 10
                betLabel.text = "\(bet)"
                betStepper.value = 0
            }
            else {
                bet += 10
                betLabel.text = "\(bet)"
                betStepper.value = 0
            }
        }
        else {
            bet += 100 * Int(betStepper.value)
            if bet >= 0, bet <= chip {
                betLabel.text = "\(bet)"
                betStepper.value = 0
            }
            else if bet > chip {
                bet -= 100
                betLabel.text = "\(bet)"
                betStepper.value = 0
            }
            else {
                bet += 100
                betLabel.text = "\(bet)"
                betStepper.value = 0
            }
        }
    }
    @IBAction func betSegmentedControlChanged(_ sender: UISegmentedControl) {
        betStepper.value = 0
    }
    @IBAction func hitButtonPressed(_ sender: UIButton) {
        betStepper.isEnabled = false
        if playerCard3ImageView.isHidden == true {
            playerCard3Index = Int.random(in: 0...51)
            repeat {
                playerCard3Index = Int.random(in: 0...51)
            } while playerCard3Index == bankerCard1Index || playerCard3Index == playerCard1Index || playerCard3Index == bankerCard2Index || playerCard3Index == playerCard2Index
            playerCard3ImageView.image = UIImage(named: card[playerCard3Index!])
            playerPoint += cardPoint[playerCard3Index!]
            playerCard3ImageView.isHidden = false
            playerPointLabel.text = "\(playerPoint)"
            if playerPoint > 21 {
                playerPointLabel.textColor = UIColor.red
                bankerCard1ImageView.image = UIImage(named: card[bankerCard1Index!])
                bankerPoint += cardPoint[bankerCard1Index!]
                bankerPointLabel.text = "\(bankerPoint)"
                playerHoleCardButton.isHidden = true
                loseMessageAlert()
            }
        }
        else if playerCard4ImageView.isHidden == true {
            playerCard4Index = Int.random(in: 0...51)
            repeat {
                playerCard4Index = Int.random(in: 0...51)
            } while playerCard4Index == bankerCard1Index || playerCard4Index == playerCard1Index || playerCard4Index == bankerCard2Index || playerCard4Index == playerCard2Index || playerCard4Index == playerCard3Index
            playerCard4ImageView.image = UIImage(named: card[playerCard4Index!])
            playerPoint += cardPoint[playerCard4Index!]
            playerCard4ImageView.isHidden = false
            playerPointLabel.text = "\(playerPoint)"
            if playerPoint > 21 {
                playerPointLabel.textColor = UIColor.red
                bankerCard1ImageView.image = UIImage(named: card[bankerCard1Index!])
                bankerPoint += cardPoint[bankerCard1Index!]
                bankerPointLabel.text = "\(bankerPoint)"
                playerHoleCardButton.isHidden = true
                loseMessageAlert()
            }
        }
        else if playerCard5ImageView.isHidden == true {
            playerCard5Index = Int.random(in: 0...51)
            repeat {
                playerCard5Index = Int.random(in: 0...51)
            } while playerCard5Index == bankerCard1Index || playerCard5Index == playerCard1Index || playerCard5Index == bankerCard2Index || playerCard5Index == playerCard2Index || playerCard5Index == playerCard3Index || playerCard5Index == playerCard4Index
            playerCard5ImageView.image = UIImage(named: card[playerCard5Index!])
            playerPoint += cardPoint[playerCard5Index!]
            playerCard5ImageView.isHidden = false
            playerPointLabel.text = "\(playerPoint)"
            if playerPoint > 21 {
                playerPointLabel.textColor = UIColor.red
                bankerCard1ImageView.image = UIImage(named: card[bankerCard1Index!])
                bankerPoint += cardPoint[bankerCard1Index!]
                bankerPointLabel.text = "\(bankerPoint)"
                playerHoleCardButton.isHidden = true
                loseMessageAlert()
            }
        }
    }
    @IBAction func standButtonPressed(_ sender: UIButton) {
        bankerPoint += cardPoint[bankerCard1Index!]
        if bankerPoint <= 16 && bankerCard3ImageView.isHidden == true || bankerPoint <= playerPoint && bankerPoint != 21 && bankerCard3ImageView.isHidden == true {
            bankerCard3Index = Int.random(in: 0...51)
            repeat {
                bankerCard3Index = Int.random(in: 0...51)
            } while bankerCard3Index == bankerCard1Index || bankerCard3Index == playerCard1Index || bankerCard3Index == bankerCard2Index || bankerCard3Index == playerCard2Index || bankerCard3Index == playerCard3Index || bankerCard3Index == playerCard4Index || bankerCard3Index == playerCard5Index
            bankerCard3ImageView.image = UIImage(named: card[bankerCard3Index!])
            bankerPoint += cardPoint[bankerCard3Index!]
            bankerCard3ImageView.isHidden = false
            bankerPointLabel.text = "\(bankerPoint)"
            if bankerPoint <= 16 && bankerCard4ImageView.isHidden == true || bankerPoint <= playerPoint && bankerPoint != 21 && bankerCard4ImageView.isHidden == true {
                bankerCard4Index = Int.random(in: 0...51)
                repeat {
                    bankerCard4Index = Int.random(in: 0...51)
                } while bankerCard4Index == bankerCard1Index || bankerCard4Index == playerCard1Index || bankerCard4Index == bankerCard2Index || bankerCard4Index == playerCard2Index || bankerCard4Index == playerCard3Index || bankerCard4Index == playerCard4Index || bankerCard4Index == playerCard5Index || bankerCard4Index == bankerCard3Index
                bankerCard4ImageView.image = UIImage(named: card[bankerCard4Index!])
                bankerPoint += cardPoint[bankerCard4Index!]
                bankerCard4ImageView.isHidden = false
                bankerPointLabel.text = "\(bankerPoint)"
                if bankerPoint <= 16 && bankerCard5ImageView.isHidden == true || bankerPoint <= playerPoint && bankerPoint != 21 && bankerCard5ImageView.isHidden == true {
                    bankerCard5Index = Int.random(in: 0...51)
                    repeat {
                        bankerCard5Index = Int.random(in: 0...51)
                    } while bankerCard5Index == bankerCard1Index || bankerCard5Index == playerCard1Index || bankerCard5Index == bankerCard2Index || bankerCard5Index == playerCard2Index || bankerCard5Index == playerCard3Index || bankerCard5Index == playerCard4Index || bankerCard5Index == playerCard5Index || bankerCard5Index == bankerCard3Index || bankerCard5Index == bankerCard4Index
                    bankerCard5ImageView.image = UIImage(named: card[bankerCard5Index!])
                    bankerPoint += cardPoint[bankerCard5Index!]
                    bankerCard5ImageView.isHidden = false
                    bankerPointLabel.text = "\(bankerPoint)"
                    if bankerPoint > playerPoint, bankerPoint <= 21 || bankerPoint <= 21, playerCard3ImageView.isHidden == true || bankerPoint <= 21, playerCard4ImageView.isHidden == true,  bankerPoint <= 21, playerCard5ImageView.isHidden == true {
                        bankerCard1ImageView.image = UIImage(named: card[bankerCard1Index!])
                        bankerPointLabel.text = "\(bankerPoint)"
                        playerHoleCardButton.isHidden = true
                        loseMessageAlert()
                    }
                    else if bankerPoint == 21 && playerPoint == 21 {
                        bankerCard1ImageView.image = UIImage(named: card[bankerCard1Index!])
                        bankerPointLabel.text = "\(bankerPoint)"
                        playerHoleCardButton.isHidden = true
                        tieMessageAlert()
                    }
                    else {
                        bankerCard1ImageView.image = UIImage(named: card[bankerCard1Index!])
                        bankerPointLabel.text = "\(bankerPoint)"
                        bankerPointLabel.textColor = UIColor.red
                        playerHoleCardButton.isHidden = true
                        winMessageAlert()
                    }
                }
                else if bankerPoint > playerPoint, bankerPoint <= 21 {
                    bankerCard1ImageView.image = UIImage(named: card[bankerCard1Index!])
                    bankerPointLabel.text = "\(bankerPoint)"
                    playerHoleCardButton.isHidden = true
                    loseMessageAlert()
                }
                else if bankerPoint == 21 && playerPoint == 21 {
                    bankerCard1ImageView.image = UIImage(named: card[bankerCard1Index!])
                    bankerPointLabel.text = "\(bankerPoint)"
                    playerHoleCardButton.isHidden = true
                    tieMessageAlert()
                }
                else {
                    bankerCard1ImageView.image = UIImage(named: card[bankerCard1Index!])
                    bankerPointLabel.text = "\(bankerPoint)"
                    bankerPointLabel.textColor = UIColor.red
                    playerHoleCardButton.isHidden = true
                    winMessageAlert()
                }
                    
            }
            else if bankerPoint > playerPoint, bankerPoint <= 21 {
                bankerCard1ImageView.image = UIImage(named: card[bankerCard1Index!])
                bankerPointLabel.text = "\(bankerPoint)"
                playerHoleCardButton.isHidden = true
                loseMessageAlert()
            }
            else if bankerPoint == 21 && playerPoint == 21 {
                bankerCard1ImageView.image = UIImage(named: card[bankerCard1Index!])
                bankerPointLabel.text = "\(bankerPoint)"
                playerHoleCardButton.isHidden = true
                tieMessageAlert()
            }
            else {
                bankerCard1ImageView.image = UIImage(named: card[bankerCard1Index!])
                bankerPointLabel.text = "\(bankerPoint)"
                bankerPointLabel.textColor = UIColor.red
                playerHoleCardButton.isHidden = true
                winMessageAlert()
            }
        }
        else if bankerPoint > 16, bankerPoint > playerPoint {
            bankerCard1ImageView.image = UIImage(named: card[bankerCard1Index!])
            bankerPointLabel.text = "\(bankerPoint)"
            playerHoleCardButton.isHidden = true
            loseMessageAlert()
        }
    }
    
    @IBAction func holeCardButtonPressed(_ sender: UIButton) {
        
        sender.setImage(playerCard1ImageView.image, for: .highlighted)
        
        
        
    }
    
    
    
    
    
    

}

