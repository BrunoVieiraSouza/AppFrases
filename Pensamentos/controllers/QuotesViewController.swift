//
//  QuotesViewController.swift
//  Pensamentos
//
//  Created by Bruno Vieira Souza on 13/10/21.
//

// nesse app usamos tambem o Setting.bundle = que e usado para usuario fazer ajustes no app pelas configuracoes do celular...
/* nisso criamos um file do tipo Setting Bundles e la decidimos o que o usuario podera escolher
 nisso indentificamos os nosso UserDefaults pelas variaveis criadas get e set atraves dos nomes (autorefresh, timerInterval, colorScheme) posso ver esses arquivos no arquivo Root.plist
 
 
 */




import UIKit

class QuotesViewController: UIViewController {
    
    
// aqui criamos nossas labels
    @IBOutlet weak var ivPhoto: UIImageView!
    @IBOutlet weak var ivPhotobg: UIImageView!
    @IBOutlet weak var lbQuote: UILabel!
    @IBOutlet weak var lbAutor: UILabel!
    @IBOutlet weak var ctTop: NSLayoutConstraint!
    
    
    // aqui crio uma referencia da minha classe Configuration ja estanciada
    let config = Configuration.shared
    
    // aqui crio uma referencia da minha classe QuotesManager, para termos acesso aos metodos e propriedades da classe
    let quotesManager = QuotesManager()
    
    // aqui criamos uma referencia para termos acesso a classe Timer, que sera usado para cronometrar o tempo que a frase ficara na tela
    var timer: Timer?

    
    //aqui temos nossa ViewDidLoad quando a tela aparecera pela primeira vez
    override func viewDidLoad() {
        super.viewDidLoad()
        // medodo NotificationCenter para toda vez que o usuario mudar as configuracoes la no Settins do meu iphone ele despara esse metodo.. que estara observando (addObserver)
        NotificationCenter.default.addObserver(forName: NSNotification.Name("Refresh"), object: nil, queue: nil) { notification in
            self.formatView() // aqui chamo meu metodo formatView para formatar novamente
        }
    }
    
    // minha tela ira aparecer
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        formatView() // chamo o metodo formatView toda vez que minha tela ira aparecer novamente.
    }
    
    func formatView() { // metodo para formatar a view
        // aqui estou falando que o background da minha view é igual ao COLORScheme(esquema de cores do meu UserDefault) e se ele for igual a 0, ele vai trazer o backGround branco caso for diferente de 0 ele trara uma UIColor com minhas cores selecionadas e alpha 1
        view.backgroundColor = config.colorScheme == 0 ? .white : UIColor(displayP3Red: 156.0/255.0, green: 68.0/255.0, blue: 15.0/255.0, alpha: 1.0)
        
        // aqui eu falo que a cor da minha label é igual a ColorScheme(esquema de cores do meu UserDefault) e se for 0 recebera black caso contratrio branco
        lbQuote.textColor = config.colorScheme == 0 ? .black : .white
        
        // aqui falo da cor do texto da minha label do autor que recebe a colorScheme do meu UserDefault
        lbAutor.textColor = config.colorScheme == 0 ? UIColor(displayP3Red: 192/255.0, green: 96.0/255.0, blue: 49.0/255.0, alpha: 1.0) : .yellow
        
        
        // e aqui depois de formatar minha View de acordo com o ESQUEMA DE CORES eu chamo metodo "prepareQuote()" que ira executalo
        prepareQuote()
    }
    
    
    
    //aqui eu crio um metodo de toucheBegan caso o usuario clique na tela, ela dispara o metodo "prepareQuote()"
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        prepareQuote()
    }
    
    
    // metodo para preparar minha Quote(frase, autor e imagem)
    func prepareQuote() {
        // aqui eu chamo minha classe timer.invalidate esse metodo invalida o timer e zera a contagem, para nao ter conflito com os outros metodos
        timer?.invalidate()
        
        // Se meu autoRefresh da minha classe Configurater estiver com o valor TRUE...ele executara o codigo abaixo
        if config.autorefresh { // autorefresh esta buscando do meu UserDefault
            
            // aqui eu chamo meu metodo timer(variavel criada herndando a classe Timer)
            // e rececbe Timer.scheduledtimer que e um metodo para contar um intervalo de tempo que me pede um valor Double, onde eu recupero ele do meu UserDefaults  timeInterval.
            //e coloco true como repetir
            //ele pede outro parametro de Clouser e coloco self.showRandomQuote ()
            timer = Timer.scheduledTimer(withTimeInterval: config.timeInterval, repeats: true) { timer in
                self.showRandomQuote() // aqui chamo meu metodo para mostrar meu objeto de FRASE,AUTOR e IMAGE aleatorio
            }
            
        }
        showRandomQuote() // chamo novamente caso nao caia no IF

    }
    
    
    // esse eh o metodo para alimentar minhas labes com as frases aleatoria e ja implantar as animacoes
    func showRandomQuote () {
        
        // aqui eu crio uma variavel para receber uma Quote aleatoria atraves do metodo getRandomQuote que esta implantando na classe QuotesManager
        let quote = quotesManager.getRandomQuote()
        
        //na label da frase. Eu recebo minha frase do meu Json, que for sorteado pelo metodo getRandomQuote
        lbQuote.text = quote.quote
        
        // a mesma logica de cima, porem com o author
        lbAutor.text = quote.author
        
        ivPhoto.image = UIImage(named: quote.image)
        ivPhotobg.image = ivPhoto.image
        
        
        // aqui eu crio um alpha zerado para minhas labels para fazer a animacao...pelo metodo criado abaixo animated
        lbQuote.alpha = 0.0
        lbAutor.alpha = 0.0
        ivPhoto.alpha = 0.0
        ivPhotobg.alpha = 0.0
        ctTop.constant = 50
        
        //tenho que chamar esse metodo obrigatoriamente para fazer animacoes com Contraints
        view.layoutIfNeeded()
        
        //Chamo minha UIVIEW.=Animated e istancio ela com o parametro withDuration onde eu coloca um Double. e ela espera uma clouser qie eu chamo atraves do self.label.alpha = 1.. nisso trazendo minha opacidade da label de 0 ate 1 em 2,5 segundos
        UIView.animate(withDuration: 2.5) {
            self.lbQuote.alpha = 1.0
            self.lbAutor.alpha = 1.0
            self.ivPhoto.alpha = 1.0
            self.ivPhotobg.alpha = 0.25
            self.ctTop.constant = 10
            self.view.layoutIfNeeded()
        }
    }
    
}
