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
        .init(title: "Tela 1", subtitle: "Este é um aplicativo dedicado a criar e enviar cestas personalizadas para todas as ocasiões especiais.", lottieView: .init(name: "one", bundle: .main)),
        .init(title: "Tela 2", subtitle: "Nossa plataforma permite aos usuários escolher entre uma ampla variedade de produtos cuidadosamente selecionados, criando cestas únicas e personalizadas para presentear amigos, familiares ou colegas.", lottieView: .init(name: "two", bundle: .main)),
        .init(title: "Tela 3", subtitle: "Com recursos intuitivos de personalização e um processo de compra simplificado, oferecemos uma experiência inigualável para expressar afeto e gratidão através de cestas cuidadosamente montadas.", lottieView: .init(name: "three", bundle: .main))
    ]
    //MARK: - Current Slide Index
    @State var currentIndex: Int = 0
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            HStack(spacing: 0) {
                ForEach($onboardingItems) { $item in
                    let isLastSlide = (currentIndex == onboardingItems.count - 1)
                    VStack(spacing: 20) {
                        //MARK: - Top Nav Bar
                        HStack {
                            Button("Back") {
                                if currentIndex > 0 {
                                    currentIndex -= 1
                                    playAnimation()
                                }
                            }
                            .opacity(currentIndex > 0 ? 1 : 0)
                            Spacer(minLength: 0)
                            Button("Skip") {
                                currentIndex = onboardingItems.count - 1
                                playAnimation()
                            }
                            .opacity(isLastSlide ? 0 : 1)
                        }
                        .tint(Color("DarkVinho"))
                        .font(.system(size: 18, weight: .bold))
                        
                        //MARK: - Movable Slides
                        VStack(spacing: 15) {
                            let offset = -CGFloat(currentIndex) * size.width
                            //MARK: - Resizable Lottie View
                            ResizableLottieView(onboardingItem: $item)
                                .frame(width: size.width)
                                .onAppear {
                                    // MARK: - Intially Playing Firts Slide Animation
                                    if currentIndex == indexOf(item) {
                                        item.lottieView.play()
                                    }
                                }
                                .offset(x: offset)
                                .animation(.easeInOut(duration: 0.2), value: currentIndex)
                            
                            Text(item.title)
                                .font(.title.bold())
                                .offset(x: offset)
                                .animation(.easeInOut(duration: 0.5).delay(0.1), value: currentIndex)
                            
                            Text(item.subtitle)
                                .font(.system(size: 14))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 15)
                                .foregroundColor(.gray)
                                .offset(x: offset)
                                .animation(.easeInOut(duration: 0.5).delay(0.2), value: currentIndex)
                        }
                        
                        Spacer(minLength: 0)
                        
                        //MARK: - Next / Login View
                        VStack(spacing: 15) {
                            let isLastSlide = (currentIndex == onboardingItems.count - 1)
                            Text(isLastSlide ? "Login" : "Next")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.vertical, isLastSlide ? 13 : 12)
                                .frame(maxWidth: .infinity)
                                .background {
                                    Capsule()
                                        .fill(Color("DarkVinho"))
                                }
                                .animation(.easeInOut, value: isLastSlide)
                                .padding(.horizontal, isLastSlide ? 30 : 100)
                                .onTapGesture {
                                    //MARK: - Updating to Next Index
                                    if currentIndex < onboardingItems.count - 1 {
                                        //MARK: - Pausing Previous Animation
                                        let currentProgress = onboardingItems[currentIndex].lottieView.currentProgress
                                        onboardingItems[currentIndex].lottieView.currentProgress = (currentProgress == 0 ? 0.7 : currentProgress)
                                        onboardingItems[currentIndex].lottieView.pause()
                                        currentIndex += 1
                                        //MARK: - Playing Next Animation from Start
                                        playAnimation()
                                    }
                                }
                        }
                    }
                    .padding(15)
                    .frame(width: size.width, height: size.height)
                }
            }
            .frame(width: size.width * CGFloat(onboardingItems.count), alignment: .leading)
        }
    }
    
    func playAnimation() {
        onboardingItems[currentIndex].lottieView.currentProgress = 0
        onboardingItems[currentIndex].lottieView.play(toProgress: 0.7)
    }
    
    //MARK: - Retreving Index of the Item in the Array
    /// retorna o índice de um determinado item dentro de um array
    func indexOf(_ item: OnBoardingItem) -> Int {
        if let index = onboardingItems.firstIndex(of: item) {
            return index
        }
        return 0
    }
}

struct OnBoardindScream_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardindScream()
    }
}

struct ResizableLottieView: UIViewRepresentable {
    @Binding var onboardingItem: OnBoardingItem
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        setupLottieView(view)
        return view
    }
    func updateUIView(_ uiView: UIView, context: Context) {
        //
    }
    
    func setupLottieView(_ to: UIView) {
        let lottieView = onboardingItem.lottieView
        lottieView.backgroundColor = .clear
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: - Applying Constrains
        let constrains = [
            lottieView.widthAnchor.constraint(equalTo: to.widthAnchor),
            lottieView.heightAnchor.constraint(equalTo: to.heightAnchor)
        ]
        to.addSubview(lottieView)
        to.addConstraints(constrains)
    }
    
}
