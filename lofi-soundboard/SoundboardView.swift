import SwiftUI
import AVKit

class AudioPlayerManager: ObservableObject {
    var player: AVPlayer?
    
    init(soundURL: URL) {
        let playerItem = AVPlayerItem(url: soundURL)
        player = AVPlayer(playerItem: playerItem)
    }
}

struct SoundButton: View {
    let soundURL: URL
    let label: String
    
    @StateObject private var audioPlayerManager: AudioPlayerManager = AudioPlayerManager(soundURL: URL(fileURLWithPath: ""))
    @State private var isPlaying = false
    @State private var volumeLevel: Double = 0.5 // Added state variable to track volume level

    var body: some View {
        
        VStack {
            Button(action: {
                toggleSound()
            }) {
                Text(isPlaying ? "Pause" : "Play")
                    .padding()
                    .foregroundColor(.white)
                    .background(isPlaying ? Color.red : Color.green)
                    .cornerRadius(10)
            }
            Slider(value: $volumeLevel, in: 0...1) // Bind volumeLevel to Slider value
                .padding(.horizontal)
            
        }
        .onAppear {
            audioPlayerManager.player?.replaceCurrentItem(with: AVPlayerItem(url: soundURL))
        }
        .onChange(of: volumeLevel) { newValue in // Update volume when slider value changes
            audioPlayerManager.player?.volume = Float(newValue)
        }
    }
    
    private func toggleSound() {
        if isPlaying {
            audioPlayerManager.player?.pause()
        } else {
            audioPlayerManager.player?.play()
        }
        isPlaying.toggle()
    }
}

struct SoundboardView: View {
    let soundData = [
        (soundURL: Bundle.main.url(forResource: "jazz", withExtension: "mp3")!, label: "Sound 1"),
        (soundURL: Bundle.main.url(forResource: "rain", withExtension: "mp3")!, label: "Sound 2")
        // Add more sound data URLs here
    ]
    
    var body: some View {
        ZStack {
            Color("lofi-orange") // Orange background
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Mellow Mind")
                    .font(.custom("DancingScript-Regular", size: 40)) // Dancing Script font in white
                    .foregroundColor(.white)                    .foregroundColor(.white)
                    .padding()
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 150), spacing: 20)], spacing: 20) {
                        ForEach(soundData, id: \.label) { sound in
                            SoundButton(soundURL: sound.soundURL, label: sound.label)
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

struct SoundboardView_Previews: PreviewProvider {
    static var previews: some View {
        SoundboardView()
    }
}
