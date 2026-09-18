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

### 3.1 Foliedikte Vergelijking: Huishoudfolie ($0.01\text{ mm}$) vs. Dikke Folie ($0.1\text{ mm}$)

| Eigenschap | Huishoudfolie ($0.01\text{ mm} / 10\ \mu\text{m}$) | Dikke Folie ($0.1\text{ mm} / 100\ \mu\text{m}$) |
| :--- | :--- | :--- |
| **Massa ($60\text{ mm} \times 10\text{ mm}$)** | **$16.2\text{ mg}$ (Extreem licht!)** | **$162\text{ mg}$ (10x zwaarder!)** |
| **Gelijkstroomweerstand ($R_{dc}$)** | $\approx 0.0185\ \Omega$ | $\approx 0.00185\ \Omega$ (Extreem laag) |
| **Transiëntrespons & Hoogweergave (> 10 kHz)** | **Uitstekend:** Reageert direct op bliksemsnelle HF-signalen. | **Slecht:** Hoge massa werkt als mechanisch laagdoorlaatfilter (dempt hoog af boven 8-10 kHz). |
| **Rendement / Efficiëntie (SPL)** | **Zeer Hoog (+10 dB tot +15 dB efficiënter per Watt)** | **Zeer Laag:** Versnelling $a = F/m$ is 10x kleiner bij dezelfde Lorentzkracht $F$. |
| **Mechanische Stevigheid / Belastbaarheid** | Kwetsbaar bij montage, maar thermisch zeer goed gekoeld door luchtstroom. | Mechanisch oersterk en kan enorm veel stroom verdragen. |

#### **Fysische Verklaring (Waarom $0.01\text{ mm}$ de Enige Goede Keuze is voor High SPL):**
De kracht die het lint in beweging brengt is de Lorentzkracht: $F = B \times I \times L$.
De versnelling van het lint (en dus de geluidsdruk/SPL die gegenereerd wordt) volgt de wet van Newton:

$$a = \frac{F}{m}$$

Als je $0.1\text{ mm}$ folie gebruikt, wordt de massa $m$ **10 keer zo groot**. Dit betekent dat bij dezelfde versterkerstroom de versnelling $a$ **10 keer kleiner** is! Je verliest hiermee ruim **10 tot 20 dB aan gevoeligheid/SPL**.

* **Conclusie:** Gebruik **altijd de dunne $0.01\text{ mm}$ (10 micron) huishoudfolie** voor de ribbon tweeter! Het dikke $0.1\text{ mm}$ folie is absoluut ongeschikt voor frequenties boven 3 kHz.

---

### 3.2 Middenklem bij een Lang Lint (12-13 cm) [Optie C-Middenklem]
Wanneer je 1 lang lint van 12-13 cm gebruikt en dit in het midden ondersteunt/vastklemt (dual segment):
* **Voordelen:** Geen doorhangen/wapperen, betere resonantiecontrole en behoud van Line Array 'high throw'.

---

### 3.3 Breed vs. Smal Lint & Lang vs. Kort Lint
* **Breedte:** $10\text{ mm}$ is de optimale balans tussen spleetbreedte/veldsterkte $B$ en oppervlak.
* **Lengte:** $120\text{ mm}$ met middenklem geeft een uitstekende Line Array afstraling.

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
3. **Corrugeer het Lint:** Gebruik de 3D-geprinte tandwiel-corrugator op het **$0.01\text{ mm}$ huishoudfolie**.
4. **Assemblage:** Klem het lint vast op de koperen tape en TPU klemmen.
