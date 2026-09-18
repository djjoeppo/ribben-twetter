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

## 2. Magnetisch Motorontwerp (4x N52 Magneten)

### 2.1 Bepaling Magneetoriëntatie
De $60 \times 10 \times 5\text{ mm}$ N52 magneten zijn in de lengterichting ($60\text{ mm}$) gemagnetiseerd of door de dikte ($5\text{ mm}$ / $10\text{ mm}$).
* **Magnetisatie door de dikte ($5\text{ mm}$ of $10\text{ mm}$):** De N- en S-polen bevinden zich op de grote platte zijden van $60 \times 10\text{ mm}$ of $60 \times 5\text{ mm}$. Dit is de ideale configuratie voor een lint-tweeter motor!
* **Spleetbreedte ($W_{gap}$):** $12\text{ mm}$ (geschikt voor een lintbreedte van $10\text{ mm}$ met $1\text{ mm}$ luchtmarge aan beide zijden).
* **Spleetdiepte ($D_{gap}$):** $10\text{ mm}$.

---

### 2.2 Vergelijking Magneet-Configuraties (Met 4x N52 Magneten)

Je kunt de 4 beschikbare N52 magneten op drie verschillende manieren rangschikken. Hier is de exacte vergelijking van de voor- en nadelen:

| Configuraties (met 4x N52 $60\times10\times5\text{mm}$) | Relatieve Veldsterkte ($B$) | Trillende Lengte ($L_{eff}$) | SPL Efficiëntie | Voor- en Nadelen |
| :--- | :--- | :--- | :--- | :--- |
| **A. 1 Magneet links, 1 rechts** *(slechts 2 magneten gebruikt)* | $\approx 0.25 - 0.35\text{ Tesla}$ (Laag) | $55\text{ mm} - 60\text{ mm}$ | Basisniveau (0 dB ref) | **Voordeel:** Eenvoudige montage.<br>**Nadeel:** Lage veldsterkte in $12\text{mm}$ spleet; lagere SPL en minder controle/demping op het lint. |
| **B. 2 Magneten op elkaar gestapeld links & 2 rechts (Verdubbeling Diepte)** | $\approx 0.45 - 0.60\text{ Tesla}$ (Hoog) | $55\text{ mm} - 60\text{ mm}$ | **+3.5 dB tot +4.5 dB winst** t.o.v. Config A | **Voordeel:** Maximale veldsterkte $B$ per millimeter lint; erg zuiver geluid, hoge elektrische belastbaarheid en strakke controle op trillingen.<br>**Nadeel:** Lintlengte blijft 60 mm. |
| **C. 2 Magneten achter elkaar in de lengte links & 2 rechts (Lengte = $120\text{ mm}$)** | $\approx 0.25 - 0.35\text{ Tesla}$ (Middel) | **$115\text{ mm} - 120\text{ mm}$** (2x groter membraan) | **+3 dB winst bij lage frequenties (3-4 kHz)** t.o.v. Config A | **Voordeel:** 2x groter luchtverplaatsend oppervlak (11.5 cm²); extreem smalle verticale afstraling (perfect voor Line Array high throw).<br>**Nadeel:** Veldsterkte $B$ per mm blijft gelijk aan Config A; langer lint rekt sneller uit. |

#### **Conclusie & Advies voor PA Line Array:**
* **Kies Configuratie B (2 op elkaar gestapeld)** als je **maximale controle, minimale vervorming en hoogste SPL per mm** wilt.
* **Kies Configuratie C (2 achter elkaar in de lengte, 120 mm)** als je een **groter Line Array oppervlak** wilt met een **zeer strakke verticale bundeling (high throw)** en betere weergave rarr 3.5 kHz.

---

### 2.3 Proof of Concept (3D-Print) vs. Stalen Yoke Upgrade
1. **3D-Geprinte Behuizing (PETG-CF / ABS) [Proof of Concept]:**
   * Veldsterkte in de spleet zonder stalen geleiding: $\approx 0.35 - 0.45\text{ Tesla}$.
   * Werkt prima om de werking te testen, maar veel magnetische flux lekt weg aan de achterkant en zijkanten.
2. **Stalen Yoke Upgrade (Stalen U-profiel of stalen strip achter langs):**
   * Door een stalen/ijzeren strip (dikte $\ge 3\text{ mm}$) achter de magneten te plaatsen, sluit je de magnetische kring (magnetic circuit).
   * **Resultaat:** Verhoging van de veldsterkte $B$ naar $\approx 0.7 - 0.9\text{ Tesla}$. Dit levert een directe SPL-winst van **+4 dB tot +6 dB** op zonder de versterker zwaarder te belasten!

---

## 3. Lint-Ontwerp (Folie, Afmetingen & Corrugatie)

### 3.1 Lintafmetingen
* **Totale lengte ($L_{total}$):** $70\text{ mm}$ (bij Config B) of $130\text{ mm}$ (bij Config C).
* **Effectieve (trillende) lengte ($L_{eff}$):** $55\text{ mm} - 60\text{ mm}$ (Config B) of $115\text{ mm} - 120\text{ mm}$ (Config C).
* **Breedte ($W$):** $10\text{ mm}$.
* **Dikte ($T$):** $12\ \mu\text{m} = 0.012\text{ mm}$ (Standaard huishoudaluminiumfolie).
* **Massa van het trillende lint ($m$ bij 60mm):**
  $$\text{Volume} = 0.055\text{ m} \times 0.010\text{ m} \times 0.000012\text{ m} = 6.6 \times 10^{-9}\text{ m}^3$$
  $$\text{Dichtheid Aluminium } (\rho) = 2700\text{ kg/m}^3$$
  $$\text{Massa } m = 2700 \times 6.6 \times 10^{-9} \approx 0.0178\text{ gram} \ (17.8\text{ mg})$$
  *Deze extreem lage massa zorgt voor een ongeëvenaarde transiëntrespons en haarscherpe hoogweergave.*

### 3.2 Plooien / Corrugatie (Golfplaten) van het Lint
Het plooien van het folie is een cruciale stap bij een ribbon tweeter.

#### Voor- en Nadelen van Plooien:
* **Voordelen:**
  1. **Voorkomt 'wapperen' en opbreekresonanties:** Ongeplooide folie heeft eigen resonanties (parasitaire modes) in het hoorbare gebied, wat leidt tot schril/vervormd geluid.
  2. **Mechanische flexibiliteit (Compliance):** Het lint kan lineair heen en weer bewegen in de magneetspleet zonder de spanning op de aansluitpunten op te bouwen.
  3. **Thermische expansie opvangen:** Als het lint warm wordt door hoog PA-vermogen, rekt het uit. Plooien voorkomen dat het lint doorhangt tegen de magneten.
* **Nadelen:**
  1. Verhoogt de effectieve massa per millimeter lengte heel licht ($\approx +5\% - 10\%$).
  2. Verhoogt de gelijkstroomweerstand $R_{dc}$ heel licht doordat de stroomweg langer wordt.

#### Vergelijking Soorten Plooien:
| Ploooitype | Pitch (Golfafstand) | Diepte | Eigenschappen & Geschiktheid |
| :--- | :--- | :--- | :--- |
| **Fijne Corrugatie** | $0.8\text{ mm} - 1.2\text{ mm}$ | $0.3\text{ mm} - 0.5\text{ mm}$ | **AANBEVOLEN.** Zeer hoge stijfheid in de breedte, perfecte lineaire excursie, minimale doorgang van ongewenste resonanties. Ideaal voor 3.5 kHz – 25 kHz. |
| **Grove Corrugatie** | $2.5\text{ mm} - 4.0\text{ mm}$ | $1.0\text{ mm} - 1.5\text{ mm}$ | Staat grotere uitslag toe voor lage frequenties (< 1.5 kHz), maar heeft meer neiging tot torderen bij hoge frequenties en lagere SPL-efficiëntie. |

**Hoe te maken:**
Haal de strook aluminiumfolie voorzichtig tussen twee passende kunststof/3D-geprinte tandwielen door (of gebruik een tandwiel-corrugator tool geprint met de 3D-printer).

---

## 4. Klemmen, Elektrische Aansluiting & TPU-Demping

### 4.1 TPU Klemblokken & Koperen Tape
* **Elektrisch Contact:** De uiteinden van het aluminiumfolie ($5\text{ mm}$ aan beide zijden) worden vastgeklemd tussen zelfklevende **koperen tape**. Hierop kan de koperdraad van de secundaire wikkeling van de transformator rechtstreeks en kort gesoldeerd worden.
* **TPU Flexibele Oprol/Dempingsrand:**
  * Gebruik 3D-geprinte pakkingen van **TPU (Flexibel filament)** aan de uiteinden van de klemmen.
  * Het TPU absorbeert reflectiegolven die langs het lint reizen en voorkomt dat het aluminium inscheurt op de rand van de klem.

---

## 5. Waveguide / Hoorn Ontwerp voor PA Outdoor Line Array

Om een hoge SPL en een lange draagwijdte (throw) in een outdoor Line Array te bereiken, mag de tweeter het geluid niet verticaal rondstralen.

### 5.1 Akoestische Waveguide Specificaties
* **Horizontale spreiding:** $90^\circ - 110^\circ$ (brede dekking van het publiek).
* **Verticale spreiding:** $10^\circ - 15^\circ$ (strakke cylindrische golf om uitdoving/interferentie in de Line Array te voorkomen).
* **SPL-winst door Hoorn/Waveguide:** **+3 dB tot +5 dB** extra gevoeligheid in het bereik van 3.5 kHz tot 12 kHz.

---

## 6. Crossover Berekening ($3.7\ \mu\text{F}$ Condensator)

De gebruiker heeft een **$3.7\ \mu\text{F}$ audiocondensator**. De kantelfrequentie ($f_c$) van een 1e-orde hoogdoorlaatfilter wordt bepaald door de formule:

$$f_c = \frac{1}{2 \pi \times Z_p \times C}$$

Waar $Z_p$ de primaire impedantie van de transformator is en $C = 3.7 \times 10^{-6}\text{ F}$.

### 6.1 Bepaling Primaire Impedantie van de Trafo:
| Gewenste Kantelfrequentie ($f_c$) | Benodigde Primaire Impedantie ($Z_p$) | Trafo Wikkelverhouding ($a = \sqrt{Z_p / Z_s}$) voor $Z_s = 0.0185\ \Omega$ |
| :--- | :--- | :--- |
| **$4.0\text{ kHz}$** | **$10.75\ \Omega$** | **$24.1 : 1$** ($N_p = 48$, $N_s = 2$) |
| **$5.0\text{ kHz}$** | **$8.60\ \Omega$** | **$21.5 : 1$** ($N_p = 43$, $N_s = 2$) |
| **$6.0\text{ kHz}$** | **$7.17\ \Omega$** | **$19.7 : 1$** ($N_p = 39$, $N_s = 2$) |
| **$10.75\text{ kHz}$** | **$4.00\ \Omega$** | **$14.7 : 1$** ($N_p = 29$, $N_s = 2$) |

**Conclusie & Advies voor Crossover:**
Als je de $3.7\ \mu\text{F}$ condensator wilt gebruiken om bij **$4.0\text{ kHz}$** in te snijden, dien je de transformator primair af te stemmen op **$\approx 10.7\ \Omega$** (bijvoorbeeld met $N_p = 48$ en $N_s = 2$ op de FT240-43 kern).

---

## 7. 3D-Print & Assemblage Instructies

### 7.1 Materiaalkeuze voor 3D-Printen
* **Behuizing & Waveguide:** **PETG-CF** of **ABS** (stijf, hittebestendig outdoor, minimale trillingen).
* **Klem-pakkingen:** **TPU (95A of 85A)** (trillingsdemping en bescherming van folie).

### 7.2 Stappenplan Assemblage
1. **Print de Behuizing:** Print het hoofdframe met de magnetische sleuven, de TPU dempers en de waveguide.
2. **Plaats de Magneten:** Druk de 4x N52 magneten in de uitsparingen (Let op de polariteit: Attractie/Repulsie goed controleren!).
3. **Optioneel - Stalen Yoke:** Monteer de stalen strip achter de magneten voor maximale SPL.
4. **Prepareer het Lint:** Snijd een strook van $70\text{ mm} \times 10\text{ mm}$ (of $130\text{ mm} \times 10\text{ mm}$) uit huishoudfolie. Haal door de corrugator voor fijne plooien.
5. **Aansluiting:** Plak koperen tape op de TPU-klemmen. Soldeer de draden van de trafo-secundaire zijde aan de koperen tape.
6. **Lint Opspannen:** Leg het lint voorzichtig op de koperen tape in het centrum van de magneetspleet. Zorg dat het lint NERGENS de magneten raakt.
7. **Bovenklem Vastschroeven:** Schroef de TPU/PETG topklemmen vast met M3 schroeven.
8. **Condensator Aansluiten:** Plaats de $3.7\ \mu\text{F}$ condensator in serie met de + klem op de primaire zijde van de trafo.
