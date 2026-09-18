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
  * Huishoudaluminiumfolie (dikte ca. $10\ \mu\text{m} - 15\ \mu\text{m}$).
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

### 2.2 Vergelijking Magneet-Configuraties (Met 4x N52 Magneten)

| Configuraties (met 4x N52 $60\times10\times5\text{mm}$) | Relatieve Veldsterkte ($B$) | Trillende Lengte ($L_{eff}$) | SPL Efficiëntie | Voor- en Nadelen |
| :--- | :--- | :--- | :--- | :--- |
| **A. 1 Magneet links, 1 rechts** | $\approx 0.25 - 0.35\text{ T}$ | $55 - 60\text{ mm}$ | 0 dB ref | Eenvoudig, maar lagere veldsterkte en minder controle. |
| **B. 2 Gestapeld op elkaar links & rechts** | $\approx 0.45 - 0.60\text{ T}$ | $55 - 60\text{ mm}$ | **+3.5 dB tot +4.5 dB** | **Maximale veldsterkte $B$ per mm**, extreem zuiver, hoge belastbaarheid. |
| **C. 2 Achter elkaar in de lengte (120 mm)** | $\approx 0.25 - 0.35\text{ T}$ | $115 - 120\text{ mm}$ | **+3 dB bij 3-4 kHz** | 2x groter oppervlak, hele strakke verticale bundeling (Line Array outdoor throw). |
| **C-Middenklem (1 Lint van 12 cm met Middenklem)** | $\approx 0.25 - 0.35\text{ T}$ | $2\times 55\text{ mm}$ | **+3.5 dB** | **Combineert lange Line Array afstraling met de stabiliteit van een kort lint!** |

---

## 3. Analyse van Lint-Parameters (Lengte, Breedte & Corrugatie)

### 3.1 Middenklem bij een Lang Lint (12-13 cm) [Optie C-Middenklem]
Wanneer je 1 lang lint van 12-13 cm gebruikt en dit in het midden ondersteunt/vastklemt (dual segment):
* **Voordelen:**
  1. **Geen doorhangen/wapperen:** Het lint gedraagt zich mechanisch als twee kortere stijve segmenten van 6 cm, waardoor het niet gaat zwabberen of tegen de magneten tikt.
  2. **Betere resonantiecontrole:** De grondresonantie verschuift naar een hogere frequentie die buiten/onder de crossover valt.
  3. **Behoud van Line Array effect:** De twee segmenten stralen samen in fase af en vormen alsnog één lange verticale geluidsbron (cylindrische golf).
* **Nadelen:**
  1. Je verliest een klein stukje effectief trillend oppervlak bij het klemblokje in het midden ($\approx 5\text{ mm}$).
  2. Iets complexere montage en TPU-demping in het midden.

---

### 3.2 Breed vs. Smal Lint
* **Breed Lint ($12\text{ mm} - 15\text{ mm}$):**
  * *Voordelen:* Groter oppervlak $\rightarrow$ meer luchtverplaatsing $\rightarrow$ hogere SPL bij lage frequenties (2.5 - 4 kHz). Lagere elektrische weerstand.
  * *Nadelen:* Brede magneetspleet nodig ($15-18\text{ mm}$), waardoor de veldsterkte $B$ sterk afneemt! Bredere horizontale afstraling vervormt sneller boven 10 kHz (bundeling).
* **Smal Lint ($6\text{ mm} - 10\text{ mm}$) [AANBEVOLEN: 10 mm]:**
  * *Voordelen:* Nauwe magneetspleet mogelijk ($12\text{ mm}$) $\rightarrow$ **zeer hoge veldsterkte $B$** $\rightarrow$ hogere efficiëntie en zuiverder geluid. Uitstekende brede horizontale spreiding tot 20 kHz.
  * *Nadelen:* Kleiner oppervlak, iets minder uitslag bij hele lage frequenties (< 3 kHz).

---

### 3.3 Lang vs. Kort Lint
* **Lang Lint ($120\text{ mm} - 150\text{ mm}$):**
  * *Voordelen:* Uitstekende verticale richtwerking (Line Array effect), draagt heel ver outdoor (high throw). Hoge akoestische belasting (radiation impedance).
  * *Nadelen:* Gevoeliger voor torderen en hitte; vereist middenklem of fijne corrugatie.
* **Kort Lint ($50\text{ mm} - 70\text{ mm}$):**
  * *Voordelen:* Mechanisch zeer stabiel, extreem lage massa, simpel te monteren.
  * *Nadelen:* Brede verticale rondstraling (minder geschikt voor Line Array op grote afstand).

---

### 3.4 Vlak Lint vs. Gecorrugeerd Lint (Plooien)
* **Vlak (Plat) Lint:**
  * *Nadelen:* **NIET GESCHIKT voor PA/High SPL.** Een platte aluminiumfolie heeft geen mechanische compliance. Bij het trillen rekt het folie op, ontstaat er 'flutter'/wapperen en scheurt het binnen korte tijd in op de klemranden.
* **Gecorrugeerd Lint:**
  * *Voordelen:* Noodzakelijk voor lineaire beweging, voorkomt vervorming en vangt thermische uitzetting op.

#### Soorten Corrugatie Vergelijking:
| Corrugatie Type | Pitch | Diepte | Karakteristiek & Resultaat |
| :--- | :--- | :--- | :--- |
| **Fijne Sinus/Zaagtand (AANBEVOLEN)** | $0.8 - 1.2\text{ mm}$ | $0.3 - 0.5\text{ mm}$ | Hoge stijfheid over de breedte, neutrale en zuivere weergave van 3.5 kHz tot 25 kHz. Geen opbreekresonanties. |
| **Grove Corrugatie** | $2.5 - 4.0\text{ mm}$ | $1.0 - 1.5\text{ mm}$ | Staat grote mechanische uitslag toe voor lage frequenties (< 2 kHz), maar vervormt (tordeert) sneller boven 10 kHz. |
| **Diagonale / Wafel Corrugatie** | $1.5\text{ mm}$ | $0.4\text{ mm}$ | Extreem stijf in alle richtingen, maar verhoogt de massa en weerstand het meest. |

---

## 4. Klemmen, Elektrische Aansluiting & TPU-Demping

* **Elektrisch Contact:** De uiteinden van het aluminiumfolie worden vastgeklemd tussen zelfklevende **koperen tape**. Hierop wordt de secundaire draad van de trafo gesoldeerd.
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
3. **Corrugeer het Lint:** Gebruik de 3D-geprinte tandwiel-corrugator voor fijne plooien.
4. **Assemblage:** Klem het lint vast op de koperen tape en TPU klemmen.
