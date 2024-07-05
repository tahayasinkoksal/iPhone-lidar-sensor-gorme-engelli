  <h1>ARKit Destekli Görme Engelliler İçin Navigasyon</h1>
    <p>Bu proje, iPhone kullanarak kapalı alanlarda görme engelli bireylere yardımcı olmak amacıyla geliştirilmiş bir iOS uygulamasıdır. Uygulama, ARKit ve AVFoundation teknolojilerini kullanarak gerçek zamanlı mesafe ölçümleri ve işitsel yönlendirme sağlar, böylece kullanıcıların engellerden kaçınmasına ve güvenli bir şekilde ilerlemesine yardımcı olur.</p>
    <h2>Proje Tanıtım Videosu</h2>
    https://www.youtube.com/embed/EqDOatcB_tU
    <h2>Özellikler</h2>
    <ul>
        <li><strong>Gerçek Zamanlı Mesafe Ölçümü:</strong> Kullanıcının önünde üç noktada (orta, sol ve sağ) sürekli olarak mesafe ölçer.</li>
        <li><strong>Görsel İşaretleyiciler:</strong> Ekran üzerinde sarı renkli görsel işaretleyiciler göstererek kullanıcının yönelimini kolaylaştırır.</li>
        <li><strong>İşitsel Yönlendirme:</strong> Kullanıcıya Türkçe dilinde sesli geri bildirim sağlar:
            <ul>
                <li>"Dur" mesajı, üç noktada da 1.5 metreden daha yakında engel algılandığında.</li>
                <li>"Sola dön" mesajı, orta ve sağ noktalarda 1.5 metreden daha yakın engel algılandığında.</li>
                <li>"Sağa dön" mesajı, orta ve sol noktalarda 1.5 metreden daha yakın engel algılandığında.</li>
                <li>"Düz git" mesajı, üç noktada da 1.5 metreden uzakta engel olmadığında.</li>
            </ul>
        </li>
    </ul>
    <h2>Kurulum</h2>
    <ol>
        <li><strong>Depoyu Klonla:</strong>
              <pre><code>git clone https://github.com/tahayasinkoksal/iPhone-lidar-sensor-gorme-engelli.git
</code></pre>
        </li>
        <li><strong>Xcode'da Aç:</strong>
            <ul>
                <li>Xcode'da `.xcodeproj` veya `.xcworkspace` dosyasını aç.</li>
            </ul>
        </li>
        <li><strong>Derle ve Çalıştır:</strong>
            <ul>
                <li>Cihazını bağla ve çalıştırılacak cihazı seç.</li>
                <li>Projeyi cihazınızda derleyip çalıştırın.</li>
            </ul>
        </li>
    </ol>
    <h2>Kullanım</h2>
    <ol>
        <li><strong>Uygulamayı Başlat:</strong>
            <ul>
                <li>iPhone'unuzda uygulamayı açın.</li>
            </ul>
        </li>
        <li><strong>Telefonu Sabit Tutun:</strong>
            <ul>
                <li>Kamera çevresindeki ortamı algılaması için telefonu sabit ve rahat bir açıyla tutun.</li>
            </ul>
        </li>
        <li><strong>Sesli Geri Bildirimi Dinleyin:</strong>
            <ul>
                <li>Uygulama tarafından sağlanan sesli talimatları dinleyerek güvenli bir şekilde ilerleyin.</li>
            </ul>
        </li>
    </ol>
    <h2>Kod İncelemesi</h2>
    <ul>
        <li><strong>ContentView.swift:</strong> Ana görünümü ve AR görünümünü içerir.</li>
        <li><strong>ARViewContainer.swift:</strong>
            <ul>
                <li>ARSCNView'i yönetir ve yapılandırır.</li>
                <li>Mesafe ölçümlerini sürekli olarak günceller ve görsel işaretleyiciler sağlar.</li>
                <li>ARSCNViewDelegate yöntemlerini işlemek için Coordinator sınıfını içerir ve işitsel geri bildirim sağlar.</li>
            </ul>
        </li>
    </ul>
    <h2>Katkıda Bulunma</h2>
    <p>Katkılarınızı bekliyoruz! Lütfen bir pull isteği gönderin veya herhangi bir değişiklik veya iyileştirme konusunda bir sorun açın.</p>
    <h2>Lisans</h2>
    <p>Bu proje MIT Lisansı altında lisanslanmıştır.</p>
    <h2>Teşekkürler</h2>
    <ul>
        <li><strong>Apple'ın ARKit ve AVFoundation Ekibi:</strong> Bu yenilikçi uygulamayı oluşturmak için sağladıkları araçlar için.</li>
        <li><strong>Topluluk:</strong> Sürekli destek ve katkıları için.</li>
    </ul>
    <h2>İletişim</h2>
    <p>Daha fazla bilgi için lütfen iletişime geçin.</p> 
<b>Mail:</b> yardim.koksalyazilim@gmail.com <br>
<b>Web:</b> www.tahayasinkoksal.com.tr <br>
<b>Linkesin:</b> https://tr.linkedin.com/in/tahayasinkoksal

