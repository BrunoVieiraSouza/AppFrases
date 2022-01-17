//
//  SettingsViewController.swift
//  Pensamentos
//
//  Created by Bruno Vieira Souza on 13/10/21.
//

import UIKit

class SettingsViewController: UIViewController {
    
    
    //aqui criei minhas labels da tela
    @IBOutlet weak var swAutoReresh: UISwitch!
    @IBOutlet weak var slTimerInterval: UISlider!
    @IBOutlet weak var scColorScheme: UISegmentedControl!
    @IBOutlet weak var lbTimeInterval: UILabel!
    
    
    // aqui faco minha referencia da classe Configuration ja instanciada
    let config = Configuration.shared
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // medodo NotificationCenter para toda vez que o usuario mudar as configuracoes la no Settins do meu iphone ele despara esse metodo.. que estara observando (addObserver)
        NotificationCenter.default.addObserver(forName: NSNotification.Name("Refresh"), object: nil, queue: nil) { notification in
            self.formatView()
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        formatView() // chamo o metodo formatView toda vez que minha tela ira aparecer novamente.
        
    }
    
    
    // aqui eh um metodo para setar meus valores no UserDefault
    func formatView() {
        
        //aqui estou setando meu valor do Swith quando On para minha autorefresh (que esta armazenando no UserDefault)
        swAutoReresh.setOn(config.autorefresh, animated: false)
        
        //aqui estou setando meu valor do slider para o timeInterval da minha clase Configuration
        slTimerInterval.setValue(Float(config.timeInterval), animated: false)
        
        // aqui setamos o valor do segmente para minha colorScheme da minha clase Configuration que esta salvando no meu UserDefault
        scColorScheme.selectedSegmentIndex = config.colorScheme
        
    }
    
    
    
    //funcao para mudar minha label do Timer Slider e colocar o valor selecionada no texto do titulo
    func changeTimeIntervalLabel(with value: Double) {
        lbTimeInterval.text = " Mudar após \(value) segundos "
    }
    
    
    
    // Action do meu Swith... INFORMANDO QUE QUANDO O USUARIO HABILITAR ELE PARA ON - EU SALVAR COMO ON NO MEU AUTOREFRESH
    @IBAction func changeAutoRefresh(_ sender: UISwitch) {
        config.autorefresh = sender.isOn
    }
    
    
    // minha acao quando o usuario escolher um valor no slider. ele ira salvar na variavel "value" o valor escolhido em Double. i
    @IBAction func changeTimeInverval(_ sender: UISlider) {
        
        //criando a variavel sender.value e ele me retorna um Float e ja converto ele para Double
        let value = Double(round(sender.value))
        
        //aqui chamo o metodo acima para setar o valor escolhido pelo usuario para aparecer no titulo
        changeTimeIntervalLabel(with: value)
        
        // e aqui eu chamo meu timeInterval da classe Configuration e seto o valor da minha variavel acima que esta recebendo o valor escolhido pelo usuario
        config.timeInterval = value
    }
    
    
    // aqui eh a acao do meu SegmentedControl que eh se o usuario prefere escuro ou claro.
    @IBAction func changeColorScheme(_ sender: UISegmentedControl) {
        
        //eu falo que o coloSheme da minha classe Configuration recebera o sender.selectSegmentIndex que sera o index do segmento que ele escolheu 0 ou 1
        config.colorScheme = sender.selectedSegmentIndex
    }
    
}
