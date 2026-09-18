// ==============================================================================
// OpenSCAD Parametric Ribbon Tweeter Driver Assembly (V2 - External Magnet Slots)
// Designed for 120mm Active Ribbon (PA Outdoor Line Array)
// Features:
// 1. External Magnet Pockets: Magneten worden van de BUITENKANT naar binnen gedrukt.
//    De magneten trekken elkaar aan en klemmen zichzelf vast tegen de 1.0mm binnenwand!
// 2. Volledig Vrij Lint-kanaal: Geen uitsteeksels in de weg! Lint kan kaarsrecht
//    van boven naar beneden over de koperen tape-pads worden gelegd.
// 3. Losse Klemblokken (Top, Midden, Bodem) voor TPU/ABS klem strips met M3 bouten.
// 4. Voorse flens met 6x M3 gaten passend op ribbon_waveguide.scad.
// ==============================================================================

// --- PARAMETERS (All dimensions in mm) ---
mag_length      = 60.0;     // Lengte van N52 magneet (60mm)
mag_width       = 10.0;     // Breedte van N52 magneet (10mm)
mag_thick       = 5.0;      // Dikte van N52 magneet (5mm)
num_mags_stack  = 2;        // 2 magneten gestapeld = 10mm diepte

ribbon_length   = 120.0;    // Actieve lintlengte (2x 60mm magneetspan)
gap_width       = 12.0;     // Luchtspleet breedte (10mm lint + 1mm marge aan elke kant)
inner_wall_t    = 1.0;      // Binnenwand dikte die magneten op exacte afstand (12mm) houdt

body_width      = 54.0;     // Totale breedte behuizing
body_height     = 160.0;    // Totale hoogte behuizing (120mm lint + 2x 20mm klemzones)
body_depth      = 25.0;     // Totale diepte behuizing

front_flange_w  = 10.0;     // Flens overhang passend op waveguide
front_flange_t  = 5.0;      // Flens dikte

total_mag_depth = mag_thick * num_mags_stack; // 10mm diepte per pool

// --- MODULE 1: HOOFDBEHIUZING (DRIVER BODY) ---
module ribbon_tweeter_body() {
    difference() {
        // A. Massief buitenblok met voorste keelflens
        union() {
            // Hoofdblok
            translate([0, 0, body_depth/2])
                cube([body_width, body_height, body_depth], center=true);

            // Voorste montageflens voor waveguide
            translate([0, 0, body_depth - front_flange_t/2])
                cube([gap_width + 8.0 + 2*front_flange_w,
                      ribbon_length + 8.0 + 2*front_flange_w,
                      front_flange_t], center=true);
        }

        // B. VOLLEDIG VRIJ LINTKANAAL (Doorgaande sleuf van z=-1 tot z=body_depth+1)
        // Geen enkele obstructie! Het lint ligt vlak van boven naar beneden.
        translate([0, 0, body_depth/2])
            cube([gap_width, body_height + 2, body_depth + 4], center=true);

        // C. BUITENSTE MAGNEETSLEUVEN (Magneten van buitenkant naar binnen drukken)
        // De magneten vallen in vakken vanaf de zijkant, en rusten tegen de 1.0mm binnenwand.
        for (sy = [-1, 1]) {
            // Links buitenste magneetsleuf
            translate([-(gap_width/2 + inner_wall_t + total_mag_depth/2), sy * (mag_length/2 + 2), body_depth/2])
                cube([total_mag_depth + 0.2, mag_length + 0.4, mag_width + 0.4], center=true);

            // Rechts buitenste magneetsleuf
            translate([(gap_width/2 + inner_wall_t + total_mag_depth/2), sy * (mag_length/2 + 2), body_depth/2])
                cube([total_mag_depth + 0.2, mag_length + 0.4, mag_width + 0.4], center=true);
        }

        // D. KOPEREN TAPE & KLEM RECESSES (Boven, Midden, Onder)
        // Verdieping van 2mm aan de voorzijde voor koperen tape-pads en TPU klemmen
        for (sy = [-1, 1]) {
            translate([0, sy * (ribbon_length/2 + 10), body_depth - 1.0])
                cube([gap_width + 12, 16, 3], center=true);
        }
        // Middenklem uitsparing
        translate([0, 0, body_depth - 1.0])
            cube([gap_width + 12, 10, 3], center=true);

        // E. M3 SCHROEFGATEN VOOR LINTKLEMMEN (Boven, Midden, Onder)
        for (sy = [-1, 1]) {
            for (sx = [-1, 1]) {
                translate([sx * (gap_width/2 + 4), sy * (ribbon_length/2 + 10), 0])
                    cylinder(d=3.5, h=body_depth + 2, $fn=32);
            }
        }
        // Middenklem schroefgaten
        for (sx = [-1, 1]) {
            translate([sx * (gap_width/2 + 4), 0, 0])
                cylinder(d=3.5, h=body_depth + 2, $fn=32);
        }

        // F. WAVEGUIDE MONTAGEGATEN (6x M3 op de voorflens)
        t_hx = (gap_width / 2) + 4.0 + (front_flange_w / 2);
        t_hy = (ribbon_length / 2) + 4.0 + (front_flange_w / 2);

        // 4 Hoeken
        for (sx = [-1, 1]) {
            for (sy = [-1, 1]) {
                translate([sx * t_hx, sy * t_hy, body_depth - 12])
                    cylinder(d=4.2, h=15, $fn=32);
            }
        }
        // 2 Midden-zijden
        for (sy = [-1, 1]) {
            translate([0, sy * t_hy, body_depth - 12])
                cylinder(d=4.2, h=15, $fn=32);
        }
    }
}

// --- MODULE 2: LOSSE TPU / RIGID LINTKLEM STRIPS (Voor 3D Printen) ---
module ribbon_clamp_strip(width=22.0, height=14.0, thick=3.0) {
    difference() {
        cube([width, height, thick], center=true);
        // M3 schroefgaten
        for (sx = [-1, 1]) {
            translate([sx * (gap_width/2 + 4), 0, 0])
                cylinder(d=3.5, h=thick + 2, center=true, $fn=32);
        }
    }
}

// --- RENDER MODUS ---
// Teken de behuizing
ribbon_tweeter_body();

// Teken de losse klemstrips er naast (handig voor 3D-printen)
translate([body_width/2 + 20, 30, 1.5])
    ribbon_clamp_strip(width=22, height=14, thick=3);

translate([body_width/2 + 20, 0, 1.5])
    ribbon_clamp_strip(width=22, height=8, thick=3); // Middenklem

translate([body_width/2 + 20, -30, 1.5])
    ribbon_clamp_strip(width=22, height=14, thick=3);
