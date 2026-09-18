# Ontwerp- en Bouwhandleiding High-SPL Ribbon Tweeter voor Line Array (PA Outdoor)

Dit document bevat het complete ontwerp, de fysische berekeningen, de materiaalkeuzes en het montageadvies voor een zelfbouw **Ribbon Tweeter (Lint-tweeter)**, ontworpen voor gebruik in een PA Line Array (Mid-Ribbon-Mid configuratie) voor outdoor toepassingen met hoge SPL en minimale vervorming.

---

## 1. Doelstelling & Ontwerpprinciples

### 1.1 Eisen
* **Maximale SPL & Efficiëntie:** Noodzakelijk voor outdoor PA-toepassingen.
* **Inzetbaarheid:** Vanaf 3.5 kHz – 4 kHz strakke en zuivere weergave zonder opbreekverschijnselen of mechanische overbelasting.
* **Verticale Richtwerking (Line Array):** Smalle verticale afstraling, brede horizontale afstraling (cylindrische golf) om het geluid "ver te laten dragen" (high throw).
* **Materialen in huis:**
  * 3D-printers (PETG-CF, ABS, PLA, TPU).
  * 4x N52 Neodymium magneten ($60 \times 10 \times 5\text{ mm}$).
  * Huishoudaluminiumfolie ($10\ \mu\text{m} = 0.01\text{ mm}$) en dikkere folie ($0.1\text{ mm}$).
  * Koperen tape & koperdraad.
  * $3.7\ \mu\text{F}$ Audio condensator.
  * M3/M4 schroeven en moeren.

---

## 2. Magnetisch Motorontwerp & Magneetrangschikking

### 2.1 Bepaling Magneetoriëntatie & Spleetmaten
De $60 \times 10 \times 5\text{ mm}$ N52 magneten zijn gemagnetiseerd door de dikte ($5\text{ mm}$ / $10\text{ mm}$).
* **Spleetbreedte ($W_{gap}$):** $12\text{ mm}$ (geschikt voor een lintbreedte van $10\text{ mm}$ met $1\text{ mm}$ luchtmarge aan beide zijden).
* **Spleetdiepte ($D_{gap}$):** $10\text{ mm}$.

---

## 3. Analyse van Lint-Parameters

### 3.1 Foliedikte & Kapton Backing Vergelijking

#### **A. Kapton Tape Plakken Onder het Aluminium (Backing / Laminaat)**
* **Volledige Kapton Backing over de hele lengte (Niet Aanbevolen voor Pure Ribbon):**
  * *Massa-explosie:* Kapton tape is $25 - 50\ \mu\text{m}$ dik en heeft een dichtheid van $1.42\text{ g/cm}^3$. Een laag Kapton toevoegen onder $10\ \mu\text{m}$ aluminium maakt het lint **4 tot 6 keer zwaarder**!
  * *Impact op SPL & HF:* Door $a = F/m$ daalt de gevoeligheid boven 5 kHz met **8 tot 12 dB**. Het geluid wordt dof en verliest de karakteristieke "openheid" van een ribbon.
  * *Wanneer WEL gebruiken:* **Alleen op de klem-uiteinden (eerste 5-10 mm)** als versteviging tegen inscheuren op het klem- en soldeerpunt.

#### **B. Foliedikte Vergelijking: Ultra-dun ($6-8\ \mu\text{m}$), Huishoudfolie ($10\ \mu\text{m}$) vs. Dikke Folie ($20-100\ \mu\text{m}$)**

| Eigenschap | Ultra-dun ($6 - 8\ \mu\text{m}$) | Huishoudfolie ($10\ \mu\text{m} / 0.01\text{ mm}$) | Dikke Folie ($20 - 100\ \mu\text{m}$) |
| :--- | :--- | :--- | :--- |
| **Massa ($60\text{ mm} \times 10\text{ mm}$)** | $\approx 10-13\text{ mg}$ | **$16.2\text{ mg}$ (Ideaal)** | $32 - 162\text{ mg}$ (2x - 10x zwaarder) |
| **Transiëntrespons & HF (>10 kHz)** | Extreem snel, ultieme weergave. | **Uitstekend:** Haalt gemakkelijk 20-30 kHz. | Slecht: Hoge massa werkt als mechanisch laagdoorlaatfilter. |
| **Rendement (SPL)** | Zeer hoog (+1 tot +2 dB extra) | **Optimaal voor PA High-SPL** | Laag (-6 tot -20 dB verlies per Watt). |
| **Hanteerbaarheid** | Extreem kwetsbaar, scheurt erg snel. | **Goed hanteerbaar met voorzichtigheid.** | Oersterk, maar akoestisch ongeschikt. |

---

### 3.2 Middenklem bij een Lang Lint (12-13 cm) & Analyse van Gewinkelde Segmenten (V-Vorm in Lengterichting)

Wanneer je 1 lang lint van 12-13 cm gebruikt en dit in het midden ondersteunt/vastklemt (dual segment):
* **Voordelen:** Geen doorhangen/wapperen, betere resonantiecontrole en behoud van Line Array 'high throw'.

#### **Akoestische & Fysische Analyse: Segmenten in een V-hoek Plaatsen (Inwaarts vs. Uitwaarts):**

| Orientatie | Beschrijving | Akoestisch & Fysisch Effect | Geschiktheid Line Array PA |
| :--- | :--- | :--- | :--- |
| **Kaarsrecht ($180^\circ$ Vlak)** | Beide segmenten liggen exact in hetzelfde verticale vlak. | • **Perfecte fase-coherentie:** Vormt een ononderbroken cilindrische golffront.<br>• **Maximale Outdoor Throw:** Gebundelde $10^\circ$ verticale afstraling. | **Verplicht / Beste Keuze** |
| **Inwaarts Gewinkeld (Holle V-vorm / Naar elkaar toe)** | Segmenten buigen in het midden naar achteren toe. | • **Fase-uitdoving & Kamfiltering (Comb Filtering):** Geluidsgolven van bovenste en onderste segment kruisen elkaar voor de klem $\rightarrow$ zware pieken en dalen in de frequentierespons.<br>• Verlies van helderheid en definitie. | **Absoluut Ongeschikt** |
| **Uitwaarts Gewinkeld (Bolle V-vorm / Van elkaar af)** | Segmenten buigen in het midden naar voren toe. | • **Opbreken van de Geluidsbundel (Bifurcatie):** Het geluid wordt in twee losse lobben (naar boven en naar beneden) gewaaierd.<br>• **Enorm verlies van reikwijdte (throw):** De energie 'ontsnapt' naar boven en beneden i.p.v. strak naar het publiek. | **Ongeschikt voor Line Array** |

---

### 3.3 Corrugatie: Vormen, Maten, Dieptes en Hoeveelheden

| Vorm / Type | Beschrijving | Voordelen | Nadelen | Geschiktheid PA High-SPL |
| :--- | :--- | :--- | :--- | :--- |
| **Diagonale / Visgraat (Chevron) Corrugatie** | Afgeronde V-vormige golfjes onder een hoek van $30^\circ - 45^\circ$ ($90^\circ - 120^\circ$ tophoek van de V). | • Vliegtuigstijfheid in de breedte: voorkomt torsie en zijdelings 'schuren' tegen magneten.<br>• Zeer strakke lineaire beweging.<br>• Optimale mechanische verdeling van spanningen. | • Vereist speciaal 3D-geprint schuin tandwielpaar met afgeronde tanden. | **Uitstekend (Beste voor lange linten van 12 cm)** |

---

## 4. Waveguide / Hoorn Ontwerp: Gebogen (Exponentiële) Wanden vs. Rechte Wanden & Montage

### 4.1 Geometrisch Verschil: Exponentieel Gebogen vs. Recht (Waarom de hoorn slanker lijkt)

Genoemde perceptie dat de uitlaat slanker lijkt, komt door het **fysische verschil tussen een exponentiële expansie en een rechte (conische) lijn**:

* **Rechte (Conische) Wanden ($45^\circ$ rechte hoek):**
  * Verbreedt direct vanaf de keel bij $z=0$ met een constante hoek.
  * *Middengedeelte ($z = 20\text{ mm}$):* Breedte is al $52\text{ mm}$.
  * *Eindmond ($z = 40\text{ mm}$):* Breedte is $92\text{ mm}$.
* **Exponentieel Gebogen Wanden ($w(z) = w_{throat} \cdot e^{\alpha z}$):**
  * Expandeert nabij de keel heel geleidelijk (om de akoestische drukgolf bij het lint optimaal te belasten) en buigt pas aan het uiteinde snel naar buiten toe.
  * *Middengedeelte ($z = 20\text{ mm}$):* Breedte is slechts $\approx 33\text{ mm}$ (slanker in de taille!).
  * *Eindmond ($z = 40\text{ mm}$):* Breedte is **exact hetzelfde ($92\text{ mm}$)** als de rechte versie!

**Keuze in OpenSCAD (`flare_type` parameter):**
In `ribbon_waveguide.scad` kun je nu simpel instellen:
* `flare_type = "exponential";` (Aanbevolen: Hoogste efficiëntie & minst kleuring).
* `flare_type = "conical";` (Rechte $45^\circ$ wanden).
* `horn_depth = 50.0;` (Diepere hoorn voor nog bredere expansie).

### 4.2 Montage van de Waveguide op het Tweeter-Frame & 3D-Printbaarheid
1. **Montage met Keelflens (Throat Flange):**
   * De waveguide is voorzien van een **keelflens met 6x M3 boutgaten**.
   * Deze flens wordt met M3 bouten en M3 hitte-insmeltmoeren (heat-set inserts) of moeruitsparingen rechtstreeks luchtdicht op de voorzijde van het PETG-CF/ABS tweeter-frame geschroefd.
   * **Afdichting:** Tussen het tweeter-frame en de keelflens van de waveguide komt een $1\text{ mm}$ TPU 3D-geprinte pakking (of dunne schuimrubber strip) om valse luchtlekkage te voorkomen.
2. **100% Support-Free 3D-Printbaar:**
   * **Print-oriëntatie:** Print de waveguide **ondersteboven (throat-down)** vlak op het printbed.
   * De exponentiële wanden verlopen onder een hoek van $\le 45^\circ$, waardoor de hoorn **volledig zonder support-materiaal** strak geprint kan worden in PETG-CF, ABS of PLA!

---

## 5. Master Matrix: Integraal Berekeningsmodel & Optimale Verhoudingen

| Parameter / Onderdeel | Berekende Optimale Waarde | Fysische / Akoestische Onderbouwing & Ratio |
| :--- | :--- | :--- |
| **Magneetconfiguratie** | 2 stuks gestapeld per pool ($10\text{ mm}$ dikte per pool, $60\text{ mm}$ lengte) | Verdubbelt de magnetische veldsterkte $B$ in de spleet van $\approx 0.35\text{ T}$ naar **$\approx 0.65 - 0.70\text{ T}$** (+6 dB SPL winst). |
| **Luchtspleet Breedte ($W_{gap}$)** | **$12.0\text{ mm}$** | Biedt $1.0\text{ mm}$ spleetmarge aan weerszijden van een $10.0\text{ mm}$ lint. Minimale spleetweerstand (reluctantie) met maximale $B$-veldsterkte. |
| **Lint Lengte ($L_{active}$)** | **$120.0\text{ mm}$ (2x $60\text{ mm}$ segmenten)** | $120\text{ mm}$ actieve stralingslengte vormt een perfecte cylindrische golf voor Line Array outdoor throw. Middenklem bij $60\text{ mm}$ voorkomt doorhangen. |
| **Segment Hoek** | **Vlak / $180^\circ$ (Niet gewinkeld)** | Voorkomt kamfiltering en bifurcatie van de geluidsgolf. Noodzakelijk voor maximale worp. |
| **Transformator Wikkelverhouding** | **$17 : 1$** (Primair $N_p = 34$, Secundair $N_s = 2$) | Transformeert $Z_s = 0.037\ \Omega$ volgens $Z_p = a^2 \cdot Z_s = 17^2 \cdot 0.037\ \Omega = 10.7\ \Omega$, wat exact afgestemd is op de $3.7\ \mu\text{F}$ condensator voor $f_c = 4.0\text{ kHz}$. |
