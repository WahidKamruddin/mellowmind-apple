import SwiftUI

struct ContentView: View {
    @State private var showSoundboard = false // State to control whether to show the soundboard

    var body: some View {
        if showSoundboard {
            SoundboardView()
        } else {
            ZStack {
                Color("lofi-orange") // Orange background
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text("Mellow Mind")
                        .font(.custom("DancingScript-Regular", size: 50)) // Dancing Script font in white
                        .foregroundColor(.white)
                        .padding()
                    
                    Button(action: {
                        self.showSoundboard.toggle() // Toggle the state to show the soundboard
                    }) {
                        Text("->")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(30)
                    }
                    .padding()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
