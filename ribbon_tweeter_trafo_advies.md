# Ontwerp en Advies Zelfbouw Ribbon Tweeter Transformator

Dit document bevat de volledige berekeningen, materiaalanalyse en praktische wikkelinstructies voor het bouwen van een audiotransformator ten behoeve van een lint-tweeter (ribbon tweeter) met een gewenste primaire impedantie van **4 Ohm** in het frequentiebereik van **4 kHz tot 25 kHz**.

---

## 1. Parameters & Berekeningen

### 1.1 Specificaties van het Lint (Aluminium Folie)
* **Lengte ($L$):** $70\text{ mm} = 0.07\text{ m}$
* **Breedte ($W$):** $10\text{ mm} = 0.01\text{ m}$
* **Dikte ($T$):** $0.01\text{ mm} = 1 \times 10^{-5}\text{ m}$
* **Soortelijke weerstand Aluminium ($\rho$):** $\approx 2.65 \times 10^{-8}\ \Omega\cdot\text{m}$ (bij kamertemperatuur)

$$\text{Doorsnede } A = W \times T = 0.01\text{ m} \times 0.00001\text{ m} = 1.0 \times 10^{-7}\text{ m}^2$$

$$\text{Gelijkstroomweerstand } R_{dc} = \rho \frac{L}{A} = 2.65 \times 10^{-8} \times \frac{0.07}{1.0 \times 10^{-7}} \approx 0.01855\ \Omega \ (18.55\text{ m}\Omega)$$

### 1.2 Transformatieverhouding & Impedantie
* **Opgegeven wikkelverhouding ($a = N_p / N_s$):** $14.671 : 1$
* **Impedantieverhouding ($Z_p / Z_s$):** $a^2 = (14.671)^2 \approx 215.24 : 1$

Als de totale secundaire belastingsweerstand $Z_s \approx 0.01855\ \Omega$ is (inclusief aansluitweerstand van het lint), reflecteert dit naar de primaire zijde als:

$$Z_p = a^2 \times Z_s = 215.24 \times 0.01855\ \Omega \approx 3.99\ \Omega \approx 4\ \Omega$$

*De verhouding 14.671 : 1 klopt dus exact om het lint om te vormen naar 4 Ohm!*

---

## 2. Kernkeuze: Ferriet FT240-43 vs. Opgerolde Metaalband Toroid (Tape Core)

### Advies: Kies de Ferriet FT240-43 Kern!

| Eigenschap | Ferriet FT240-43 | Opgerolde Metaalband Toroid (SiFe / Nanokristallijn) |
| :--- | :--- | :--- |
| **Materiaal** | NiZn-ferriet (Fair-Rite 43) | Geknikte/opgerolde ijzer-silicium of transformatorbliksstrip |
| **Frequentiebereik** | Uitstekend voor hoge frequenties (Audio t/m MHz) | Gevoelig voor wervelstromen (eddy currents) bij HF (> 10-15 kHz) |
| **Magnetische Permeabiliteit ($\mu_i$)** | $\mu_i \approx 850$ ($A_L \approx 1075\text{ nH/N}^2$) | Zeer hoog bij LF ($\mu_i > 2000-5000$), maar sterke verliezen boven 10 kHz |
| **Vervorming & Verliezen bij 25 kHz** | Extreem lage kernverliezen en hysteresisvervorming | Hoge wervelstroomverliezen; dempt de hoge tonen boven 15-20 kHz |

**Conclusie:**
De opgerolde metalen toroid is waarschijnlijk ontworpen voor 50Hz/60Hz lichtnet- of LF-toepassingen. Bij frequenties van **4 kHz tot 25 kHz** zorgt het ferriet materiaal van de **FT240-43** voor minimale hysteresisverliezen en verwaarloosbare wervelstroomverliezen. De FT240-43 is veruit de beste keuze voor audioweergave in het hoge frequentiegebied.

---

## 3. Aantal Windingen ($N_s$ en $N_p$)

Om de transformator correct te laten functioneren bij de kantelfrequentie van **4 kHz**, moet de primaire inductie $L_p$ voldoende hoog zijn. De primaire inductieve reaktantie $X_L = 2\pi f L_p$ moet bij 4 kHz minstens 2 tot 3 keer groter zijn dan de nominale impedantie van $4\ \Omega$ ($X_L \ge 8\ \Omega$ tot $12\ \Omega$).

### 3.1 Berekening voor FT240-43 ($A_L \approx 1075\text{ nH/N}^2 = 1.075\ \mu\text{H/N}^2$)

1. **Bij 1 secundaire winding ($N_s = 1$):**
   * $N_p = 1 \times 14.671 \approx 15\text{ windingen}$.
   * $L_p = A_L \times N_p^2 = 1.075\ \mu\text{H} \times 15^2 = 241.8\ \mu\text{H} = 0.242\text{ mH}$.
   * Primaire reaktantie bij 4 kHz: $X_L = 2\pi \times 4000 \times 0.0002418 \approx 6.07\ \Omega$.
   * *Beoordeling:* Iets te laag voor 4 kHz ($6.07\ \Omega$ is niet veel groter dan $4\ \Omega$), wat kan leiden tot een lichte afval in het laag-midden en hogere vervorming rond 4 kHz.

2. **Bij 2 secundaire windingen ($N_s = 2$) (AANBEVOLEN):**
   * $N_p = 2 \times 14.671 = 29.34 \rightarrow \mathbf{29\text{ windingen}}$.
   * Exacte verhouding: $29 / 2 = 14.5 : 1$ (geeft $Z_p \approx 3.90\ \Omega$, wat perfect is).
   * $L_p = 1.075\ \mu\text{H} \times 29^2 = 904\ \mu\text{H} = 0.904\text{ mH}$.
   * Primaire reaktantie bij 4 kHz: $X_L = 2\pi \times 4000 \times 0.000904 \approx 22.7\ \Omega$.
   * *Beoordeling:* Uitstekend! $22.7\ \Omega \gg 4\ \Omega$. Dit garandeert een kaarsrechte frequentiekarakteristiek vanaf 4 kHz zonder vervorming of faseverschuiving.

---

## 4. Draadkeuze, Skin-Effect & Wikkeltips

### 4.1 Skin-effect (Huid-effect) Analyse bij 25 kHz
De indringdiepte ($\delta$) van wisselstroom in koper bij $f = 25\text{ kHz}$ bedraagt:

$$\delta = \frac{66}{\sqrt{f}} = \frac{66}{\sqrt{25000}} \approx 0.418\text{ mm}$$

* **Primaire draad ($0.5\text{ mm}$ geëmailleerd koper):**
  * Straal $r = 0.25\text{ mm}$. Omdat $r < \delta$ ($0.25\text{ mm} < 0.418\text{ mm}$), dringt de stroom volledig door de gehele geleider. **0.5 mm is een perfecte keuze voor de primaire wikkeling.**

* **Secundaire draad ($1.5\text{ mm}$ vs $2.5\text{ mm}$):**
  * Bij hele hoge stromen in de secundaire wikkeling is een lage weerstand essentieel.
  * Omdat de diameter groter is dan $2 \times \delta$ ($0.836\text{ mm}$), ontstaat er bij een enkele dikke draad wervelstroomverlies (skin-effect).
  * **Oplossing / Advies:** Wikkel de secundaire zijde ($N_s = 2$) met **2 draden van 1.5 mm geëmailleerd koper parallel** (bifilair gewikkeld). Dit geeft een lagere wisselstroomweerstand en strakkere koppeling.

### 4.2 Testen met 2.5 mm flexibele geïsoleerde draad
* **Is testen met de 2.5 mm draad met kunststof mantel erg?**
  * **Nee, voor een eerste test/meting is dit geen probleem.** Je kunt hiermee prima controleren of de transformator werkt en de audio-weergave testen.
  * **Aandachtspunt:** Door de dikke kunststof mantel van de flexibele draad ontstaat er extra afstandsruimte tussen de primaire en secundaire wikkeling. Dit verhoogt de **lekinductie (leakage inductance)**. Hoge lekinductie werkt als een laagdoorlaatfilter en kan de hoogste tonen (18 kHz - 25 kHz) licht dempen.
  * **Definitieve bouw:** Wikkel voor de definitieve versie strak op de kern met geëmailleerd koperdraad (of koperfolie) om lekinductie tot een minimum te beperken.

---

## 5. Wikkelinstructie & Samenstelling

1. **Primaire wikkeling ($N_p = 29$ windingen):**
   * Wikkel 29 windingen $0.5\text{ mm}$ geëmailleerd koperdraad gelijkmatig verdeeld over de omtrek van de **FT240-43** ferrietkern.
   * Houd de windingen strak tegen de kern.

2. **Isolatie / Koppeling:**
   * Breng optioneel een laagje Kapton-tape of Teflon-tape aan over de primaire wikkeling.

3. **Secundaire wikkeling ($N_s = 2$ windingen):**
   * Wikkel 2 windingen van $2 \times 1.5\text{ mm}$ geëmailleerd koper parallel (of $1 \times 1.5\text{ mm}$ / $2.5\text{ mm}$ voor de testfase) direct bovenop de primaire wikkeling.
   * Zorg dat de secundaire draden zo kort mogelijk gehouden worden naar de klemmen van het aluminium lint om extra weerstand te voorkomen.

---

## 6. Beveiliging & Crossover Advies

Een lint-tweeter en diens transformator hebben een zeer lage DC-weerstand.
* **Let op:** Sluit de transformator **nooit rechtstreeks** aan op een versterker zonder filter. Eventuele DC-offset of lage frequenties van de versterker sturen de ferrietkern direct in verzadiging (saturation) en kunnen de tweeter of versterker beschadigen.
* **Passief Crossover:** Plaats altijd een serie-condensator (bijv. een hoogwaardige Polypropyleen / MKP condensator) vóór de primaire wikkeling om frequenties beneden 4 kHz te filteren (bijv. $10\ \mu\text{F}$ voor een 1e orde filter op $4\text{ kHz}$ bij $4\ \Omega$).

---

## 7. Geïntegreerde Behuizingsfuncties in `ribbon_tweeter_driver.scad`

1. **Zij-inloop Magneetsleuven met M3 Borgpen-Gaten:**
   * De N52 magneten worden via de zijkanten ingeschoven. Aan het uiteinde van de sleuven zitten M3 borgpen-gaten. Zodra de magneten op hun plek zitten, draai je hier een M3 schroefje in, zodat de magneten nooit door trillingen los kunnen raken.
2. **Kabel-Gootjes voor Trafo-Draden:**
   * Aan de bovenzijde en onderzijde bij de koperen contact-pads zitten kabelgootjes waarmee de dikke secundaire getwiste koperdraden van de transformator netjes naar buiten geleid worden.
3. **Geïntegreerde Montage-Oren voor Trafo & Condensator:**
   * De behuizing heeft verlengde montage-flenzen aan de achterkant voorzien van 4x M4 schroefgaten. Hierop schroef je de transformator en de $3.7\ \mu\text{F}$ audio-condensator rechtstreeks vast, wat zorgt voor één compacte, trillingsvrije module.
4. **TPU Flexibele Demping-Pakkingen:**
   * Het CAD-bestand bevat 3D-geprinte TPU dempingsstrips die tussen het aluminium lint en de stijve klemblokken liggen om mechanische trillingen te dempen en inscheuren te voorkomen.

---

## 8. Samenvatting van de Aanbevelingen

* **Geadviseerd Aantal Windingen:** **2 Secundaire windingen ($N_s = 2$)** en **29 Primaire windingen ($N_p = 29$)**.
* **Kernkeuze:** **FT240-43 Ferrietkern**. (De opgerolde metalen toroid is ongeschikt voor 4 kHz - 25 kHz).
* **Primaire Draad:** **0.5 mm** geëmailleerd koper ($29\text{ windingen}$).
* **Secundaire Draad:**
  * *Voor testen:* **2.5 mm flexibele draad** is prima te gebruiken.
  * *Definitief:* **$2 \times 1.5\text{ mm}$ parallel** geëmailleerd koper voor strakke koppeling en minimale lekinductie tot 25 kHz.
