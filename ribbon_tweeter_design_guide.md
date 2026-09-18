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

#### **Fysische Verklaring (Waarom $0.01\text{ mm}$ de Enige Goede Keuze is voor High SPL):**
De kracht die het lint in beweging brengt is de Lorentzkracht: $F = B \times I \times L$.
De versnelling van het lint (en dus de geluidsdruk/SPL die gegenereerd wordt) volgt de wet van Newton:

$$a = \frac{F}{m}$$

Als je $0.1\text{ mm}$ folie of Kapton-backing gebruikt, wordt de massa $m$ gigantisch veel groter. Dit betekent dat bij dezelfde versterkerstroom de versnelling $a$ drastisch daalt.

* **Conclusie:** Gebruik **de dunne $0.01\text{ mm}$ (10 micron) huishoudfolie** zonder Kapton backing over de actieve lengte! Gebruik Kapton tape alleen lokaal op de klemeinden voor extra treksterkte.

---

### 3.2 Middenklem bij een Lang Lint (12-13 cm) [Optie C-Middenklem]
Wanneer je 1 lang lint van 12-13 cm gebruikt en dit in het midden ondersteunt/vastklemt (dual segment):
* **Voordelen:** Geen doorhangen/wapperen, betere resonantiecontrole en behoud van Line Array 'high throw'.

---

### 3.3 Breed vs. Smal Lint & Lang vs. Kort Lint
* **Breedte:** $10\text{ mm}$ is de optimale balans tussen spleetbreedte/veldsterkte $B$ en oppervlak.
* **Lengte:** $120\text{ mm}$ met middenklem geeft een uitstekende Line Array afstraling.

---

### 3.4 Corrugatie: Vormen, Maten, Dieptes en Hoeveelheden (Voor- en Nadelen)

De corrugatie (het plooien/golfplaten van het lint) is cruciaal voor de mechanische stijfheid, de resonantiefrequentie, de slaglengte (excursie) en het voorkomen van vervorming bij hoge geluidsdruk (PA-gebruik).

#### **1. Soorten Corrugatievormen (Voor- en Nadelen)**

| Vorm / Type | Beschrijving | Voordelen | Nadelen | Geschiktheid PA High-SPL |
| :--- | :--- | :--- | :--- | :--- |
| **Fijne Dwars-corrugatie** *(Steek 0.8 - 1.2 mm)* | Rechte golfjes dwars op de lengterichting, dicht op elkaar. | • Uitstekende elasticiteit & excursie.<br>• Minimale mechanische resonantie-pieken.<br>• Hoge HF-extensie (>20 kHz). | • Kwetsbaar bij assemblage.<br>• Lint kan zijdelings licht doorbuigen bij 12 cm lengte. | **Uitstekend (Aanbevolen met middenklem)** |
| **Grove Dwars-corrugatie** *(Steek 2.0 - 3.5 mm)* | Grote, brede golfslagen met veel afstand ertussen. | • Eenvoudig handmatig te maken met standaard tandwielen. | • Stijver in HF-bereik (verhoogt de vervorming).<br>• Lagere mechanische max. excursie voor het permanent rekt. | **Matig** |
| **Diagonale / Visgraat (Chevron) Corrugatie** | Golfjes onder een hoek van $30^\circ - 45^\circ$ of in een V-patroon. | • Vliegtuigstijfheid in de breedte: voorkomt torsie en zijdelings 'schuren' tegen magneten.<br>• Zeer strakke lineaire beweging. | • Vereist speciaal 3D-geprint schuin tandwielpaar.<br>• Iets meer effectieve lengte/massa. | **Uitstekend (Beste voor lange linten van 12 cm)** |
| **Vlak / Ongecorrugeerd Lint** | Volledig glad aluminiumfolie. | • Geen corrugator nodig.<br>• Laagste massa per lengte-eenheid. | • **Rampzalig voor High-SPL:** Vervormt/rekt direct permanent bij hitte/excursie.<br>• Heeft hevig storende resonanties. | **Absoluut Ongeschikt** |

#### **2. Vorm van de Rimpel: Afgerond (Sinus) vs. Scherp Gefouwen (Scherpe Hoeken)**

| Profiel | Eigenschappen | Fysisch Effect op het Lint | Oordeel |
| :--- | :--- | :--- | :--- |
| **Afgerond (Sinusgolf)** | Vloeiende, ronde golven (gemaakt met ronde tandwiel-tanden). | • Spanningen worden gelijkmatig verdeeld over de curve.<br>• Voorkomt mechanische concentratiepunten.<br>• **Geen metaalmoeheid:** Het aluminium blijft flexibel en scheurt niet in. | **Verplicht / Beste Keuze** |
| **Scherp Gefold (V-hoeken / Scherpe vouwen)** | Scherpe vouwen met scherpe knikken in de hoeken. | • **Spanningsconcentratie op de vouwlijn:** De hoekjes werken als breeklijnen.<br>• Bij trillingen (high SPL) beweegt het metaal uitsluitend op de vouwlijn $\rightarrow$ **Snelle metaalmoeheid en inscheuring.**<br>• Veroorzaakt merkbare harmonische mechanische pieken/vervorming. | **Afrader / Ongeconditioneerd Slecht** |

#### **3. Corrugatiediepte / Amplitude (Voor- en Nadelen)**
* **Ondiepe Corrugatie (0.2 – 0.3 mm diepte):**
  * *Voordeel:* Minimale lengte-toename van de folie, dus laagste weerstand en hoogste efficiëntie.
  * *Nadeel:* Weinig veerweg/excursie. Kan bij hoge SPL snel uitrekken of inscheuren.
* **Middelgrote Corrugatie (0.5 – 0.8 mm diepte) [OPTIMAAL VOOR PA]:**
  * *Voordeel:* **Perfecte balans.** Voldoende mechanische veerweg voor lage vervorming bij $4\text{ kHz}$ wethoudende slagen, zonder overtollige massa.
* **Diepe Corrugatie (> 1.0 mm diepte):**
  * *Voordeel:* Extreem elastisch, kan gigantische uitslag maken.
  * *Nadeel:* Te veel folielengte nodig voor dezelfde $12\text{ cm}$ afstand $\rightarrow$ hogere massa en hogere elektrische weerstand, wat het akoestisch rendement (+SPL) drastisch verlaagt.

#### **3. Hoeveelheid / Dichtheid van Golven (Aantal rimpels)**
* **Aantal rimpels bij $120\text{ mm}$ lengte:**
  * **Fijne corrugatie (1.0 mm steek):** $\approx 100 - 120$ golven. Dit verdeelt de mechanische spanningen uiterst gelijkmatig over de hele lengte en voorkomt staande mechanische golven op het lint.
  * **Minder dan 30 golven:** De mechanische belasting concentreert zich op de uiteinden, waardoor het lint snel op die specifieke punten metaalmoeheid vertoont en breekt.

---

## 4. Klemmen, Isolatie, Elektrische Aansluiting & TPU-Demping

### 4.1 Gebruik van Kapton Tape (10 mm / 11 mm breed)
Kapton (Polyimide) tape is hittebestendig, extreem dun en heeft uitstekende dielektrische isolatie-eigenschappen:
1. **Isolatie van de Magneetpooloppervlakken:** Plak stroken Kapton tape over de binnenste magneetwanden in de $12\text{ mm}$ spleet. Dit voorkomt dat het aluminiumfolie elektrische kortsluiting maakt als het bij extreem hoge SPL zijdelings tegen de magneten tikt.
2. **Thermische & Mechanische Bescherming bij Klemmen:** Gebruik Kapton tape onder en boven het koperen contactvlak om het PETG/ABS frame te beschermen tegen hitte bij het solderen.

### 4.2 Koperen Tape / Folie voor Elektrisch Contact & Solderen
1. **Contactblokken:** Plak zelfklevend koperfolie/kopertape op de bevestigingsvlakken (boven, onder en midden).
2. **Klemverbinding:** Klem het aluminium lint met TPU/PETG klemstrip stevig op het koper.
3. **Solderen:** Soldeer de secundaire getwiste koperdraden van de transformator rechtstreeks op de koperen tape. *Soldeer nooit rechtstreeks op het aluminium lint!*

* **TPU Flexibele Demping:** 3D-geprinte TPU-pakkingen aan de uiteinden (en bij de optionele middenklem) absorberen reflectiegolven en voorkomen dat het aluminium inscheurt.

---

## 5. Waveguide / Hoorn Ontwerp voor PA Outdoor Line Array

* **Horizontale spreiding:** $90^\circ - 110^\circ$.
* **Verticale spreiding:** $10^\circ - 15^\circ$ (cylindrische golf voor lange draagwijdte).
* **SPL-winst door Hoorn:** **+3 dB tot +5 dB**.

---

## 6. Crossover Berekening ($3.7\ \mu\text{F}$ Condensator)

$$f_c = \frac{1}{2 \pi \times Z_p \times C}$$

| Gewenste Kantelfrequentie ($f_c$) | Benodigde Primaire Impedantie ($Z_p$) | Trafo Wikkelverhouding ($a$) voor $Z_s = 0.0185\ \Omega$ |
| :--- | :--- | :--- |
| **$4.0\text{ kHz}$** | **$10.75\ \Omega$** | **$24.1 : 1$** ($N_p = 48$, $N_s = 2$) |
| **$5.0\text{ kHz}$** | **$8.60\ \Omega$** | **$21.5 : 1$** ($N_p = 43$, $N_s = 2$) |

---

## 7. 3D-Print & Assemblage Instructies

1. **Print de Behuizing:** Gebruik **PETG-CF** of **ABS** voor het stijve frame en **TPU** voor de dempingsklemmen.
2. **Plaats Magneten:** Druk de 4x N52 magneten in de uitsparingen.
3. **Corrugeer het Lint:** Gebruik de 3D-geprinte tandwiel-corrugator op het **$0.01\text{ mm}$ huishoudfolie**.
4. **Assemblage:** Klem het lint vast op de koperen tape en TPU klemmen.
