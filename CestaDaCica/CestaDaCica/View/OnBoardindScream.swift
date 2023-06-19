//
//  OnBoardindScream.swift
//  CestaDaCica
//
//  Created by Grazi  Berti on 19/06/23.
//

import SwiftUI

struct OnBoardindScream: View {
    //MARK: - OnBoarding Slides Model Data
    @State var onboardingItems: [OnBoardingItem] = [
        .init(title: "Tela 1", subtitle: "Este é um aplicativo dedicado a criar e enviar cestas personalizadas para todas as ocasiões especiais.", lottieView: .init(name: "One", bundle: .main)),
        .init(title: "Tela 1", subtitle: "Nossa plataforma permite aos usuários escolher entre uma ampla variedade de produtos cuidadosamente selecionados, criando cestas únicas e personalizadas para presentear amigos, familiares ou colegas.", lottieView: .init(name: "One", bundle: .main)),
        .init(title: "Tela 1", subtitle: "Com recursos intuitivos de personalização e um processo de compra simplificado, oferecemos uma experiência inigualável para expressar afeto e gratidão através de cestas cuidadosamente montadas.", lottieView: .init(name: "One", bundle: .main))
    ]
    
    var body: some View {
        Text("OnBoardindScream")
    }
}

struct OnBoardindScream_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardindScream()
    }
}
