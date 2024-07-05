/**
 Gitgub: https://github.com/tahayasinkoksal
 Linkedin: https://tr.linkedin.com/in/tahayasinkoksal
 
 
 */
import SwiftUI
import ARKit
import AVFoundation

struct ContentView: View {
    // State değişkenleri: 3 noktanın uzaklıklarını ve yönlendirme mesajını saklar
    @State private var centerDistance: Double = 0.0
    @State private var leftDistance: Double = 0.0
    @State private var rightDistance: Double = 0.0
    @State private var directionMessage: String = ""
    
    var body: some View {
        VStack {
            // ARViewContainer bileşenini yerleştirir ve uzaklık ile mesaj verilerini bağlar
            ARViewContainer(centerDistance: $centerDistance, leftDistance: $leftDistance, rightDistance: $rightDistance, directionMessage: $directionMessage)
                .edgesIgnoringSafeArea(.all)
            
            // Uzaklıkları ve yönlendirme mesajını gösterir
            Text("Center Distance: \(centerDistance, specifier: "%.2f") meters")
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 3)
            
            Text("Left Distance: \(leftDistance, specifier: "%.2f") meters")
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 3)
            
            Text("Right Distance: \(rightDistance, specifier: "%.2f") meters")
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 3)
            
            Text(directionMessage)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 3)
                .foregroundColor(.red)
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    @Binding var centerDistance: Double
    @Binding var leftDistance: Double
    @Binding var rightDistance: Double
    @Binding var directionMessage: String

    private let speechSynthesizer = AVSpeechSynthesizer()
    
    func makeUIView(context: Context) -> ARSCNView {
        let arView = ARSCNView()
        arView.delegate = context.coordinator
        arView.autoenablesDefaultLighting = true
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        arView.session.run(configuration)

        // Görsel işaretleyiciler ekler
        addVisualMarker(at: CGPoint(x: arView.bounds.midX, y: arView.bounds.midY), to: arView)
        addVisualMarker(at: CGPoint(x: arView.bounds.midX - arView.bounds.width / 3, y: arView.bounds.midY), to: arView)
        addVisualMarker(at: CGPoint(x: arView.bounds.midX + arView.bounds.width / 3, y: arView.bounds.midY), to: arView)

        return arView
    }

    func updateUIView(_ uiView: ARSCNView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func addVisualMarker(at point: CGPoint, to arView: ARSCNView) {
        // Sarı renkli küresel işaretleyiciler oluşturur ve ekler
        let sphere = SCNSphere(radius: 0.01)
        sphere.firstMaterial?.diffuse.contents = UIColor.yellow
        let node = SCNNode(geometry: sphere)
        node.position = SCNVector3Make(Float(point.x), Float(point.y), -0.2) // Kameranın biraz önüne yerleştirir
        arView.scene.rootNode.addChildNode(node)
    }

    class Coordinator: NSObject, ARSCNViewDelegate {
        var parent: ARViewContainer

        init(_ parent: ARViewContainer) {
            self.parent = parent
        }

        func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
            guard let sceneView = renderer as? ARSCNView,
                  let cameraTransform = sceneView.session.currentFrame?.camera.transform else {
                return
            }

            // UI işlemlerini ana iş parçacığında çalıştırır
            DispatchQueue.main.async {
                let centerPoint = CGPoint(x: sceneView.bounds.midX, y: sceneView.bounds.midY)
                let leftPoint = CGPoint(x: sceneView.bounds.midX - sceneView.bounds.width / 3, y: sceneView.bounds.midY)
                let rightPoint = CGPoint(x: sceneView.bounds.midX + sceneView.bounds.width / 3, y: sceneView.bounds.midY)

                // Uzaklıkları hesaplar
                let centerDistance = self.calculateDistance(at: centerPoint, in: sceneView, cameraTransform: cameraTransform)
                let leftDistance = self.calculateDistance(at: leftPoint, in: sceneView, cameraTransform: cameraTransform)
                let rightDistance = self.calculateDistance(at: rightPoint, in: sceneView, cameraTransform: cameraTransform)

                // Uzaklık verilerini günceller
                self.parent.centerDistance = centerDistance
                self.parent.leftDistance = leftDistance
                self.parent.rightDistance = rightDistance
                
                // Yönlendirme mesajını belirler ve sesli olarak söyler
                var newMessage = ""
                if centerDistance < 1.5 && leftDistance < 1.5 && rightDistance < 1.5 {
                    newMessage = "Dur"
                } else if centerDistance < 1.5 && rightDistance < 1.5 {
                    newMessage = "Sola dön"
                } else if centerDistance < 1.5 && leftDistance < 1.5 {
                    newMessage = "Sağa dön"
                } else {
                    newMessage = "Düz git"
                }
                
                if newMessage != self.parent.directionMessage {
                    self.parent.directionMessage = newMessage
                    self.speak(newMessage)
                }
            }
        }

        // Verilen noktadaki uzaklığı hesaplar
        private func calculateDistance(at point: CGPoint, in sceneView: ARSCNView, cameraTransform: matrix_float4x4) -> Double {
            let hitTestResults = sceneView.hitTest(point, types: .featurePoint)
            if let result = hitTestResults.first {
                let cameraPosition = cameraTransform.columns.3
                let cameraPosition3 = simd_make_float3(cameraPosition.x, cameraPosition.y, cameraPosition.z)
                let featurePoint = result.worldTransform.columns.3
                let featurePoint3 = simd_make_float3(featurePoint.x, featurePoint.y, featurePoint.z)
                let distance = simd_distance(cameraPosition3, featurePoint3)
                return Double(distance)
            }
            return Double.infinity
        }

        // Mesajı sesli olarak söyler
        private func speak(_ message: String) {
            let utterance = AVSpeechUtterance(string: message)
            utterance.voice = AVSpeechSynthesisVoice(language: "tr-TR")
            self.parent.speechSynthesizer.speak(utterance)
        }
    }
}
