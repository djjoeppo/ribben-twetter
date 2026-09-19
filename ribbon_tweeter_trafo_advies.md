# Ontwerp en Advies Zelfbouw Ribbon Tweeter Transformator (V1 & V2)

Dit document bevat de volledige berekeningen, materiaalanalyse en praktische wikkelinstructies voor het bouwen van een audiotransformator ten behoeve van een lint-tweeter (ribbon tweeter) met een gewenste primaire impedantie van **4 Ohm** in het frequentiebereik van **4 kHz tot 25 kHz**.

---

## 1. Parameters & Berekeningen - Ribbon Tweeter V1

### 1.1 Specificaties van het Lint V1
* **Lengte ($L$):** $70\text{ mm} = 0.07\text{ m}$
* **Breedte ($W$):** $10\text{ mm} = 0.01\text{ m}$
* **Dikte ($T$):** $0.01\text{ mm} = 1 \times 10^{-5}\text{ m}$
* **Soortelijke weerstand Aluminium ($\rho$):** $\approx 2.65 \times 10^{-8}\ \Omega\cdot\text{m}$

$$\text{Doorsnede } A = W \times T = 0.01\text{ m} \times 0.00001\text{ m} = 1.0 \times 10^{-7}\text{ m}^2$$

$$\text{Gelijkstroomweerstand } R_{dc} = \rho \frac{L}{A} = 2.65 \times 10^{-8} \times \frac{0.07}{1.0 \times 10^{-7}} \approx 0.01855\ \Omega \ (18.55\text{ m}\Omega)$$

### 1.2 Transformatieverhouding & Impedantie V1
* **Wikkelverhouding ($a = N_p / N_s$):** $14.671 : 1$
* **Impedantieverhouding ($Z_p / Z_s$):** $a^2 = (14.671)^2 \approx 215.24 : 1$

$$Z_p = a^2 \times Z_s = 215.24 \times 0.01855\ \Omega \approx 3.99\ \Omega \approx 4\ \Omega$$

* **Aanbevolen windingen V1:** **$N_s = 2$ secundair** en **$N_p = 29$ primair** (Verhouding $14.5 : 1 \rightarrow Z_p \approx 3.90\ \Omega$).

---

## 2. Parameters & Berekeningen - Ribbon Tweeter V2 (GEUPDATE)

### 2.1 Specificaties van het Lint V2
* **Geribbeld gedeelte:** $120\text{ mm}$ met $30^\circ$ V-ribbel (module 0.4).
  * Door de $30^\circ$ V-groefhoek is de werkelijke gestrekte lengte van het geribbelde deel: $120\text{ mm} / \cos(15^\circ) \approx 124.2\text{ mm}$.
* **Kopstukken voor montagedraden:** $2 \times 20\text{ mm} = 40\text{ mm}$ (plat).
* **Totale gestrekte lengte ($L$):** $124.2\text{ mm} + 40\text{ mm} \approx 164.2\text{ mm} = 0.1642\text{ m}$.
* **Breedte ($W$):** $10\text{ mm} = 0.01\text{ m}$
* **Dikte ($T$):** **$0.01\text{ mm} = 1 \times 10^{-5}\text{ m}$** (keukenfolie dikte)

$$\text{Doorsnede } A = W \times T = 0.01\text{ m} \times 0.00001\text{ m} = 1.0 \times 10^{-7}\text{ m}^2$$

$$\text{Gelijkstroomweerstand } R_{dc} = \rho \frac{L}{A} = 2.65 \times 10^{-8} \times \frac{0.1642}{1.0 \times 10^{-7}} \approx 0.04351\ \Omega \ (43.51\text{ m}\Omega)$$

### 2.2 Transformatieverhouding & Impedantie voor V2
Om van de hogere weerstand van $0.04351\ \Omega$ uit te komen op een primaire impedantie van **$4\ \Omega$**:

$$\text{Impedantieverhouding } \frac{Z_p}{Z_s} = \frac{4\ \Omega}{0.04351\ \Omega} \approx 91.93 : 1$$

$$\text{Nodige Wikkelverhouding } a = \sqrt{91.93} \approx \mathbf{9.59 : 1}$$

### 2.3 Opties voor Aantal Windingen voor V2 (op FT240-43 Ferrietkern)

1. **Optie A (AANBEVOLEN): $N_s = 3$ Secundaire windingen**
   * Primaire windingen: $N_p = 3 \times 9.59 = 28.77 \rightarrow \mathbf{29\text{ windingen}}$.
   * Exacte Wikkelverhouding: $29 : 3 = 9.67 : 1$.
   * Primaire Impedantie: $Z_p = (9.67)^2 \times 0.04351\ \Omega \approx \mathbf{4.07\ \Omega}$ (nagenoeg exact $4\ \Omega$).
   * Inductie $L_p = 1.075\ \mu\text{H} \times 29^2 = 0.904\text{ mH}$.
   * Reactantie bij 4 kHz: $X_L = 2\pi \times 4000 \times 0.000904 \approx 22.7\ \Omega$ ($22.7\ \Omega \gg 4\ \Omega$).
   * *Beoordeling:* Uitstekende prestatie! Een hele strakke weergave en geen verlies vanaf 4 kHz.

2. **Optie B (Compact): $N_s = 2$ Secundaire windingen**
   * Primaire windingen: $N_p = 2 \times 9.59 = 19.18 \rightarrow \mathbf{19\text{ windingen}}$.
   * Exacte Wikkelverhouding: $19 : 2 = 9.50 : 1$.
   * Primaire Impedantie: $Z_p = (9.50)^2 \times 0.04351\ \Omega \approx \mathbf{3.93\ \Omega}$.
   * Inductie $L_p = 1.075\ \mu\text{H} \times 19^2 = 0.388\text{ mH}$.
   * Reactantie bij 4 kHz: $X_L = 2\pi \times 4000 \times 0.000388 \approx 9.75\ \Omega$ ($9.75\ \Omega > 4\ \Omega$).
   * *Beoordeling:* Werkt ook goed en gebruikt minder wikkelruimte, maar Optie A ($N_s = 3, N_p = 29$) biedt de hoogste kwaliteit en laagste ferrietvervorming bij 4 kHz.

---

## 3. Kernkeuze: Ferriet FT240-43 vs. Opgerolde Metaalband Toroid

### Kies de Ferriet FT240-43 Kern!

| Eigenschap | Ferriet FT240-43 | Opgerolde Metaalband Toroid |
| :--- | :--- | :--- |
| **Materiaal** | NiZn-ferriet (Fair-Rite 43) | IJzer-silicium metaalband |
| **Frequentiebereik** | Uitstekend tot ver boven 25 kHz | Sterke wervelstroomverliezen boven 10 kHz |
| **Vervorming bij 25 kHz** | Verwaarloosbaar | Dempt het hoog en vervormt op hoog volume |

---

## 4. Draadkeuze & Skin-Effect bij 25 kHz

* **Primaire draad ($0.5\text{ mm}$ geëmailleerd koper):** Indringdiepte bij 25 kHz is $\delta \approx 0.42\text{ mm}$. Aangezien de straal $r = 0.25\text{ mm} < \delta$, is $0.5\text{ mm}$ ideaal voor $N_p = 29$ windingen.
* **Secundaire draad:**
  * Voor **V2 ($N_s = 3$ windingen)**: Gebruik **2 draden van 1.5 mm geëmailleerd koper parallel** (bifilair).
  * *Testfase:* Testen met $2.5\text{ mm}$ flexibele mantel-draad is prima te doen.

---

## 5. Samenvatting Aanbevelingen per Versie

| Ribbon Versie | Lint Afmetingen & Dikte | Berekende Lintweerstand $R_{dc}$ | Geadviseerde Wikkelverhouding ($N_p : N_s$) | Aantal Windingen op FT240-43 |
| :--- | :--- | :--- | :--- | :--- |
| **Ribbon V1** | 70mm x 10mm x 0.01mm | $\approx 18.55\text{ m}\Omega$ | $14.5 : 1$ | **$N_p = 29$ primair / $N_s = 2$ secundair** |
| **Ribbon V2** | 164mm (gestrekt) x 10mm x 0.01mm | $\approx 43.51\text{ m}\Omega$ | $9.67 : 1$ | **$N_p = 29$ primair / $N_s = 3$ secundair** (Aanbevolen) |
