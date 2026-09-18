// ==============================================================================
// OpenSCAD Parametric Ribbon Tweeter Driver - Redesigned
// Features:
// 1. ZIJ-INLOOP MAGNEETSLEUVEN: Magneten worden van de LINKER- en RECHTER-zijkant
//    strak naar binnen geschoven. Een dunne 1.0mm binnenwand houdt de magneten op
//    exact 12mm afstand van elkaar (magneten trekken elkaar vast tegen deze wand).
// 2. OPEN ACHTERKANT: Volledige vrije akoestische doorgang van voor naar achter
//    (geen gesloten kamer, optimale koeling & dipool/hoorn akoestiek).
// 3. DRIE SPECIFIEKE LINTKLEMMEN:
//    - Kopse Klemmen (Boven & Onder): Grote, robuuste klemblokken met koperen tape-pads.
//    - Middenklem: Ultra-compacte, smalle TPU strip die de geluidsdoorgang niet blokkeert.
// ==============================================================================

// --- PARAMETERS (All dimensions in mm) ---
mag_length      = 60.0;     // Lengte van N52 magneet (60mm)
mag_width       = 10.0;     // Breedte van N52 magneet (10mm)
mag_thick       = 5.0;      // Dikte van N52 magneet (5mm)
num_mags_stack  = 2;        // 2 magneten gestapeld = 10mm diepte

ribbon_length   = 120.0;    // Actieve lintlengte (2x 60mm magneetspan)
gap_width       = 12.0;     // Luchtspleet breedte (10mm lint + 1mm marge aan elke kant)
inner_wall_t    = 1.0;      // Binnenwand dikte die magneten op exact 12mm afstand houdt

body_width      = 54.0;     // Breedte behuizing
body_height     = 170.0;    // Hoogte behuizing (120mm lint + 2x 25mm robuuste kopse klemzones)
body_depth      = 20.0;     // Diepte behuizing

front_flange_w  = 10.0;     // Flens overhang voor waveguide montage
front_flange_t  = 5.0;      // Flens dikte

total_mag_depth = mag_thick * num_mags_stack; // 10mm diepte per pool

// --- MODULE 1: HOOFDBEHIUZING (DRIVER BODY) ---
module ribbon_tweeter_driver_body() {
    difference() {
        // A. Massief hoofdblok met voorste keelflens
        union() {
            // Hoofdfram
            translate([0, 0, body_depth/2])
                cube([body_width, body_height, body_depth], center=true);

            // Voorste keelflens (passend op waveguide flens)
            translate([0, 0, body_depth - front_flange_t/2])
                cube([gap_width + 8.0 + 2*front_flange_w,
                      ribbon_length + 8.0 + 2*front_flange_w,
                      front_flange_t], center=true);
        }

        // B. OPEN LUCHTSPLEET & OPEN ACHTERKANT (Vrije doorgang van voor naar achter)
        translate([0, 0, body_depth/2])
            cube([gap_width, ribbon_length + 2, body_depth + 4], center=true);

        // C. ZIJ-INLOOP MAGNEETSLEUVEN (Magneten schuiven van LINKER & RECHTER zijkant naar binnen)
        // Opening zit aan de zijkanten (x-as richting)
        for (sy = [-1, 1]) {
            // Links zij-inloop sleuf (x van -body_width/2 tot -gap_width/2 - inner_wall_t)
            translate([-(body_width/4 + gap_width/4 + inner_wall_t/2), sy * (mag_length/2 + 2), body_depth/2])
                cube([body_width/2 - gap_width/2 - inner_wall_t + 0.1, mag_length + 0.3, mag_width + 0.3], center=true);

            // Rechts zij-inloop sleuf (x van gap_width/2 + inner_wall_t tot body_width/2)
            translate([(body_width/4 + gap_width/4 + inner_wall_t/2), sy * (mag_length/2 + 2), body_depth/2])
                cube([body_width/2 - gap_width/2 - inner_wall_t + 0.1, mag_length + 0.3, mag_width + 0.3], center=true);
        }

        // D. KOPSE KLEM-UITSPARINGEN (Boven & Onder - Grote, robuuste klemzones)
        for (sy = [-1, 1]) {
            translate([0, sy * (ribbon_length/2 + 12.5), body_depth - 1.5])
                cube([gap_width + 20, 22, 4], center=true);
        }

        // E. MIDDENKLEM UITSPARING (Ultra-compacte smalle strip bij z=60mm mark)
        translate([0, 0, body_depth - 1.5])
            cube([gap_width + 8, 6, 4], center=true);

        // F. SCHROEFGATEN VOOR ROBUUSTE KOPSE KLEMMEN (4x M3 per kopse klem)
        for (sy = [-1, 1]) {
            for (sx = [-1, 1]) {
                for (sy_inner = [-1, 1]) {
                    translate([sx * (gap_width/2 + 6), sy * (ribbon_length/2 + 12.5) + sy_inner * 6, 0])
                        cylinder(d=3.5, h=body_depth + 2, $fn=32);
                }
            }
        }

        // G. SCHROEFGATEN VOOR COMPACTE MIDDENKLEM (2x M3)
        for (sx = [-1, 1]) {
            translate([sx * (gap_width/2 + 3.5), 0, 0])
                cylinder(d=3.5, h=body_depth + 2, $fn=32);
        }

        // H. WAVEGUIDE MONTAGEGATEN (6x M3 hitte-insmeltgaten op de voorflens)
        t_hx = (gap_width / 2) + 4.0 + (front_flange_w / 2);
        t_hy = (ribbon_length / 2) + 4.0 + (front_flange_w / 2);

        for (sx = [-1, 1]) {
            for (sy = [-1, 1]) {
                translate([sx * t_hx, sy * t_hy, body_depth - 10])
                    cylinder(d=4.2, h=12, $fn=32);
            }
        }
        for (sy = [-1, 1]) {
            translate([0, sy * t_hy, body_depth - 10])
                cylinder(d=4.2, h=12, $fn=32);
        }
    }
}

// --- MODULE 2: ROBUUSTE KOPSE LINTKLEM STRIP (Boven & Onder) ---
module large_end_clamp() {
    difference() {
        cube([gap_width + 20, 22, 4], center=true);
        // 4x M3 schroefgaten
        for (sx = [-1, 1]) {
            for (sy = [-1, 1]) {
                translate([sx * (gap_width/2 + 6), sy * 6, 0])
                    cylinder(d=3.5, h=6, center=true, $fn=32);
            }
        }
    }
}

// --- MODULE 3: ULTRA-COMPACTE MIDDENKLEM STRIP (TPU) ---
module compact_center_clamp() {
    difference() {
        cube([gap_width + 8, 5, 3], center=true);
        // 2x M3 schroefgaten
        for (sx = [-1, 1]) {
            translate([sx * (gap_width/2 + 3.5), 0, 0])
                cylinder(d=3.5, h=5, center=true, $fn=32);
        }
    }
}

// --- RENDER DRIVER ASSEMBLY ---
ribbon_tweeter_driver_body();

// Losse klemmen ter illustratie naast de behuizing getekend
translate([body_width/2 + 25, 40, 2]) large_end_clamp();
translate([body_width/2 + 25, 0, 1.5]) compact_center_clamp();
translate([body_width/2 + 25, -40, 2]) large_end_clamp();
